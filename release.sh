#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# KidStories – Google Play Release Script
# Usage:
#   ./release.sh                   → builds + uploads to internal track
#   ./release.sh --track alpha     → uploads to alpha track
#   ./release.sh --track production → uploads to production
#   ./release.sh --build-only      → builds AAB only, skips upload
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ── Colours ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

log()  { echo -e "${CYAN}[KidStories]${NC} $*"; }
ok()   { echo -e "${GREEN}[✓]${NC} $*"; }
warn() { echo -e "${YELLOW}[!]${NC} $*"; }
fail() { echo -e "${RED}[✗]${NC} $*"; exit 1; }

# ── Defaults ─────────────────────────────────────────────────────────────────
TRACK="internal"
BUILD_ONLY=false
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Parse args ────────────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    --track)      TRACK="$2"; shift 2 ;;
    --build-only) BUILD_ONLY=true; shift ;;
    --help|-h)
      echo "Usage: ./release.sh [--track internal|alpha|beta|production] [--build-only]"
      exit 0 ;;
    *) fail "Unknown argument: $1" ;;
  esac
done

echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}  KidStories · Google Play Release${NC}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

cd "$SCRIPT_DIR"

# ── 1. Pre-flight checks ──────────────────────────────────────────────────────
log "Running pre-flight checks..."

# Flutter
FLUTTER_CMD=""
for candidate in \
    "$(which flutter 2>/dev/null)" \
    "$HOME/flutter/bin/flutter" \
    "/Volumes/ex/flutter/bin/flutter" \
    "$HOME/fvm/default/bin/flutter"; do
  if [[ -x "$candidate" ]]; then
    FLUTTER_CMD="$candidate"
    break
  fi
done
[[ -z "$FLUTTER_CMD" ]] && fail "Flutter not found. Add it to PATH or set FLUTTER_PATH."
ok "Flutter: $FLUTTER_CMD"

# Play Store key (only needed for upload)
if [[ "$BUILD_ONLY" == false ]]; then
  if [[ -z "${PLAY_STORE_JSON_KEY:-}" ]]; then
    DEFAULT_KEY="$SCRIPT_DIR/secrets/play_store_key.json"
    if [[ -f "$DEFAULT_KEY" ]]; then
      export PLAY_STORE_JSON_KEY="$DEFAULT_KEY"
      ok "Play Store key: $DEFAULT_KEY"
    else
      fail "PLAY_STORE_JSON_KEY not set and no key found at secrets/play_store_key.json.
       → Set it:  export PLAY_STORE_JSON_KEY=/path/to/key.json
       → Or place it at: $SCRIPT_DIR/secrets/play_store_key.json"
    fi
  else
    ok "Play Store key: $PLAY_STORE_JSON_KEY"
  fi

  # Fastlane
  if ! command -v fastlane &>/dev/null; then
    warn "fastlane not found. Attempting gem install..."
    gem install fastlane --no-document || fail "Could not install fastlane. Run: gem install fastlane"
  fi
  ok "fastlane: $(fastlane --version 2>/dev/null | head -1)"
fi

# Keystore for signing
if [[ -z "${KEYSTORE_PATH:-}" ]]; then
  DEFAULT_KS="$SCRIPT_DIR/secrets/kidstories-release.jks"
  if [[ -f "$DEFAULT_KS" ]]; then
    export KEYSTORE_PATH="$DEFAULT_KS"
    ok "Keystore: $KEYSTORE_PATH"
  else
    fail "KEYSTORE_PATH not set and no keystore found at secrets/kidstories-release.jks.

  Create a keystore (first time only):
    keytool -genkey -v -keystore secrets/kidstories-release.jks \\
      -keyalg RSA -keysize 2048 -validity 10000 \\
      -alias kidstories

  Required env vars:
    KEYSTORE_PATH      – path to your .jks keystore
    KEYSTORE_ALIAS     – key alias inside the keystore
    KEYSTORE_PASSWORD  – keystore password
    KEY_PASSWORD       – key password"
  fi
