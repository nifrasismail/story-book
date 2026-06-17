from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pathlib import Path
from routers import stories, auth, user, webhooks
from services.supabase import _REST_URL, _ADMIN_HEADERS
import httpx

app = FastAPI(title="KidStories API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

images_dir = Path(__file__).parent / "images"
images_dir.mkdir(exist_ok=True)
(images_dir / "pages").mkdir(exist_ok=True)
app.mount("/images", StaticFiles(directory=images_dir), name="images")

app.include_router(stories.router, prefix="/stories", tags=["stories"])
app.include_router(auth.router, prefix="/auth", tags=["auth"])
app.include_router(user.router, prefix="/user", tags=["user"])
app.include_router(webhooks.router, prefix="/webhooks", tags=["webhooks"])


@app.get("/")
def root():
    return {"message": "KidStories API is running"}


@app.get("/config/")
async def get_config():
    async with httpx.AsyncClient() as client:
        r = await client.get(
            f"{_REST_URL}/app_config?key=eq.ads_enabled&select=value",
            headers=_ADMIN_HEADERS,
        )
    if r.status_code == 200 and r.json():
        ads_enabled = r.json()[0]["value"] == "true"
    else:
        ads_enabled = True
    return {"ads_enabled": ads_enabled}
