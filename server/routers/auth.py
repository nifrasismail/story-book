from fastapi import APIRouter, HTTPException, Header
from models.auth import SignUpRequest, LoginRequest, TokenResponse, RefreshRequest
import services.supabase as db
import httpx

router = APIRouter()


@router.post("/signup", response_model=TokenResponse)
async def signup(body: SignUpRequest):
    try:
        result = await db.sign_up(body.email, body.password, body.display_name)
        return result
    except httpx.HTTPStatusError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/login", response_model=TokenResponse)
async def login(body: LoginRequest):
    try:
        result = await db.login(body.email, body.password)
        return result
    except httpx.HTTPStatusError:
        raise HTTPException(status_code=401, detail="Invalid email or password")


@router.post("/refresh", response_model=TokenResponse)
async def refresh(body: RefreshRequest):
    try:
        result = await db.refresh_session(body.refresh_token)
        return result
    except httpx.HTTPStatusError:
        raise HTTPException(status_code=401, detail="Invalid or expired refresh token")


@router.post("/logout")
async def logout(authorization: str = Header(...)):
    # Tokens are stateless JWTs — client just discards them.
    # Supabase Admin can revoke if needed; for now just acknowledge.
    return {"message": "Logged out"}


@router.get("/me")
async def me(authorization: str = Header(...)):
    token = authorization.removeprefix("Bearer ").strip()
    user = await db.get_user_from_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    profile = await db.get_profile(user["id"])
    if not profile:
        await db.upsert_profile_data(user["id"], {"email": user["email"]})
        profile = await db.get_profile(user["id"])
    return profile or {"user_id": user["id"], "email": user["email"]}
