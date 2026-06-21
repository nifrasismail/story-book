from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
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


_PRIVACY_HTML = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Privacy Policy — KidStories</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      background: #FFF9F0;
      color: #2D3748;
      line-height: 1.7;
    }
    header {
      background: linear-gradient(135deg, #FF6B35 0%, #FF9A6C 100%);
      color: #fff;
      padding: 48px 24px 36px;
      text-align: center;
    }
    header .emoji { font-size: 52px; display: block; margin-bottom: 12px; }
    header h1 { font-size: 28px; font-weight: 800; letter-spacing: -0.5px; }
    header p  { margin-top: 6px; font-size: 14px; opacity: 0.88; }
    main {
      max-width: 760px;
      margin: 0 auto;
      padding: 40px 24px 80px;
    }
    .card {
      background: #fff;
      border-radius: 16px;
      padding: 28px 32px;
      margin-bottom: 20px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.06);
    }
    h2 {
      font-size: 18px;
      font-weight: 700;
      color: #FF6B35;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    p  { font-size: 15px; color: #4A5568; margin-bottom: 10px; }
    p:last-child { margin-bottom: 0; }
    ul { padding-left: 20px; margin-bottom: 10px; }
    li { font-size: 15px; color: #4A5568; margin-bottom: 6px; }
    a  { color: #FF6B35; text-decoration: none; }
    a:hover { text-decoration: underline; }
    .updated {
      text-align: center;
      font-size: 13px;
      color: #A0AEC0;
      margin-top: 32px;
    }
    footer {
      text-align: center;
      padding: 24px;
      font-size: 13px;
      color: #A0AEC0;
      border-top: 1px solid #EEE;
    }
  </style>
</head>
<body>

<header>
  <span class="emoji">📚</span>
  <h1>Privacy Policy</h1>
  <p>KidStories &mdash; Magical Stories for Little Minds</p>
</header>

<main>

  <div class="card">
    <h2>👋 Overview</h2>
    <p>KidStories ("we", "our", or "us") is committed to protecting the privacy of children and their families. This policy explains what information we collect, how we use it, and the choices you have.</p>
    <p>KidStories is designed for children under 13. We comply with the <strong>Children's Online Privacy Protection Act (COPPA)</strong> and the <strong>Google Play Families Policy</strong>.</p>
  </div>

  <div class="card">
    <h2>🔍 Information We Collect</h2>
    <p><strong>We do not collect any personally identifiable information from children.</strong> Specifically, we do not collect names, email addresses, phone numbers, photos, or location data.</p>
    <p>We may collect the following non-personal, anonymous data to improve the app:</p>
    <ul>
      <li>App crash reports and performance diagnostics (via Firebase Crashlytics)</li>
      <li>Anonymous usage analytics such as screens viewed and stories read (via Firebase Analytics)</li>
      <li>In-app purchase records processed securely by Google Play and RevenueCat</li>
    </ul>
  </div>

  <div class="card">
    <h2>📖 How We Use Information</h2>
    <ul>
      <li>To deliver and improve the story content and app experience</li>
      <li>To process purchases and restore entitlements</li>
      <li>To send optional daily reading reminder notifications (can be disabled in device settings)</li>
      <li>To detect and fix technical issues</li>
    </ul>
    <p>We do not sell, rent, or share any data with third parties for marketing purposes.</p>
  </div>

  <div class="card">
    <h2>📢 Advertising</h2>
    <p>The free version of KidStories displays ads served by <strong>Google AdMob</strong>. AdMob is configured to serve <strong>child-directed ads only</strong>, which disables interest-based advertising and remarketing for all users of this app.</p>
    <p>Purchasing the Premium Pack removes all ads permanently.</p>
  </div>

  <div class="card">
    <h2>🔔 Notifications</h2>
    <p>With your permission, KidStories sends a daily reminder to read a bedtime story. You can disable notifications at any time from your device's Settings &rarr; Apps &rarr; KidStories &rarr; Notifications.</p>
  </div>

  <div class="card">
    <h2>🔒 Data Security</h2>
    <p>All communication between the app and our servers is encrypted using HTTPS/TLS. We do not store any personal information on our servers. Story content and anonymous analytics are the only data handled by our backend.</p>
  </div>

  <div class="card">
    <h2>👨‍👩‍👧 Parental Rights (COPPA)</h2>
    <p>As a parent or legal guardian, you have the right to:</p>
    <ul>
      <li>Review what data (if any) has been collected from your child</li>
      <li>Request deletion of any data associated with your child's device</li>
      <li>Refuse further collection of data</li>
    </ul>
    <p>To exercise these rights, contact us at <a href="mailto:nifrasismail@gmail.com">nifrasismail@gmail.com</a>.</p>
  </div>

  <div class="card">
    <h2>🌍 Third-Party Services</h2>
    <p>KidStories integrates the following third-party SDKs, each governed by their own privacy policies:</p>
    <ul>
      <li><a href="https://policies.google.com/privacy" target="_blank">Google AdMob</a> &mdash; child-directed ad serving</li>
      <li><a href="https://firebase.google.com/support/privacy" target="_blank">Firebase Analytics &amp; Crashlytics</a> &mdash; anonymous analytics and crash reporting</li>
      <li><a href="https://www.revenuecat.com/privacy" target="_blank">RevenueCat</a> &mdash; in-app purchase management</li>
      <li><a href="https://supabase.com/privacy" target="_blank">Supabase</a> &mdash; backend infrastructure</li>
    </ul>
  </div>

  <div class="card">
    <h2>✏️ Changes to This Policy</h2>
    <p>We may update this Privacy Policy from time to time. Changes will be posted at this URL. We encourage parents to review this page periodically. Continued use of the app after changes constitutes acceptance of the updated policy.</p>
  </div>

  <div class="card">
    <h2>📬 Contact Us</h2>
    <p>If you have any questions or concerns about this Privacy Policy, please contact us:</p>
    <p><strong>Email:</strong> <a href="mailto:nifrasismail@gmail.com">nifrasismail@gmail.com</a></p>
  </div>

  <p class="updated">Last updated: June 21, 2025</p>

</main>

<footer>
  &copy; 2025 KidStories. All rights reserved.
</footer>

</body>
</html>"""


@app.get("/privacy", response_class=HTMLResponse)
def privacy_policy():
    return HTMLResponse(content=_PRIVACY_HTML)


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
