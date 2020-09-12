{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {

      em = "emacsclient -t";
      fromto = "git diff --no-index";
      regrep = "pcre2grep -nr --color";

      "," = "cd ..";
      ",," = "cd ../..";
      ",,," = "cd ../../..";
      ",,,," = "cd ../../../..";

      dc = "docker-compose";
      dex = "docker-compose exec";

      ga = "git add";
      gaa = "git add -A";
      gg = "git graph";
      gc = "git commit";
      gs = "git status";
      gp = "git push";
      gd = "git diff";

    };

    functions = {
      fish_prompt = ''
        set last_status $status
        printf "\n%s: %s" (hostname) (basename (pwd))
        set_color normal
        __fish_git_prompt
        set_color normal
        printf "\n-"
        printf "> "
      '';

      pg = "echo Tips!";

      gaac = {
        body = "git add -A; and git commit $argv";
        wraps = "git commit";
      };

    };

    interactiveShellInit = ''
      _vy_setUpColorScheme

      set __fish_git_prompt_showdirtystate 'yes'
      set __fish_git_prompt_showuntrackedfiles 'yes'
      set __fish_git_prompt_showstashstate 'yes'
    '';

  };



  # Tomorrow Night color scheme
  programs.fish.functions."_vy_setUpColorScheme" = ''
    set fish_color_autosuggestion 969896
    set fish_color_cancel \x2dr
    set fish_color_command c397d8
    set fish_color_comment e7c547
    set fish_color_cwd green
    set fish_color_cwd_root red
    set fish_color_end c397d8
    set fish_color_error d54e53
    set fish_color_escape 00a6b2
    set fish_color_history_current \x2d\x2dbold
    set fish_color_host normal
    set fish_color_host_remote yellow
    set fish_color_match \x2d\x2dbackground\x3dbrblue
    set fish_color_normal normal
    set fish_color_operator 00a6b2
    set fish_color_param 7aa6da
    set fish_color_quote b9ca4a
    set fish_color_redirection 70c0b1
    set fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
    set fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
    set fish_color_status red
    set fish_color_user brgreen
    set fish_color_valid_path \x2d\x2dunderline
    set fish_pager_color_completion normal
    set fish_pager_color_description B3A06D\x1eyellow
    set fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
    set fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

    set -g __fish_git_prompt_color_branch green
    set -g __fish_git_prompt_color_merging magenta
    set -g __fish_git_prompt_color_dirtystate red
    set -g __fish_git_prompt_color_untrackedfiles red
    set -g __fish_git_prompt_color_stagedstate green
    set -g __fish_git_prompt_color_stashstate blue
  '';
}
