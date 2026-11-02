{
  pkgs,
  javahome ? null,
  lsjavahome ? null,
}:
let
  finalJavaHome = if (javahome != null) then javahome else pkgs.temurin-bin-21;
  finalLsJavaHome = if (lsjavahome != null) then lsjavahome else pkgs.temurin-bin-21;
  lombok = pkgs.lombok;
  jdtls = pkgs.jdt-language-server;
  java-debug = (import ./java-debug.nix) pkgs;
in
{

  home.packages = [
    finalJavaHome
    lombok
    jdtls
    java-debug
  ]
  ++ (with pkgs; [
    # Language deps
    nixd
    nixfmt
    lua-language-server
    pyright
    vtsls
    emmet-language-server
    gopls
    sonarlint-ls
    bash-language-server
    sqlfluff

    # Plugin deps
    fd
    ripgrep
    zoxide
    tmux
  ]);

  home.sessionVariables = {
    EDITOR = "nvim";
    JAVA_HOME = "${finalJavaHome}";
    JDTLS_JAVA_HOME = "${finalLsJavaHome}";
    JDTLS_PATH = "${jdtls}";
    LOMBOK_PATH = "${lombok}";
    JAVA_DEBUG_PATH = "${java-debug}";
  };

}
