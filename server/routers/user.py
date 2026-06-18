from fastapi import APIRouter, HTTPException, Header
from models.user import SyncRequest, UserProfile
import services.supabase as db

router = APIRouter()


async def _resolve_user(authorization: str) -> tuple[str, str]:
    token = authorization.removeprefix("Bearer ").strip()
    user = await db.get_user_from_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    return user["id"], user["email"]


@router.get("/profile", response_model=UserProfile)
async def get_profile(authorization: str = Header(...)):
    user_id, email = await _resolve_user(authorization)
    profile = await db.get_profile(user_id)
    if not profile:
        # Auto-create profile for users who signed up before table existed
        await db.upsert_profile_data(user_id, {"email": email})
        profile = await db.get_profile(user_id)
    return profile


@router.post("/sync")
async def sync_progress(body: SyncRequest, authorization: str = Header(...)):
    user_id, email = await _resolve_user(authorization)
    await db.upsert_profile_data(user_id, {"email": email, **body.model_dump()})
    return {"message": "Synced"}
