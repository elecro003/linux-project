#!/bin/bash

keyword="$1"

# 인자(검색어) 체크
if [ -z "$keyword" ]; then
  echo "사용법: ./word_finder.sh <검색어>"
  exit 1
fi

echo "======================================"
echo " 🔍 코드 분석 – 단어 검색: '$keyword'"
echo "======================================"

# .git 제외하고 전체 파일 재귀 검색
grep -Rni --exclude-dir=.git "$keyword" .

# 검색 결과 없음
if [ $? -ne 0 ]; then
  echo "❌ '$keyword' 를 포함한 코드가 없습니다."
fi

echo