fi
[[ -z "${KEYSTORE_ALIAS:-}"    ]] && fail "KEYSTORE_ALIAS is not set"
[[ -z "${KEYSTORE_PASSWORD:-}" ]] && fail "KEYSTORE_PASSWORD is not set"
[[ -z "${KEY_PASSWORD:-}"      ]] && fail "KEY_PASSWORD is not set"

# ── 2. Bump version ───────────────────────────────────────────────────────────
log "Reading current version from pubspec.yaml..."
CURRENT_VERSION=$(grep '^version:' pubspec.yaml | awk '{print $2}')
VERSION_NAME="${CURRENT_VERSION%+*}"
VERSION_CODE="${CURRENT_VERSION#*+}"
NEW_VERSION_CODE=$((VERSION_CODE + 1))

echo -e "  Current : ${YELLOW}${VERSION_NAME}+${VERSION_CODE}${NC}"
echo -e "  New code: ${GREEN}${VERSION_NAME}+${NEW_VERSION_CODE}${NC}"
echo ""

read -r -p "$(echo -e "${CYAN}Bump version code to ${NEW_VERSION_CODE}? [Y/n]:${NC} ")" BUMP_CONFIRM
BUMP_CONFIRM="${BUMP_CONFIRM:-Y}"
if [[ "$BUMP_CONFIRM" =~ ^[Yy]$ ]]; then
  sed -i '' "s/^version: .*/version: ${VERSION_NAME}+${NEW_VERSION_CODE}/" pubspec.yaml
  ok "Version bumped to ${VERSION_NAME}+${NEW_VERSION_CODE}"
else
  warn "Keeping version at ${CURRENT_VERSION}"
fi

# ── 3. Write signing config ───────────────────────────────────────────────────
log "Configuring signing..."
ANDROID_SDK_DIR="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
FLUTTER_SDK_DIR="$(dirname "$(dirname "$FLUTTER_CMD")")"

cat > android/local.properties << EOF
sdk.dir=${ANDROID_SDK_DIR}
flutter.sdk=${FLUTTER_SDK_DIR}
EOF

cat > android/key.properties << EOF
storeFile=${KEYSTORE_PATH}
storePassword=${KEYSTORE_PASSWORD}
keyAlias=${KEYSTORE_ALIAS}
keyPassword=${KEY_PASSWORD}
EOF
ok "Signing config written"

# ── 4. Flutter build AAB ──────────────────────────────────────────────────────
log "Building release AAB..."
"$FLUTTER_CMD" clean
"$FLUTTER_CMD" pub get
"$FLUTTER_CMD" build appbundle \
  --release \
  --dart-define=FLUTTER_BUILD_MODE=release

AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
[[ -f "$AAB_PATH" ]] || fail "AAB not found at $AAB_PATH"
AAB_SIZE=$(du -sh "$AAB_PATH" | cut -f1)
ok "AAB built: $AAB_PATH ($AAB_SIZE)"

if [[ "$BUILD_ONLY" == true ]]; then
  echo ""
  ok "Build-only mode — skipping upload."
  echo -e "  AAB ready at: ${BOLD}$AAB_PATH${NC}"
  exit 0
fi

# ── 5. Upload to Google Play via fastlane ────────────────────────────────────
echo ""
log "Uploading to Google Play (track: ${BOLD}${TRACK}${NC})..."
echo ""

fastlane android deploy track:"$TRACK"

# ── 6. Done ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
ok "KidStories v${VERSION_NAME}+${NEW_VERSION_CODE} uploaded to ${TRACK} track!"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "  Next steps:"
echo "  1. Open Google Play Console and promote from ${TRACK} → production"
echo "  2. Add screenshots if not already uploaded"
echo "  3. Submit for review"
echo ""
