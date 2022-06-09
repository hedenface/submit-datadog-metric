#!/bin/bash

function usage()
{
  echo "Usage:"
  echo ""
  echo "${0} -m <metric name> -v <metric value> -T <metric type> -t <ts> [tag1:value1] [tag2:value2] ..."
  echo ""
  echo "    -m REQUIRED"
  echo "    -v REQUIRED"
  echo "    -T optional, default: 0"
  echo "    -t optional, default: now"
  echo ""
  echo "    -h show help and exit"
  echo ""
  echo "    tag:value optional"
  echo ""
  exit 1
}

function generate_tags ()
{
  tags=""

  if [ $# -eq 0 ]; then
    return
  fi

  tags="tags: ["

  for arg in "$@"; do
    tags="${tags} \"${arg}\","
  done

  tags=$(echo $tags | sed 's/,$//')
  tags="${tags} ]"
}

while getopts "m:v:T:t:h" flag; do
  case "$flag" in
    m) metric=$OPTARG ;;
    v) value=$OPTARG  ;;
    T) type=$OPTARG   ;;
    t) ts=$OPTARG     ;;
    h) usage          ;;
  esac
done

if [ "x$metric" = "x" ] || [ "x$value" = "x" ]; then
  usage
fi

shift $(( $OPTIND - 1 ))

generate_tags $@

DD_SITE=${DD_SITE:-api.datadoghq.com}
type=${type:-0}
ts=${ts:-$(date +%s)}

echo "metric: [$metric]"
echo "value: [$value]"
echo "type: [$type]"
echo "ts: [$ts]"
echo "tags: [$tags]"

curl -X POST "https://${DD_SITE}/api/v2/series" \
  -H "Content-Type: application/json" \
  -H "DD-API-KEY: ${DD_API_KEY}" \
  -d @- << EOF
{
  "series": [
    {
      "metric": "${metric}",
      "type": ${type},
      "points": [
        {
          "timestamp": ${ts},
          "value": ${value}
        }
      ]
      ${tags}
    }
  ]
}
EOF
