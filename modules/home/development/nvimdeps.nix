{
  pkgs,
  javahome ? null,
  lsjavahome ? null,
  ...
}:
let
  finalJavaHome = if (javahome != null) then javahome else pkgs.temurin-bin-21;
  finalLsJavaHome = if (lsjavahome != null) then lsjavahome else pkgs.temurin-bin-21;
  lombok = pkgs.lombok;
  jdtls = pkgs.jdt-language-server;
  java-debug = pkgs.vscode-extensions.vscjava.vscode-java-debug;
in
{

  home.packages = [

    jdtls
    finalJavaHome
    lombok
    java-debug

    # Language deps
    pkgs.nixd
    pkgs.nixfmt
    pkgs.lua-language-server
    pkgs.pyright
    pkgs.vtsls
    pkgs.emmet-language-server
    pkgs.gopls
    pkgs.sonarlint-ls
    pkgs.bash-language-server
    pkgs.shellcheck
    pkgs.sqlfluff

    # Plugin deps
    pkgs.fd
    pkgs.ripgrep
    pkgs.zoxide
    pkgs.tmux

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    JAVA_HOME = "${finalJavaHome}";
    JDTLS_JAVA_HOME = "${finalLsJavaHome}";
    JDTLS_PATH = "${jdtls}";
    LOMBOK_PATH = "${lombok}";
    JAVA_DEBUG_PATH = "${java-debug}";
  };

}
