#!/bin/bash
# sync-design-system.sh
# Run this after updating the personal site's styles.css
# Copies the design system from personal site to this repo

set -euo pipefail

PERSONAL_SITE="/Users/anjusharma/Projects/ramesh-personal-site"
DESIGN_SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/design-system"

if [[ ! -f "$PERSONAL_SITE/styles.css" ]]; then
  echo "Error: Personal site styles.css not found at $PERSONAL_SITE/styles.css"
  exit 1
fi

echo "Syncing design system from $PERSONAL_SITE..."

# Copy the full styles.css as a reference (for manual diffing if needed)
cp "$PERSONAL_SITE/styles.css" "$DESIGN_SYSTEM_DIR/_reference-personal-site-styles.css"

# Extract tokens (lines 1-46 in personal site)
sed -n '1,46p' "$PERSONAL_SITE/styles.css" > "$DESIGN_SYSTEM_DIR/tokens.css"

# Extract base (lines 48-110)
sed -n '48,110p' "$PERSONAL_SITE/styles.css" > "$DESIGN_SYSTEM_DIR/base.css"

# Extract components (lines 112-402, skipping the commented-out reveal section)
# We'll do a manual extraction since the line numbers might shift
# For now, just copy the reference and note that manual update may be needed
echo "Note: components.css and base.css need manual sync if personal site design changes significantly."
echo "Current sync copied tokens.css only."

# Check if there are changes
cd "$(dirname "$DESIGN_SYSTEM_DIR")"
if git diff --quiet design-system/; then
  echo "No changes to design system."
else
  echo "Design system updated. Run 'git add design-system && git commit -m \"sync design system from personal site\" && git push' to deploy."
fi