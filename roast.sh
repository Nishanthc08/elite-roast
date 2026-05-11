#!/bin/bash

# roast.sh - because my terminal was too polite
# written by Nishanth C when he got tired of boring error messages
# github: https://github.com/Nishanthc08

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# load the roast database
# roasts.sh should be in the same folder as this file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/roasts.sh" ]]; then
    source "$SCRIPT_DIR/roasts.sh"
else
    echo "roasts.sh not found in $SCRIPT_DIR, roasting will be boring"
fi

# checks if you just fat-fingered a real command
suggest_correction() {
    local cmd="$1"

    declare -A typo_map=(
        ["gti"]="git"         ["got"]="git"          ["gut"]="git"
        ["gi"]="git"          ["gitt"]="git"         ["igt"]="git"
        ["pythoon"]="python"  ["pythn"]="python"     ["pyhton"]="python"
        ["pyton"]="python"    ["pytho"]="python"     ["pyhon"]="python"
        ["pyhton3"]="python3"
        ["pipp"]="pip"        ["piip"]="pip"
        ["lss"]="ls"          ["sl"]="ls"            ["ks"]="ls"
        ["cdd"]="cd"          ["dc"]="cd"            ["dcd"]="cd"
        ["catt"]="cat"        ["caht"]="cat"
        ["grpe"]="grep"       ["gerp"]="grep"        ["grp"]="grep"
        ["mak"]="make"        ["mkae"]="make"        ["maek"]="make"
        ["chmdo"]="chmod"     ["cmod"]="chmod"       ["chomd"]="chmod"
        ["suod"]="sudo"       ["sduo"]="sudo"        ["suudo"]="sudo"
        ["eixt"]="exit"       ["exti"]="exit"        ["exxit"]="exit"
        ["claer"]="clear"     ["clera"]="clear"
        ["mkdri"]="mkdir"     ["mkdr"]="mkdir"       ["mkdirr"]="mkdir"
        ["touuch"]="touch"    ["tuch"]="touch"
        ["vmi"]="vim"         ["iv"]="vi"
        ["mvo"]="mv"          ["cpo"]="cp"
        ["whcih"]="which"     ["wihch"]="which"
        ["hsitory"]="history" ["histroy"]="history"
        ["ecoh"]="echo"       ["ehco"]="echo"
        ["atp"]="apt"         ["tpa"]="apt"          ["aptt"]="apt"
        ["systemclt"]="systemctl" ["systmectl"]="systemctl"
        ["clur"]="curl"       ["crul"]="curl"
        ["wegt"]="wget"       ["wgett"]="wget"       ["weget"]="wget"
        ["shs"]="ssh"
        ["nmpa"]="nmap"       ["namp"]="nmap"
        ["naon"]="nano"
        ["les"]="less"
        ["fnd"]="find"        ["fnid"]="find"
        ["tial"]="tail"       ["tali"]="tail"
        ["tpo"]="top"         ["htpo"]="htop"
        ["kil"]="kill"        ["klil"]="kill"
        ["manl"]="man"        ["mna"]="man"
    )

    if [[ -n "${typo_map[$cmd]}" ]]; then
        echo "${typo_map[$cmd]}"
        return
    fi

    local prefix="${cmd:0:2}"
    compgen -c | grep "^${prefix}" | sort -u | head -3 | tr '\n' ' ' 2>/dev/null
}

