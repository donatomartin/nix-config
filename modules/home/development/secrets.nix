{
  config,
  lib,
  profileInput,
  ...
}:
let
  isWork = profileInput == "work";
  secretFile = if isWork then ../../../secrets/work.yml else ../../../secrets/personal.yml;
  mkSecret = key: {
    inherit key;
    sopsFile = secretFile;
  };
in
{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      gitName = mkSecret "git/name";
      gitEmail = mkSecret "git/email";
    }
    // lib.optionalAttrs isWork {
      gitCredentialHelperPath = mkSecret "git/credential/helper/path";
    }
    // lib.optionalAttrs (!isWork) {

    };
  };
}
