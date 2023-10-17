#!/bin/bash

display_help() {
    # taken from https://stackoverflow.com/users/4307337/vincent-stans
    echo "Usage: $0 [option...] {start|stop|restart}" >&2
    echo
    echo "   -h, --help              계정 정보 확인"
    echo "   -l, --log               계정 정보 확인"
    echo "   -c, --company           회사용 git 계정"
    echo "   -i, --individual        개인 git 계정"
    echo "   -f, --freelancer        프리랜서용 git 계정"
    echo
    # echo some stuff here for the -a or --add-options 
    exit 1
}

log() {
    echo
    echo "개인계정: kgggh"
    echo "회사계정: none"
    echo "프리랜서계정: gnnnykim@gmail.com"
    echo
}

function setting() {
    echo "세팅을 시작합니다......"
    local username=$1
    local email=$2
    git config --global user.name "$username" && git config --global user.email "$email"
    echo ""
    echo "------------------반영완료------------------"
    git config user.name && git config user.email 
    echo "--------------------------------------------"
    echo ""
    echo "세팅이 끝났습니다....."
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) display_help; shift ;;
        -l|--log) log; shift ;;
        -c|--company) echo "계정이 없음..."; shift ;;
        -i|--individual) setting kgggh 68227318+kgggh@users.noreply.github.com; shift ;;
        -f|--freelancer) setting geonheee gnnnykim@gmail.com; shift ;;
        # ... (same format for other required arguments)
        *) echo "Unknown parameter passed: $1" ;;
    esac
    shift
done
