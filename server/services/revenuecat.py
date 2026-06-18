"""
RevenueCat webhook verification and entitlement mapping.
Docs: https://www.revenuecat.com/docs/integrations/webhooks
"""
import hashlib
import hmac
import os

REVENUECAT_WEBHOOK_SECRET = os.environ.get("REVENUECAT_WEBHOOK_SECRET", "")

# RevenueCat entitlement identifiers — match what you set in RC dashboard
ENTITLEMENT_PREMIUM = "premium"
ENTITLEMENT_NO_ADS = "no_ads"

# Events that grant access
_GRANT_EVENTS = {
    "INITIAL_PURCHASE",
    "RENEWAL",
    "PRODUCT_CHANGE",
    "UNCANCELLATION",
    "BILLING_ISSUE_RESOLVED",
}

# Events that revoke access
_REVOKE_EVENTS = {
    "CANCELLATION",
    "EXPIRATION",
    "BILLING_ISSUE",
    "SUBSCRIBER_ALIAS",
}


def verify_signature(payload: bytes, signature_header: str) -> bool:
    if not REVENUECAT_WEBHOOK_SECRET:
        return True  # skip verification in dev if secret not set
    expected = hmac.new(
        REVENUECAT_WEBHOOK_SECRET.encode(),
        payload,
        hashlib.sha256,
    ).hexdigest()
    return hmac.compare_digest(expected, signature_header)


def parse_event(body: dict) -> tuple[str | None, bool, bool]:
    """
    Returns (user_id, has_premium, has_no_ads).
    user_id is the app_user_id set by the Flutter app (should be Supabase user_id).
    """
    event = body.get("event", {})
    event_type = event.get("type", "")
    user_id = event.get("app_user_id")
    entitlements: list[str] = list(event.get("entitlement_ids", []) or [])

    is_grant = event_type in _GRANT_EVENTS
    is_revoke = event_type in _REVOKE_EVENTS

    if not (is_grant or is_revoke):
        return user_id, False, False

    has_premium = ENTITLEMENT_PREMIUM in entitlements and is_grant
    has_no_ads = ENTITLEMENT_NO_ADS in entitlements and is_grant

    return user_id, has_premium, has_no_ads
