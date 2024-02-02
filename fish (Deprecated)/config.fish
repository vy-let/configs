# Note this does not get picked up by NixOS machines.

set PATH $HOME/bin $PATH

# This is needed (for now) to make rapture work
set -gx SHELL (which fish)

set -gx EDITOR emacs


# Init Integrations

# iTerm Shell Integration
test -e ~/.iterm2_shell_integration.fish ; and source ~/.iterm2_shell_integration.fish

# Rapture
command -q rapture; and eval ( command rapture shell-init )



function fish_prompt
    set last_status $status
    printf "\n"
    printf "%s: %s" (hostname) (basename (pwd))
    vy_git_prompt
    printf "\n-"
    printf "> "
end


# Git Prompt Assistant --

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set blue (set_color blue)
set red (set_color red)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showstashstate 'yes'

set __fish_git_prompt_color_branch green
set __fish_git_prompt_color_merging magenta
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_color_untrackedfiles red
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_stashstate blue



function vy_git_prompt
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end






# -------------------------------------------------------



function em
    emacsclient -t $argv
end

function fromto
    git diff --no-index $argv
end

function goto
    cd $argv
    ll
end

function regrep
  if type -q pcre2grep
    pcre2grep -nrI --color=always $argv
  else
    grep -Ern --color $argv
  end
end

function ,
    cd ..
end

function ,,
    cd ../..
end

function ,,,
    cd ../../..
end

function les
    less -R $argv
end




function dc
    docker-compose $argv
end

function dex
    docker-compose exec $argv
end

function peep
    docker-compose logs -f --tail=50 $argv
end



function ga
  git add $argv
end

function gaa
  git add -A $argv
end

function gg
    git graph $argv
end

function gaac
  git add -A; git commit $argv
end

function gc
  git commit $argv
end

function gs
  git status $argv
end

function gp
  git push $argv
end

function pg
  echo Tips!
end

function gd
  git diff $argv
end
