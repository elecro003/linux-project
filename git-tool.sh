#!/bin/bash

# Git 프로젝트 히스토리 분석 도구
# 기능: 커밋 로그 포맷팅 출력 및 파일 수정 빈도 통계 분석

# 예외 처리: 현재 폴더가 Git 저장소인지 확인
if [ ! -d ".git" ]; then
    echo "❌ 오류: 현재 폴더는 Git 저장소가 아닙니다."
    echo "   Git init이 된 프로젝트 폴더에서 실행해주세요."
    exit 1
fi

# 현재 브랜치 정보 출력
current_branch=$(git branch --show-current)
echo -e "📌 현재 브랜치 : \033[1;32m$current_branch\033[0m"

# [상호작용] 사용자로부터 확인할 커밋 개수 입력 받기
echo -n "🔍 최근 커밋을 몇 개 확인할까요? (숫자 입력): "
read count

# 입력값이 없을 경우 기본값 5 설정
if [ -z "$count" ]; then
    count=5
fi

echo -e "\n--- 🕒 최근 커밋 로그 ($count개) ---"
# --pretty=format을 사용하여 [날짜] 작성자 : 내용 형식으로 깔끔하게 출력
git log -n "$count" --pretty=format:"%C(yellow)[%cd]%Creset %C(cyan)%an%Creset : %s" --date=short

echo -e "\n\n----------------------------------------"
echo "🏆 [통계] 프로젝트에서 가장 많이 수정된 파일 TOP 3"
echo "----------------------------------------"
git log --name-only --format="" | sort | uniq -c | sort -nr | head -n 3
echo "========================================"