
# Because Arch people say so, I guess.
if status --is-login
        set PATH $PATH /usr/bin /sbin
end

# iTerm Shell Integration
#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
# Emacs Shell Integration
function fish_title
        true
end


# Local bin
set -gx PATH $PATH ~/bin

# Because even Bill Joy doesn't use vim anymore.
set -gx EDITOR 'emacsclient -t'
# set -Ux EDITOR 'emacsclient -t -a "mate -w"'

function em
        emacsclient -t $argv
end

function dc
        docker-compose $argv
end

function mux
        tmux -2CC attach $argv; or tmux -2CC $argv
end

function mc
        cd ~/Projects/mc
end





# Prompt

function fish_prompt
        set last_status $status
        printf "\n"
        printf "Fucking Arch Box or whatever: %s" (basename (pwd))
        vy_git_prompt
        printf "\n"
        printf "-> "
end

function fish_greeting
        # imgcat ~/.config/catdance.gif
end



# Aliï

function fromto
        # It's like diff, but makes sense to me.
        git diff --no-index $argv
end

function goto
        cd $argv
        ll
end

function regrep
        egrep -nr --color=always $argv
end

function peep
        docker-compose logs -f --tail=50 $argv
end



# Env




# Git

# Git aliases ---

function ga
        git add $argv
end

function gaa
        git add -A $argv
end

function gaac
        git add -A; git commit $argv
end

function gc
        git commit $argv
end

function gcm
        git commit -m $argv
end

function gch
        git checkout $argv
end

function ghc
        git checkout $argv
end

function ch
        git checkout $argv
end

function gs
        git status $argv
end

function gp
        git push $argv
end

function pg
        echo Tips! $argv
end

function gf
        git fetch $argv
end

function guf
        git update-from $argv
end

function gm
        git merge $argv
end

function gd
        git diff $argv
end

function rerere-on
        git config --global rerere.enabled true
end

function rerere-off
        git config --global rerere.enabled false
end



# Git Prompt Assistant --

if status --is-interactive
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

        # Enable direnv iff we're in interactive session
        eval (direnv hook fish)

end


function vy_git_prompt
        if status --is-interactive
                set_color normal
                printf '%s ' (__fish_git_prompt)
                set_color normal
        end
end
