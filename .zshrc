# Options section
setopt correct                           # Auto correct mistakes
setopt extendedglob                      # Extended globbing, allows using regular expressions with *
setopt nocaseglob                        # Case insensitive globbing
setopt rcexpandparam                     # Array expansion with parameters
setopt nocheckjobs                       # Don't warn about running processes when exiting
setopt numericglobsort                   # Sort filenames numerically when it makes sense
setopt nobeep                            # No beep
setopt appendhistory                     # Immediately append history instead of overwriting
setopt histignorealldups                 # If a new command is a duplicate, remove the older one
setopt autocd                            # If only directory path is entered, cd there
setopt promptsubst                       # Enable prompt substitution

# History Setup
HISTFILE=~/.zhistory
HISTSIZE=5000000
SAVEHIST=5000000

# Set up zstyle configurations
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Granular control when navigating and editing text
WORDCHARS=${WORDCHARS//\/[&.;]}

# Prepare for Theming
autoload -U compinit colors zcalc  # Load functions only when first called
compinit -d                        # Initialize completion system, create dump file
colors                             # Enable color support
setopt prompt_subst                # Allow dynamic elements in the prompt
zmodload zsh/terminfo              # Load module for terminal capability information

# Prompt
# Primary prompt
NEWLINE=$'\n'
# PROMPT='%(!.%F{red}%f%K{red}%F{white} 🌶 %n %k%F{red}%f%F{blue}%f%K{blue}%F{white} 🖿 %9/ %k%F{blue}%f${NEWLINE}󱞩 .%F{magenta}%f%K{magenta}%F{white} 🕵 %n %k%F{magenta}%f%F{blue}%f%K{blue}%F{white} 🖿 %9/ %k%F{blue}%f${NEWLINE}󱞩 )'
# Right-side prompt
# RPROMPT='%F{cyan}%f%K{cyan}%F{black}⏲ %T%   󰂎 $(acpi | grep -o "[0-9]*%")%%f%k%F{cyan}%f'

PROMPT='%(!.%F{red}🮈%f%K{red}%F{white} ☠️ %n %k%F{red}%f%F{blue}🮈%f%K{blue}%F{white} 📂 %9/ %k%F{blue}%f${NEWLINE}%F{blue}󱞩%f .%F{magenta}🮈%f%K{magenta}%F{white} 👻 %n %k%F{magenta}%f%F{blue}🮈%f%K{blue}%F{white} 📂 %9/ %k%F{blue}%f${NEWLINE}%F{blue}󱞩%f )'
# Right-side prompt
RPROMPT='%F{cyan}%f%F{cyan}⏰ %T ▫️ ⚡ $(acpi | grep -o "[0-9]*%")% %F{cyan}%f'

# Export Section

## General
export EDITOR=/usr/bin/nano
export VISUAL=/usr/bin/nano
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export SHELL=/usr/bin/zsh
export PATH="/home/$USER/bin:$PATH"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

## Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Alias Section
alias cp="cp -i"                        # Confirm before overwriting something
alias df='df -h'                        # Human-readable sizes
alias free='free -m'                    # Show sizes in MB
alias ls='ls -Alh --color=auto --group-directories-first'
alias cmatrix='cmatrix -b -a -s'
alias reflect='sudo reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# Plugins Sourcing and Setup

## First Plugin: zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Second Plugin: zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#50493e,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

## Third Plugin: zsh-history-substring-search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'


## Keybindings section

# Set default Emacs key bindings
bindkey -e

# Home key bindings
bindkey '^[[7~' beginning-of-line             # Home key (variant 1)
bindkey '^[[H' beginning-of-line              # Home key (variant 2)
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line  # Home key (terminfo)
fi

# End key bindings
bindkey '^[[8~' end-of-line                   # End key (variant 1)
bindkey '^[[F' end-of-line                    # End key (variant 2)
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line     # End key (terminfo)
fi

# Other special keys
bindkey '^[[2~' overwrite-mode                # Insert key
bindkey '^[[3~' delete-char                   # Delete key
bindkey '^[[C' forward-char                   # Right arrow key
bindkey '^[[D' backward-char                  # Left arrow key
bindkey '^[[5~' history-beginning-search-backward  # Page Up key
bindkey '^[[6~' history-beginning-search-forward  # Page Down key

# Ctrl+Arrow keys for word navigation
bindkey '^[Oc' forward-word                   # Ctrl+Right Arrow (variant 1)
bindkey '^[Od' backward-word                  # Ctrl+Left Arrow (variant 1)
bindkey '^[[1;5D' backward-word               # Ctrl+Left Arrow (variant 2)
bindkey '^[[1;5C' forward-word                # Ctrl+Right Arrow (variant 2)

# History substring search
bindkey '^[[A' history-substring-search-up    # Up arrow key for history substring search
bindkey '^[[B' history-substring-search-down  # Down arrow key for history substring search

# Other useful keybindings
bindkey '^H' backward-kill-word               # Ctrl+Backspace to delete previous word
bindkey '^[[Z' undo                           # Shift+Tab to undo last action

# Icons Helper
# right devider 
# left devider 
# right circle  
# left circle  
# right soft devider 
# left soft devider 
# trapezoid right 
# trapezoid left 
# hard devider right 
# hard devider left 
# lower left triangle 
# lower right triangle 
# upper left triangle 
# upper right triangle 
# battery 󰁹 full or 󰂎 empty
# clock 󱑌 or  or ⏲
# bomb 󰚑
# plug 󰚥
# folder 🗁
# disk 🖴
# head 🕵
# hot 🌶
