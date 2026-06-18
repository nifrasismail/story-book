"""
Shared GCS upload helper used by generate_covers.py and generate_page_images.py.
Requires: pip install google-cloud-storage  (already available via uv)
Usage: just import upload_to_gcs — it no-ops gracefully if credentials are missing.
"""
import os
from pathlib import Path

GCS_BUCKET = os.environ.get("GCS_BUCKET", "kidstories-images")


def upload_to_gcs(local_path: Path, gcs_object: str) -> bool:
    """
    Upload local_path to gs://{GCS_BUCKET}/{gcs_object}.
    Returns True on success, False on any error.
    """
    try:
        from google.cloud import storage
        client = storage.Client()
        bucket = client.bucket(GCS_BUCKET)
        blob = bucket.blob(gcs_object)
        blob.upload_from_filename(str(local_path), content_type="image/png")
        print(f"  ☁  uploaded → gs://{GCS_BUCKET}/{gcs_object}")
        return True
    except ImportError:
        print("  ⚠  google-cloud-storage not installed — skipping GCS upload")
        return False
    except Exception as e:
        print(f"  ⚠  GCS upload failed: {e}")
        return False
