"""
Supabase Admin client — all calls go through the service_role key (server-side only).
Never expose service_role to the Flutter client.
"""
import os
import httpx

SUPABASE_URL = os.environ["SUPABASE_URL"]
SUPABASE_SERVICE_KEY = os.environ["SUPABASE_SERVICE_KEY"]

_AUTH_URL = f"{SUPABASE_URL}/auth/v1"
_REST_URL = f"{SUPABASE_URL}/rest/v1"

_ADMIN_HEADERS = {
    "apikey": SUPABASE_SERVICE_KEY,
    "Authorization": f"Bearer {SUPABASE_SERVICE_KEY}",
    "Content-Type": "application/json",
}


async def sign_up(email: str, password: str, display_name: str | None) -> dict:
    async with httpx.AsyncClient() as client:
        resp = await client.post(
            f"{_AUTH_URL}/admin/users",
            headers=_ADMIN_HEADERS,
            json={
                "email": email,
                "password": password,
                "email_confirm": True,
                "user_metadata": {"display_name": display_name or ""},
            },
        )
        _raise(resp)
        user = resp.json()

        # create profile row
        await _upsert_profile(client, user["id"], email, display_name)

        # generate a session for immediate login after signup
        session = await _create_session(client, email, password)
        return {**session, "display_name": display_name}


async def login(email: str, password: str) -> dict:
    async with httpx.AsyncClient() as client:
        resp = await client.post(
            f"{_AUTH_URL}/token?grant_type=password",
            headers=_ADMIN_HEADERS,
            json={"email": email, "password": password},
        )
        _raise(resp)
        data = resp.json()
        display_name = data.get("user", {}).get("user_metadata", {}).get("display_name")
        return {
            "access_token": data["access_token"],
            "refresh_token": data["refresh_token"],
            "user_id": data["user"]["id"],
            "email": data["user"]["email"],
            "display_name": display_name,
        }


async def refresh_session(refresh_token: str) -> dict:
    async with httpx.AsyncClient() as client:
        resp = await client.post(
            f"{_AUTH_URL}/token?grant_type=refresh_token",
            headers=_ADMIN_HEADERS,
            json={"refresh_token": refresh_token},
        )
        _raise(resp)
        data = resp.json()
        display_name = data.get("user", {}).get("user_metadata", {}).get("display_name")
        return {
            "access_token": data["access_token"],
            "refresh_token": data["refresh_token"],
            "user_id": data["user"]["id"],
            "email": data["user"]["email"],
            "display_name": display_name,
        }


async def get_user_from_token(access_token: str) -> dict | None:
    async with httpx.AsyncClient() as client:
        resp = await client.get(
            f"{_AUTH_URL}/user",
            headers={**_ADMIN_HEADERS, "Authorization": f"Bearer {access_token}"},
        )
        if resp.status_code != 200:
            return None
        return resp.json()


async def get_profile(user_id: str) -> dict | None:
    async with httpx.AsyncClient() as client:
        resp = await client.get(
            f"{_REST_URL}/user_profiles?user_id=eq.{user_id}&select=*",
            headers={**_ADMIN_HEADERS, "Accept": "application/json"},
        )
        _raise(resp)
        rows = resp.json()
        return rows[0] if rows else None


async def upsert_profile_data(user_id: str, data: dict) -> None:
    async with httpx.AsyncClient() as client:
        resp = await client.post(
            f"{_REST_URL}/user_profiles",
            headers={
                **_ADMIN_HEADERS,
                "Prefer": "resolution=merge-duplicates",
            },
            json={"user_id": user_id, **data},
        )
        _raise(resp)


async def set_entitlements(user_id: str, has_premium: bool, has_no_ads: bool) -> None:
    async with httpx.AsyncClient() as client:
        resp = await client.post(
            f"{_REST_URL}/user_profiles",
            headers={**_ADMIN_HEADERS, "Prefer": "resolution=merge-duplicates"},
            json={
                "user_id": user_id,
                "has_premium_pack": has_premium,
                "has_removed_ads": has_no_ads,
            },
        )
        _raise(resp)


# ── helpers ────────────────────────────────────────────────────────────────────

async def _upsert_profile(client: httpx.AsyncClient, user_id: str, email: str, display_name: str | None) -> None:
    await client.post(
        f"{_REST_URL}/user_profiles",
        headers={**_ADMIN_HEADERS, "Prefer": "resolution=merge-duplicates"},
        json={
            "user_id": user_id,
            "email": email,
            "display_name": display_name or "",
            "total_stars": 0,
            "current_streak": 0,
            "longest_streak": 0,
            "completed_story_ids": [],
            "favourite_story_ids": [],
            "unlocked_badge_ids": [],
            "has_premium_pack": False,
            "has_removed_ads": False,
        },
    )


async def _create_session(client: httpx.AsyncClient, email: str, password: str) -> dict:
    resp = await client.post(
        f"{_AUTH_URL}/token?grant_type=password",
        headers=_ADMIN_HEADERS,
        json={"email": email, "password": password},
    )
    _raise(resp)
    data = resp.json()
    return {
        "access_token": data["access_token"],
        "refresh_token": data["refresh_token"],
        "user_id": data["user"]["id"],
        "email": data["user"]["email"],
    }


def _raise(resp: httpx.Response) -> None:
    if resp.status_code >= 400:
        try:
            detail = resp.json().get("msg") or resp.json().get("message") or resp.text
        except Exception:
            detail = resp.text
        raise httpx.HTTPStatusError(detail, request=resp.request, response=resp)
