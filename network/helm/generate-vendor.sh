#!/bin/bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
  printf 'Usage: %s SOURCE_DIR OUTPUT_DIR\n' "$0" >&2
  exit 1
fi

SOURCE_DIR=$(realpath "$1")
OUTPUT_DIR=$(realpath "$2")

if [ ! -d "$SOURCE_DIR" ] || [ ! -f "$SOURCE_DIR/go.mod" ]; then
  printf 'Invalid source directory: %s\n' "$SOURCE_DIR" >&2
  exit 1
fi

if [ ! -d "$OUTPUT_DIR" ]; then
  printf 'Invalid output directory: %s\n' "$OUTPUT_DIR" >&2
  exit 1
fi

case "$(basename "$SOURCE_DIR")" in
  helm-?*) VERSION=${SOURCE_DIR##*/helm-} ;;
  *)
    printf 'Source directory must be named helm-VERSION: %s\n' "$SOURCE_DIR" >&2
    exit 1
    ;;
esac

command -v go >/dev/null 2>&1 || {
  printf 'go not found\n' >&2
  exit 1
}

cd "$SOURCE_DIR"
GOTOOLCHAIN=local GOWORK=off GOFLAGS=-mod=readonly go mod vendor
tar --sort=name --mtime=@0 --owner=0 --group=0 --numeric-owner \
  -cf - vendor | gzip -n > "$OUTPUT_DIR/helm-$VERSION-vendor.tar.gz"

printf 'Created: %s\n' "$OUTPUT_DIR/helm-$VERSION-vendor.tar.gz"
