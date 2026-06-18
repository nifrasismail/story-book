from fastapi import APIRouter, HTTPException, Header, Request
import services.revenuecat as rc
import services.supabase as db

router = APIRouter()


@router.post("/revenuecat")
async def revenuecat_webhook(
    request: Request,
    x_revenuecat_signature: str = Header(default=""),
):
    payload = await request.body()

    if not rc.verify_signature(payload, x_revenuecat_signature):
        raise HTTPException(status_code=401, detail="Invalid webhook signature")

    body = await request.json()
    user_id, has_premium, has_no_ads = rc.parse_event(body)

    if not user_id:
        return {"message": "Event ignored — no user_id"}

    event_type = body.get("event", {}).get("type", "")

    # Only update if it's an actionable event
    if event_type in rc._GRANT_EVENTS | rc._REVOKE_EVENTS:
        await db.set_entitlements(user_id, has_premium, has_no_ads)

    return {"message": f"Processed {event_type}"}
