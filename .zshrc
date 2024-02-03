#---------------------#
#  プロンプトの表示設定  #
#---------------------#
source ~/.git-prompt.sh

# addされていない変更がある場合は`*`
# commitされていない変更がある場合は`+`を表示
GIT_PS1_SHOWDIRTYSTATE=true

# stashがある場合は`$`を表示
GIT_PS1_SHOWSTASHSTATE=true

# addされていない新規ファイルがある場合は`%`を表示
GIT_PS1_SHOWUNTRACKEDFILES=true

# HEADとそのupstreamの違いを表示
# `<`: 遅れている
# `>`: 進んでいる
# `=`: 差がない
GIT_PS1_SHOWUPSTREAM='auto'

git_color() {
  local git_info="$(__git_ps1 "%s")"
  if [[ $git_info == *"*"* ]] || [[ $git_info == *"+"* ]] || [[ $git_info == *"$"* ]] || [[ $git_info == *"%"* ]]; then
    echo '%F{003}'
  else
    echo '%F{green}'
  fi
}

git_prompt() {
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = true ]; then 
    setopt PROMPT_SUBST ; PS1='%F{069}%~%f$(git_color)$(__git_ps1 " (%s)")%f %# '
  else
    PROMPT='%F{069}%~%f %# '
  fi
}

precmd() {
  git_prompt
}

#-------------------#
#  モジュールの有効化  #
#-------------------#
autoload -Uz colors && colors

#-------#
#  nvm  #
#-------#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#------------#
#  homebrew  #
#------------#
export PATH=/opt/homebrew/bin:$PATH

if type brew &>/dev/null; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#-------#
#  gpg  #
#-------#
export GPG_TTY=$TTY

#--------------#
#  lsの表示設定  #
#--------------#
# 色をつける
alias ls='ls -G'
