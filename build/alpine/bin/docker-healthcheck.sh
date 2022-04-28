#!/bin/bash

set -eo pipefail

host="127.0.0.1"
port="${PORT:-80}"
url="http://${host}:${port}"

url=`curl http://${host}:${port} -L -I -o /dev/null -w %{url_effective}`
statusCode=`curl -I $url 2>/dev/null | head -n 1 | cut -d$' ' -f2`
successCode=200

if [ "$statusCode" = "$successCode" ]; then
	exit 0
fi

exit 1
