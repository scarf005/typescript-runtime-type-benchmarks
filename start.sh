#!/bin/sh

set -ex

ENV_TYPE=$1

if [ "$ENV_TYPE" = "NODE" ]; then
    RUNTIME_SCRIPT="npm"
    RUNTIME="node"
    RUNTIME_VERSION="${NODE_VERSION:-$(node -v)}"
    RUN_CMD="$RUNTIME_SCRIPT run start"
elif [ "$ENV_TYPE" = "BUN" ]; then
    RUNTIME_SCRIPT="bun"
    RUNTIME="bun"
    RUNTIME_VERSION="${BUN_VERSION:-$(bun -v)}"
    RUN_CMD="$RUNTIME_SCRIPT run start"
elif [ "$ENV_TYPE" = "DENO" ]; then
    RUNTIME_SCRIPT="deno"
    RUNTIME="deno"
    RUNTIME_VERSION="${DENO_VERSION:-$(deno -v)}"
    RUN_CMD="deno run -A --unstable-sloppy-imports index.ts"
else
    echo "Unsupported environment: $ENV_TYPE"
    exit 1
fi

export RUNTIME
export RUNTIME_VERSION

$RUN_CMD

if [ "$ENV_TYPE" = "NODE" ]; then
    $RUN_CMD create-preview-svg
fi
