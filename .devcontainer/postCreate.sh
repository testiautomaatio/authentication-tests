#!/usr/bin/env bash

# -e: Exit immediately if any command fails.
# -u: Treat use of unset variables as an error.
# -o pipefail: In a pipeline, fail if any command in the pipeline fails (not just the last one).
set -euo pipefail

# install package dependencies:
npm install

# install the chromium browser for Playwright:
npx playwright install chromium --with-deps

# copy the .env file to the workspace root if one doesn't exist:
if [ ! -f .env ]; then
  cp ./.github/.env.test .env
fi
