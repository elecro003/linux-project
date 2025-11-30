#!/bin/bash

NET_TOOL="./network-tool.sh"
GIT_TOOL="./git-tool.sh"

C_CALC="./scripts/c_calculator.sh".
WORD_FINDER="./scripts/word_finder.sh"

# 실행 권한 부여 함수 (모든 스크립트에 권한 주기)
function set_permissions() {
    # 2>/dev/null은 에러 메시지(파일 없음 등)를 숨기는 역할
    chmod +x "$NET_TOOL" "$GIT_TOOL" "$C_CALC" "$WORD_FINDER" 2>/dev/null
}

# 초기화 실행
set_permissions

while true
do
    clear
    echo "=========================================="
    echo "       Linux Team Project Launcher     "
    echo "=========================================="
    echo "1. 네트워크 진단 도구"
    echo "2. Git 히스토리 분석 도구"
    echo "3. C언어 계산기 (c_calculator)"
    echo "4. 단어 찾기 (word_finder)"
    echo "0. 종료"
    echo "=========================================="
    echo -n "실행할 기능을 선택하세요: "
    read choice

    echo ""
    case $choice in
        1)
            if [ -f "$NET_TOOL" ]; then
                $NET_TOOL
            else
                echo "오류: $NET_TOOL 파일이 없습니다."
            fi
            ;;
        2)
            if [ -f "$GIT_TOOL" ]; then
                $GIT_TOOL
            else
                echo "오류: $GIT_TOOL 파일이 없습니다."
            fi
            ;;
        3)
            if [ -f "$C_CALC" ]; then
                $C_CALC
            else
                echo "오류: $C_CALC 파일을 찾을 수 없습니다."
                echo "현재 위치: $(pwd)"
                echo "파일 목록: $(ls -R scripts/)" # 디버깅용
            fi
            ;;
        4)
           if [ -f "$WORD_FINDER" ]; then
                echo -n "🔍 검색할 단어를 입력하세요: "
                read search_word
                
                if [ -z "$search_word" ]; then
                    echo "⚠️ 검색어를 입력하지 않았습니다."
                else
                    # 입력받은 단어를 스크립트의 인자($1)로 전달
                    $WORD_FINDER "$search_word"
                fi
            else
                echo "오류: $WORD_FINDER 파일을 찾을 수 없습니다."
            fi
            ;;
        0)
            echo "프로그램을 종료합니다."
            exit 0
            ;;
        *)
            echo "잘못된 입력입니다."
            ;;
    esac
    
    echo ""
    read -p "엔터를 누르면 메뉴로 돌아갑니다..."
done