#!/bin/bash

# 진단할 대상 도메인 입력 받기
echo -n "🌐 진단할 웹사이트 주소를 입력하세요 (예: google.com): "
read target

# 입력값이 없을 경우 기본값 설정
if [ -z "$target" ]; then
    target="google.com"
fi

echo -e "\n----------------------------------------"
echo "[1] 외부 서버 연결 상태 점검 ($target)"
echo "----------------------------------------"

# grep : nslookup 결과에서 "Address" 키워드가 포함된 라인만 필터링
echo "1. DNS 조회 결과:"
nslookup "$target" | grep "Address" | tail -n +2

echo -e "\n2. Ping 응답 속도 측정:"

# 윈도우(한글/영어)와 리눅스 모두 호환되도록 수정
# grep -E "time=|시간=|ms|TTL" : 응답 시간(ms)이나 TTL이 있으면 성공으로 판단 (호환성 강화)
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    ping -n 3 "$target" | iconv -f CP949 -t UTF-8 2>/dev/null | grep -a -E "time=|시간=|ms|TTL"
    if [ ${PIPESTATUS[1]} -ne 0 ]; then
         ping -n 3 "$target" | grep -a -E "time=|시간=|ms|TTL"
    fi
else
    ping -c 3 "$target" | grep -E "time=|ms"
fi

# 연결 성공 여부 확인
if [ $? -eq 0 ]; then
    echo ">> 결과: 서버 연결 성공 ✅"
else
    echo ">> 결과: 서버 연결 실패 ❌"
fi

echo -e "\n----------------------------------------"
echo "[2] 로컬 시스템 포트 점유 현황 (Listening)"
echo "----------------------------------------"
echo " 프로토콜 |      로컬 주소      |   상태  "

# awk : netstat 결과 재가공
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Windows Git Bash용 (상태: 4번째 열)
    netstat -an | grep "LISTEN" | awk '{printf "   %-5s  |   %-15s   |   %s\n", $1, $2, $4}' | head -n 5
else
    # Linux용 (상태: 6번째 열)
    netstat -an | grep "LISTEN" | awk '{printf "   %-5s  |   %-15s   |   %s\n", $1, $2, $6}' | head -n 5
fi

echo "========================================"