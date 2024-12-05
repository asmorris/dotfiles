# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/andrewmorrison/.oh-my-zsh"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval $(thefuck --alias)
eval "$(starship init zsh)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
eval "$(/opt/homebrew/bin/brew shellenv)"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias reload!=". ~/.zshrc && echo 'ZSH config related from ~/.zshrc'"
alias zsh="nvim ~/.zshrc"
alias ship="nvim ~/.config/starship.toml"
alias hosts="nvim ~/etc/hosts"
alias rls="colorls"
# alias rails='bin/rails'
alias co="git switch"
alias gipu="git push -u origin"
alias gia="git add -A; git commit -m"
alias gp='git push'
alias gs='git status'
alias be='bundle exec'
alias gist='git checkout staging; git pull'
alias prune='git remote prune origin && git branch -r | awk '"'"'{print $1}'"'"' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias regist='git checkout develop; git pull'
alias recop="{ git diff HEAD --name-only --diff-filter=MA & git diff origin/develop..HEAD --name-only --diff-filter=MA; } | sort | uniq | grep -v -e 'db/schema.rb' -e 'db/data_schema.rb' | grep '**.rb' | xargs rubocop -c .rubocop.yml -A"
alias tags="ctags -R -f ./.git/tags ."
alias vimrc="vim ~/.vimrc"
alias conf="nvim ~/.config/nvim"
alias hsconf="nvim ~/.hammerspoon/init.lua"
alias tconf="nvim ~/.tmux.conf"
alias creds="EDITOR=nvim bin/rails credentials:edit"
alias tools="nvim .tool-versions"
alias nv="nvim"
alias lg="lazygit"
alias kp="killport"
alias p='pnpm'
alias y='yarn'
alias yd='yarn dev'
alias rs='bin/rails s'
alias rc='bin/rails c'
alias redstart='redis-server --daemonize yes'
alias restore='git restore --staged'
alias godev='git stash; co dev; git pull; git stash pop'
alias py='python3'
alias activate='source venv/bin/activate'
alias ber="be rspec"

function killport() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

function copy-line () {
  rg --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print $3}' | sed 's/^\s+//' | pbcopy
}

function open-at-line () {
  nvim $(rg --line-number . | fzf --delimiter ':' --preview 'bat --color=always --highlight-line {2} {1}' | awk -F ':' '{print "+"$2" "$1}')
}
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

# vim keybindings
bindkey -v
# avoid the annoying backspace/delete issue 
# where backspace stops deleting characters
bindkey -v '^?' backward-delete-char
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
source $ZSH/oh-my-zsh.sh
source ~/Desktop/workspace/zsh-z-master/zsh-z.plugin.zsh
zstyle ':completion:*' menu select


plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="/usr/local/opt/libpq/bin:$PATH"
export EDITOR="nvim"
export BUNDLER_EDITOR="nvim"
export OPENAI_API_KEY="NICE_TRY_COPPERS"
export TERM=xterm-256color
# Not sure if I will need this, but good to remember if necessary. Used for rust. Might need to use on terminal restart
# export source "$HOME/.cargo/env"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# bun completions
[ -s "/Users/andrewmorrison/.bun/_bun" ] && source "/Users/andrewmorrison/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

source <(fzf --zsh)
