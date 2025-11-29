#!/bin/bash

# 네트워크 상태 및 연결 진단 도구
# 기능: DNS 조회, Ping 테스트, 포트 스캔 자동화

# [상호작용] 진단할 대상 도메인 입력 받기
echo -n "🌐 진단할 웹사이트 주소를 입력하세요 (예: google.com): "
read target

# 입력값이 없을 경우 기본값 설정
if [ -z "$target" ]; then
    target="google.com"
fi

echo -e "\n[1] DNS 정보 조회 ($target)"
# nslookup 결과 중 'Address'가 포함된 줄만 필터링하되, 첫 번째 줄(내 DNS 서버)은 제외
nslookup "$target" | grep "Address" | tail -n +2

echo -e "\n[2] 서버 응답 속도 테스트 (Ping)"
# Ping을 3번만 수행하고, 결과 중 'time=' 이 있는 줄만 보여줌
ping -c 3 "$target" | grep "time="

if [ $? -eq 0 ]; then
    echo "👉 상태: 연결 양호 ✅"
else
    echo "👉 상태: 연결 불안정 ❌"
fi

echo "----------------------------------------"

# 로컬 포트 스캔 (Listening Port)
echo "[3] 현재 열려있는 포트 목록 (Top 5)"
echo " 프로토콜 |     로컬 주소     | 상태"

# VS Code Git Bash 환경 호환성을 위해 -an 옵션 사용
netstat -an | grep "LISTEN" | awk '{printf "   %-5s  |  %-15s  | %s\n", $1, $2, $6}' | head -n 5

echo "========================================"