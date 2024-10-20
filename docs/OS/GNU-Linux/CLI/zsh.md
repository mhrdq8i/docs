# ZSH

## oh-my-zsh

**[oh-my-zsh]** official website

### Themes

#### Customize RobbyRussel theme

> vim ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

```sh
# Set the left prompt (includes Git info and current directory)
PROMPT='$(git_prompt_info) %{$fg[cyan]%}%c%{$reset_color%} %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$reset_color%}'

# Set the right prompt (displays CPU and memory usage)
RPROMPT='%{$fg[magenta]%}CPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '"'"'{print 100 - $1"%"}'"'"') | MEM: $(free -m | awk '"'"'/Mem:/ {print $3"MB"}'"'"')%{$reset_color%}'

# Git prompt configurations
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
```
<!-- links -->
[oh-my-zsh]: https://ohmyz.sh/
