pkgs:

pkgs.stdenv.mkDerivation rec {
  pname = "vscode-java-debug";
  version = "0.53.2";

  src = pkgs.fetchFromGitHub {
    owner = "microsoft";
    repo = "java-debug";
    rev = version;
    hash = "sha256-FsXuRph045RgoaSLOEvVvgw5nNs0g0B0XSWR5T6vttE=";
  };

  nativeBuildInputs = [
    pkgs.maven
    pkgs.temurin-bin-21
  ];

  buildPhase = ''
    runHook preBuild

    export JAVA_HOME="${pkgs.temurin-bin-21}"
    export SOURCE_DATE_EPOCH=1793404800

    mvn clean package \
      --batch-mode \
      -DskipTests \
      -DforceContextQualifier=v${version}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/vscode-java-debug/bundles"

    cp com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar \
      "$out/share/vscode-java-debug/bundles/"

    runHook postInstall
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-AhnHrwZsvxX7wPkURYeSMRaVMCQKaoLlOeoVi/G26C8=";
}
