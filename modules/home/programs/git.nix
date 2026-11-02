{
  config,
  lib,
  profileInput ? null,
}:
{
  sops.templates."git-identity.conf".content = ''
    [user]
      name = ${config.sops.placeholder.gitName}
      email = ${config.sops.placeholder.gitEmail}
  ''
  + lib.optionalString (profileInput == "work") ''
    [credential]
      helper = ${config.sops.placeholder.gitCredentialHelperPath}
    [credential "https://dev.azure.com/"]
      useHttpPath = true
  '';

  programs.git = {
    enable = true;

    settings = {
      include.path = config.sops.templates."git-identity.conf".path;
      core.autocrlf = "input";
      core.editor = "nvim";
      pull.rebase = true;
      rebase.autoStash = true;
      diff.algorithm = "histogram";
      init.defaultBranch = "master";
    };
  };
}
