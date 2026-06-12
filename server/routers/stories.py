import json
from pathlib import Path
from fastapi import APIRouter, HTTPException, Request

router = APIRouter()

DATA_DIR = Path(__file__).parent.parent / "data"
STORIES_FILE = DATA_DIR / "stories.json"
PAGES_DIR = DATA_DIR / "pages"
IMAGES_DIR = Path(__file__).parent.parent / "images"
PAGE_IMAGES_DIR = IMAGES_DIR / "pages"

# Metadata cached at startup — home screen never hits disk after first load
_stories_cache: list[dict] | None = None


def _get_stories() -> list[dict]:
    global _stories_cache
    if _stories_cache is None:
        with open(STORIES_FILE) as f:
            _stories_cache = json.load(f)
    return _stories_cache


def _load_pages(story_id: str, request: Request) -> list[dict]:
    pages_file = PAGES_DIR / f"{story_id}.json"
    if not pages_file.exists():
        return []
    with open(pages_file) as f:
        pages = json.load(f)
    base = str(request.base_url).rstrip("/")
    for i, page in enumerate(pages):
        img = PAGE_IMAGES_DIR / story_id / f"page_{i}.png"
        if img.exists():
            page["image_url"] = f"{base}/images/pages/{story_id}/page_{i}.png"
    return pages


def _with_image_url(story: dict, request: Request) -> dict:
    image_file = IMAGES_DIR / f"{story['id']}.png"
    if image_file.exists():
        base = str(request.base_url).rstrip("/")
        return {**story, "cover_image_url": f"{base}/images/{story['id']}.png"}
    return story


@router.get("/")
def list_stories(request: Request, category: str = None, is_premium: bool = None):
    """Returns metadata only — no pages. Fast for the home screen."""
    stories = _get_stories()
    if category:
        stories = [s for s in stories if s["category"] == category]
    if is_premium is not None:
        stories = [s for s in stories if s["is_premium"] == is_premium]
    return [_with_image_url(s, request) for s in stories]


@router.get("/{story_id}")
def get_story(story_id: str, request: Request):
    """Returns metadata + pages for a single story. Pages loaded on demand."""
    stories = _get_stories()
    story = next((s for s in stories if s["id"] == story_id), None)
    if not story:
        raise HTTPException(status_code=404, detail="Story not found")
    return {
        **_with_image_url(story, request),
        "pages": _load_pages(story_id, request),
    }
