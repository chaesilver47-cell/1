#!/usr/bin/env bash
# 프로토타입을 GitHub Pages용 완성 HTML(docs/)로 만든다.
# 아티팩트용 prototype/index.html은 문서 껍데기(<html>, <head>) 없이 쓰여 있어서 여기서 감싸준다.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p docs/wireframe
{
  printf '<!doctype html>\n<html lang="ko">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat onesource/prototype/index.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
cp onesource/wireframe/index.html docs/wireframe/index.html
touch docs/.nojekyll
echo "docs/ 갱신 완료"
