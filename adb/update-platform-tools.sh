#!/usr/bin/env bash
set -e

PLATFORM="linux"
REPO="https://dl.google.com/android/repository"
REPOXML="${REPO}/repository-11.xml"

fetch_repository_xml() {
  echo "Fetching ${REPOXML}" >&2
  wget -q -O - "$REPOXML"
}

parse_repository_xml() {
  echo "Parsing repository" >&2
  xmlstarlet sel -t -c "//sdk:platform-tool/sdk:archives/sdk:archive[contains(sdk:host-os,'linux')]" | xmlstarlet sel -t -v "//sdk:checksum | //sdk:url"
}

install_platform_tools() {
  local SHA="$1"
  local FILE_NAME="$2"
  local TMPFILE=$(mktemp)

  mkdir -p /opt
  echo "Fetching ${URL}" >&2
  wget -O "$TMPFILE" "${REPO}/${FILE_NAME}"
  echo "Verifying sha1 checksum ${SHA}" >&2
  echo "$SHA  $TMPFILE" | sha1sum -sc

  echo "Removing previous version of platform tools if any" >&2
  rm -rf /opt/platform-tools

  echo "Unpacking platform tools" >&2
  unzip -d /opt "$TMPFILE"
  rm "$TMPFILE"

  echo "Platform tools installed!" >&2
}

install_platform_tools $(fetch_repository_xml | parse_repository_xml)
