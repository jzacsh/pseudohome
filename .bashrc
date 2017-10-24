# shell opts
shopt -s cdspell
shopt -s extglob
shopt -s histverify
shopt -s histappend
shopt -s no_empty_cmd_completion
# not in bash3: shopt -s dirspell
set -o notify
set -o histexpand
set -o vi

# disable control character echoing
stty -ctlecho

# disable XON/XOFF flow control ("freeze" via ^q, ^s)
stty -ixon

# history options
export HISTIGNORE="&:ls:[bf]g:exit:hg in:hg out:reset:clear:ca:cl:l:cd*"
export HISTFILESIZE=20000
export HISTCONTROL='ignoreboth'
export HISTSIZE=5000

if [[ -r ~/.dircolors ]] && type dircolors >/dev/null 2>&1;then
  eval $(dircolors --bourne-shell ~/.dircolors)
fi

PROMPT_COMMAND='RET=$?' # see: man bash | less +/PROMPT_COMMAND
PS1='\s^$RET  @\t \w\n\u@\h   $SHLVL:\$ ' # vcprompt-less version of below
############################################################################
# $UID > 0 BELOW THIS LINE
#   everything above *should* be plain old shell options, nothing executable
[[ "$UID" -ne "0" ]] || return 0

# end partial-fork of ~/.bashrc ############################################

# aliases #####################
# not in bash3: alias ls='ls --color'
alias ls='CLICOLOR= ls'

alias l='ls -laFH'
alias la='ls -aFH'
alias ca='clear; ls -laFH'
alias cl='clear; ls -lFH'
alias mi="curl -s http://checkip.dyndns.com | sed -e 's/^.*Address:\ //' -e 's/<\/body.*//'"
alias json='python -mjson.tool'
alias grep='grep --color=auto'
# most commonly I'd like to convert: decimal <=> hex
alias tohex="printf '0x%x\n'"
alias fromhex="printf '%0.0f\n'"
alias httpserve='python3 -m http.server'
alias les=less


baseFromTo() (
  local quiet=0
  if [[ "$#" = 4 ]];then
    [[ "$1" = -q ]] || {
      printf 'usage: [-q] FROM TO FROM_VALUE\n' >&2
      return 1;
    }
    shift; quiet=1;
  fi
  local fro="$1"
  local to="$2"
  shift 2
  (( quiet )) || set -x
  printf -- 'obase=%d; ibase=%d; %s\n' "$to" "$fro" "${*^^}"  | bc
)

# end partial-fork of ~/.bash_aliases ######################################

alias vi="vi -u "$PSEUDOHOME"/.vimrc"
export PATH="$PSEUDOHOME"/bin:"$PATH"

# so i can save proper git work without modifying shared-PC git configs
alias pastie="curl -F 'clbin=<-' https://clbin.com"
gitmail() ( git format-patch --root "${1:-HEAD}" --stdout; )
