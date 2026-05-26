#!/bin/bash

[ -z "$1" ] && { echo "Usage: $0 <OUTPUT_DIR>"; exit 1; }

OUTPUT_DIR="$1"
[[ "$OUTPUT_DIR" == "/" ]] || OUTPUT_DIR=${1%/}

if [[ -f "$OUTPUT_DIR" ]]; then
	echo "Error: OUTPUT_DIR '$OUTPUT_DIR' is a file, please choose a directory." >&2
	exit 1
fi

mkdir -p "$OUTPUT_DIR"

OUTPUT_DIR="$(readlink -f "$OUTPUT_DIR")"

# check if OUTPUT_DIR is system directory, if so, exit with error
if [[ "$OUTPUT_DIR" == "/" || "$OUTPUT_DIR" == "/etc" \
	 || "$OUTPUT_DIR" == "/proc" || "$OUTPUT_DIR" == "/sys" || "$OUTPUT_DIR" == "/dev" \
	 || "$OUTPUT_DIR" == /proc/* || "$OUTPUT_DIR" == /sys/* || "$OUTPUT_DIR" == /dev/* \
	 || "$OUTPUT_DIR" == "/bin" || "$OUTPUT_DIR" == "/sbin" || "$OUTPUT_DIR" == "/usr" || "$OUTPUT_DIR" == "/lib" || "$OUTPUT_DIR" == "/usr/lib" ]]; then
	echo "Error: OUTPUT_DIR '$OUTPUT_DIR' is a system directory, please choose another directory." >&2
	exit 1
fi

TMP_DIR="$(readlink -f /tmp)"

# check alpine:3.23 image is available, if not pull it
if ! docker image inspect alpine:3.23 > /dev/null 2>&1; then
	echo "Pulling alpine:3.23 image..."
	docker pull alpine:3.23 || exit 1
fi

docker rm -f openwrt-apk-builder > /dev/null 2>&1 || true

docker run -d --name openwrt-apk-builder \
	-v "${TMP_DIR}:${TMP_DIR}:ro" \
	-v "${OUTPUT_DIR}:${OUTPUT_DIR}:rw" \
	alpine:3.23 \
	tail -f /dev/null
