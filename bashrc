function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
GRAY="\[\033[38;5;179m\]"
DIRCOLOR="\[\033[38;5;24m\]"
NO_COLOR="\[\033[0m\]"
ROOT_COLOR="\[\033[38;5;90m\]"

export PS1="[$GRAY\t-$GREEN\u$RED@$DIRCOLOR\h$NO_COLOR]: $YELLOW\w$RED\$(parse_git_branch)$ROOT_COLOR \$ $NO_COLOR"


if brew list | grep coreutils > /dev/null ; then
  PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  alias ls='ls --show-control-chars --color=auto'
  eval `gdircolors -b $HOME/.dir_colors`
fi

alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias ll='ls -la'
alias la='ls -a'
alias cl='archey'

#自定补全git的命令
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#spm设置node路径
export NODE_PATH=/usr/local/lib/node_modules
# 配置 go 的环境
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/goWorkspace
export GOARCH="amd64"
export GOOS="darwin"
export GOBIN=$GOROOT/bin

# 配置 Intellij IDEA 中的goSDK
launchctl setenv GOROOT /usr/local/opt/go/libexec
launchctl setenv GOBIN /usr/local/opt/go/libexec/bin
#launchctl setenv GOPATH /ROOT/www/go


# 配置 Visual Studio Code 打开
code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}
