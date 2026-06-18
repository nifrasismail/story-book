import json
import os
from pathlib import Path
from fastapi import APIRouter, HTTPException

router = APIRouter()

DATA_DIR = Path(__file__).parent.parent / "data"
STORIES_FILE = DATA_DIR / "stories.json"
PAGES_DIR = DATA_DIR / "pages"

GCS_BASE = os.environ.get(
    "GCS_IMAGES_BASE",
    "https://storage.googleapis.com/kidstories-images",
)

# Metadata cached at startup — home screen never hits disk after first load
_stories_cache: list[dict] | None = None

# Which page images exist — built once from data dir so no disk hit per request
_page_image_index: dict[str, set[int]] = {}


def _get_stories() -> list[dict]:
    global _stories_cache
    if _stories_cache is None:
        with open(STORIES_FILE) as f:
            _stories_cache = json.load(f)
    return _stories_cache


def _cover_url(story_id: str) -> str:
    return f"{GCS_BASE}/covers/{story_id}.png"


def _page_url(story_id: str, page_idx: int) -> str:
    return f"{GCS_BASE}/pages/{story_id}/page_{page_idx}.png"


def _load_pages(story_id: str) -> list[dict]:
    pages_file = PAGES_DIR / f"{story_id}.json"
    if not pages_file.exists():
        return []
    with open(pages_file) as f:
        pages = json.load(f)
    for i, page in enumerate(pages):
        page["image_url"] = _page_url(story_id, i)
    return pages


def _with_cover(story: dict) -> dict:
    return {**story, "cover_image_url": _cover_url(story["id"])}


@router.get("/")
def list_stories(category: str = None, is_premium: bool = None):
    stories = _get_stories()
    if category:
        stories = [s for s in stories if s["category"] == category]
    if is_premium is not None:
        stories = [s for s in stories if s["is_premium"] == is_premium]
    return [_with_cover(s) for s in stories]


@router.get("/{story_id}")
def get_story(story_id: str):
    stories = _get_stories()
    story = next((s for s in stories if s["id"] == story_id), None)
    if not story:
        raise HTTPException(status_code=404, detail="Story not found")
    return {
        **_with_cover(story),
        "pages": _load_pages(story_id),
    }
