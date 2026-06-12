from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pathlib import Path
from routers import stories

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


@app.get("/")
def root():
    return {"message": "KidStories API is running"}
