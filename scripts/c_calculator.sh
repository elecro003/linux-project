#!/bin/bash

# C 계산기 자동 컴파일
gcc src/calculator.c -o calculator.out 2> /dev/null

if [ $? -ne 0 ]; then
  echo "❌ calculator.c 컴파일 오류!"
  exit 1
fi

clear
echo "=============================="
echo "      🧮 C 계산기 실행"
echo "=============================="

./calculator.out

echo