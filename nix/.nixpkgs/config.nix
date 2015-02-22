{
  allowUnfree = true;
  pulseaudio = true;
  packageOverrides = pkgs : rec {
    maven = pkgs.maven.override {
      jdk = pkgs.openjdk8;
    };
    haskellngPackages = pkgs.haskellngPackages.override {
      overrides = self: super: {
        hindent = pkgs.stdenv.lib.overrideDerivation pkgs.haskellngPackages.hindent (attrs : {
          postInstall = ''
            install -d $out/share/emacs/site-lisp
            install "elisp/"*.el $out/share/emacs/site-lisp
          '';
        });
        ghci-ng = pkgs.haskellngPackages.mkDerivation {
          pname = "ghci-ng";
          version = "0.0";
          src = pkgs.fetchgit {
            url = "http://github.com/chrisdone/ghci-ng.git";
            sha256 = "fe77bf57cddc3a626386fc9fab6ee8576d497276c858ca74baaea30b43333a93";
            rev = "92e45782ab96c50bafef2001a14bef82479c4a70";
          };
          isLibrary = false;
          isExecutable = true;
          buildDepends = with pkgs.haskellngPackages; [
            ghc-paths syb
          ];
          testDepends = with pkgs; [

          ];
          homepage = "http://github.com/chrisdone/ghci-ng";
          description = "Next generation ghci";
          license = pkgs.stdenv.lib.licenses.bsd3;
        };

      };
    };
    libsigsegv = pkgs.stdenv.lib.overrideDerivation pkgs.libsigsegv ( oldAttr : {doCheck = false;} );
    hsEnv = haskellngPackages.ghcWithPackages (p:
      [p.cabal2nix p.cabal-install p.ghci-ng p.structured-haskell-mode p.hindent p.hasktags]);
  };
}
