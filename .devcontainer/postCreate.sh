#!/usr/bin/env bash

# -e: Exit immediately if any command fails.
# -u: Treat use of unset variables as an error.
# -o pipefail: In a pipeline, fail if any command in the pipeline fails (not just the last one).
set -euo pipefail

# Install Playwright and types:
npm install

# Install Playwright dependencies for chromium:
npx playwright install-deps chromium

# Install the Chromium browser:
npx playwright install chromium

# copy the .env file to the workspace root if one doesn't exist:
if [ ! -f .env ]; then
  cp ./.grading/.env.test .env
fi
