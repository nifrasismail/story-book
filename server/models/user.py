from pydantic import BaseModel


class UserProfile(BaseModel):
    user_id: str
    email: str
    display_name: str | None = None
    total_stars: int = 0
    current_streak: int = 0
    longest_streak: int = 0
    last_read_date: str | None = None
    completed_story_ids: list[str] = []
    favourite_story_ids: list[str] = []
    unlocked_badge_ids: list[str] = []
    has_premium_pack: bool = False
    has_removed_ads: bool = False


class SyncRequest(BaseModel):
    total_stars: int
    current_streak: int
    longest_streak: int
    last_read_date: str | None = None
    completed_story_ids: list[str]
    favourite_story_ids: list[str]
    unlocked_badge_ids: list[str]
