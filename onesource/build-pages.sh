#!/usr/bin/env bash
# 1) prototype/index.html(원본 소스) → prototype/publish.html(아티팩트에 올리는 파일)
#    페이지가 "복제본 이름 붙이기" 때 자기 자신을 다시 저장할 수 있도록, 소스 전체를 SELF_T에 넣는다.
# 2) publish.html → docs/index.html (GitHub Pages용 완성 HTML)
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - <<'PY'
import json
src = open("onesource/prototype/index.html", encoding="utf8").read()
assert src.count("__SELF__") == 1, "SELF placeholder must appear exactly once"
lit = json.dumps(src, ensure_ascii=False).replace("<", "\\u003c")
open("onesource/prototype/publish.html", "w", encoding="utf8").write(src.replace("__SELF__", lit, 1))
PY
mkdir -p docs/wireframe
{
  printf '<!doctype html>\n<html lang="ko">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat onesource/prototype/publish.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
cp onesource/wireframe/index.html docs/wireframe/index.html
touch docs/.nojekyll
echo "publish.html, docs/ 갱신 완료"