# fires every time you type something bash doesn't recognize
command_not_found_handle() {
    local cmd="$1"
    shift
    local args="$*"

    local failures=0
    [[ -f "/tmp/roast_failures_${UID}" ]] && failures=$(cat /tmp/roast_failures_${UID})
    echo $((failures + 1)) > /tmp/roast_failures_${UID}

    echo ""
    echo -e "${RED}-- aye what did you type --${NC}"
    echo ""
    echo -e "   ${YELLOW}you typed :${NC} ${CYAN}'${cmd}${args:+ $args}'${NC}"
    echo -e "   ${RED}bash says :${NC} not a thing"
    echo ""

    local roast=${UNKNOWN_CMD_INSULTS[$RANDOM % ${#UNKNOWN_CMD_INSULTS[@]}]}
    echo -e "   ${PURPLE}$roast${NC}"
    echo ""

    local suggestion
    suggestion=$(suggest_correction "$cmd")
    if [[ -n "$suggestion" ]]; then
        echo -e "   ${GREEN}did you mean: ${BOLD}$suggestion${NC}${GREEN} ?${NC}"
        echo ""
    fi

    # 30% chance of an extra kick
    if [[ $((RANDOM % 10)) -lt 3 ]]; then
        local extra=${UNKNOWN_EXTRAS[$RANDOM % ${#UNKNOWN_EXTRAS[@]}]}
        echo -e "   ${BLUE}$extra${NC}"
        echo ""
    fi

    echo -e "   ${RED}failures today: $((failures + 1))${NC}"
    echo -e "${RED}----------------------------${NC}"
    echo ""

    return 127
}
export -f command_not_found_handle 2>/dev/null

# little desi spice thrown on top of failures
get_desi_roast() {
    # 20% chance
    if [[ $((RANDOM % 5)) -eq 0 ]]; then
        local extra=${DESI_EXTRAS[$RANDOM % ${#DESI_EXTRAS[@]}]}
        echo -e "\n   ${PURPLE}$extra${NC}"
    fi

    local hour
    hour=$(date +%H)
    if [[ $hour -ge 14 && $hour -le 16 ]]; then
        echo -e "   ${YELLOW}filter coffee time bro, step away from the keyboard for 10 mins${NC}"
    elif [[ $hour -ge 20 ]]; then
        echo -e "   ${BLUE}night coding again aa? swalpa rest maadi, you're making more mistakes than usual${NC}"
    fi
}

# picks the right roast category and fires
roast_em() {
    local command="$1"
    local exit_code="$2"
    local error_output="$3"

    get_desi_roast "$command" "$exit_code" "$error_output"

    if [[ "$command" == git* ]]; then
        if [[ "$command" == git\ status* || "$command" == git\ push* || "$command" == git\ pull* ]]; then
            echo -e "git repo illa here, modalu 'git init' maadu bro, basics first"
        elif [[ "$command" == *"push --force"* ]]; then
            echo -e "force push to main?? idu sari alla guru, baere yaaraadroo keltaare"
        else
            echo -e "${GIT_INSULTS[$RANDOM % ${#GIT_INSULTS[@]}]}"
        fi
        return
    fi

    if [[ "$command" == python* || "$command" == pip* || "$command" == *".py"* ]]; then
        if [[ "$error_output" == *"IndentationError"* ]]; then
            echo -e "spaces vs tabs bro, pick one and commit, just like you can't commit to good code"
        elif [[ "$error_output" == *"ImportError"* ]]; then
            echo -e "module illa, modalu pip install maadu da, then come back and try again"
        elif [[ "$error_output" == *"SyntaxError"* ]]; then
            echo -e "syntax error, moola python kooda sariyagi baralla ansutte, en maadodu"
        else
            echo -e "${PYTHON_INSULTS[$RANDOM % ${#PYTHON_INSULTS[@]}]}"
        fi
        return
    fi

    if [[ "$command" == ssh* || "$command" == ping* || "$command" == curl* || "$command" == wget* || "$command" == nmap* || "$command" == netstat* ]]; then
        if [[ "$error_output" == *"Connection refused"* ]]; then
            echo -e "connection refused, server kooda WFH maadthide today, adjust maadi"
        elif [[ "$error_output" == *"Permission denied"* ]]; then
            echo -e "permission denied, nimma key sari illa, check maadi once"
        elif [[ "$error_output" == *"Name or service not known"* ]]; then
            echo -e "DNS broke, internet idya guru?? cable ond saari nodu"
        else
            echo -e "${NETWORK_INSULTS[$RANDOM % ${#NETWORK_INSULTS[@]}]}"
        fi
        return
    fi

    if [[ "$command" == sudo* || "$command" == apt* || "$command" == rm* || "$command" == chmod* || "$command" == systemctl* ]]; then
        if [[ "$command" == *"rm -rf"* && "$command" != *"--no-preserve-root"* ]]; then
            echo -e "en guru!! companyne bedva?? kelasa bekaa?? resume update maadi already bro"
        elif [[ "$command" == *"chmod 777"* ]]; then
            echo -e "chmod 777 aa?? security is not optional da, idenu maadthiya seriously"
        elif [[ "$exit_code" -eq 126 ]]; then
            echo -e "system itself protecting from you, and honestly fair enough"
        else
            echo -e "${LINUX_INSULTS[$RANDOM % ${#LINUX_INSULTS[@]}]}"
        fi
        return
    fi

    echo -e "${GENERIC_INSULTS[$RANDOM % ${#GENERIC_INSULTS[@]}]}"
}

# wraps the actual command and roasts on failure
execute() {
    local original_command="$*"
    local cmd="$1"
    shift

    echo -e "${BLUE}>${NC} ${CYAN}$original_command${NC}"

    [[ "$cmd" == "git" ]] && export GIT_PAGER=cat

    command "$cmd" "$@"
    local exit_code=$?

    if [[ $exit_code -ne 0 ]]; then
        echo ""
        echo -e "${BOLD}${RED}aye it broke:${NC}"
        echo -e "   command   : ${YELLOW}$original_command${NC}"
        echo -e "   exit code : ${RED}$exit_code${NC}"
        echo -e "   verdict   : $(roast_em "$original_command" "$exit_code" "")"
        echo ""

        [[ $exit_code -eq 139 ]] && echo -e "   ${PURPLE}segfault!! system crash maadthiya?? ayyoo${NC}"

        local failures=0
        [[ -f "/tmp/roast_failures_${UID}" ]] && failures=$(cat /tmp/roast_failures_${UID})
        echo -e "   ${RED}failures today: $((failures + 1))${NC}"
        echo $((failures + 1)) > /tmp/roast_failures_${UID}

    else
        if [[ "$original_command" == *"git commit"* ]]; then
            echo -e "${GREEN}committed. swalpa better aagthiddeya, keep going${NC}"
        elif [[ "$original_command" == git* ]]; then
            echo -e "${GREEN}git worked. code yeno survive maadthide, don't ask how${NC}"
        elif [[ "$original_command" == python* ]]; then
            echo -e "${GREEN}python ran. go get filter coffee, you earned it${NC}"
        elif [[ "$original_command" == ls* || "$original_command" == pwd* || "$original_command" == echo* ]]; then
            echo -e "${GREEN}ok. moola kelasa aythu at least, small win${NC}"
        else
            echo -e "${GREEN}worked. super maga, do it again without breaking it${NC}"
        fi

        [[ -f "/tmp/roast_failures_${UID}" ]] && echo "0" > "/tmp/roast_failures_${UID}"
    fi

    echo ""
    return $exit_code
}

# sets up aliases
setup_roast_aliases() {
    alias git='execute git'
    alias python='execute python'
    alias pip='execute pip'
    alias ssh='execute ssh'
    alias curl='execute curl'
    alias wget='execute wget'
    alias sudo='execute sudo'
    alias apt='execute apt'
    alias systemctl='execute systemctl'
    alias nmap='execute nmap'
    alias ping='execute ping'
    # loaded silently
}

# how bad is today
roast_stats() {
    if [[ -f "/tmp/roast_failures_${UID}" ]]; then
        local failures
        failures=$(cat /tmp/roast_failures_${UID})
        echo -e "${RED}failures today: $failures  --  nakkan lee, en guru idu${NC}"
    else
        echo -e "${GREEN}no failures. super guru, or just not trying anything?${NC}"
    fi
}

roast_help() {
    echo -e "${BOLD}roast.sh - namma oorina style terminal${NC}"
    echo ""
    echo -e "  ${CYAN}setup_roast_aliases${NC}  - turn on roasting for git, python, pip, etc"
    echo -e "  ${CYAN}execute <cmd>${NC}        - run any command with roast on failure"
    echo -e "  ${CYAN}roast_stats${NC}          - see how badly today went"
    echo -e "  ${CYAN}roast_help${NC}           - you're looking at it"
    echo ""
    echo -e "${YELLOW}both files needed: roast.sh and roasts.sh in the same folder${NC}"
    echo ""
    echo -e "${YELLOW}to make it permanent, add to ~/.bashrc:${NC}"
    echo -e "  source /path/to/roast.sh"
    echo -e "  setup_roast_aliases"
}
