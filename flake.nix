{
  description = "SICP EPUB build";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        phantomjs = pkgs.stdenv.mkDerivation {
          pname = "phantomjs";
          version = "2.1.1";

          src = pkgs.fetchurl {
            url = "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2";
            sha256 = "0bqd8r97inh5f682m3cykg76s7bwjkqirxn9hhd5zr5fyi5rmpc6";
          };

          nativeBuildInputs = [ pkgs.autoPatchelfHook ];
          buildInputs = [
            pkgs.fontconfig
            pkgs.freetype
            pkgs.zlib
            pkgs.libX11
            pkgs.libXext
            pkgs.stdenv.cc.cc.lib
          ];

          installPhase = ''
            mkdir -p $out/bin
            cp bin/phantomjs $out/bin/
          '';
        };

        rubyWithNokogiri = pkgs.ruby.withPackages (ps: [ ps.nokogiri ]);

        mathjax = pkgs.fetchFromGitHub {
          owner = "mathjax";
          repo = "MathJax";
          rev = "2.7.9";
          sha256 = "0rqxc3nxz1yih848fsv8yp5r86bh8lyr09wabk656cfh0whyp28q";
        };

      in {
        packages.sicp-epub = pkgs.stdenv.mkDerivation {
          pname = "sicp-epub";
          version = "2.0";

          src = ./.;

          nativeBuildInputs = [
            pkgs.perl
            rubyWithNokogiri
            pkgs.inkscape
            pkgs.zip
            phantomjs
            pkgs.texinfo
          ];

          buildInputs = [
            pkgs.fontconfig
            pkgs.freetype
          ];

          buildPhase = ''
            cp -r ${mathjax} ./mathjax
            chmod -R +w ./mathjax

            # Fix shebangs
            patchShebangs .

            export XDG_CACHE_HOME="$(mktemp -d)"
            export LANG=C.UTF-8

            export PATH=$PATH:${phantomjs}/bin
            
            make
          '';

          installPhase = ''
            mkdir -p $out
            cp ../sicp.epub $out/ || cp sicp.epub $out/ || (ls -R .. && exit 1)
          '';
        };

        packages.default = self.packages.${system}.sicp-epub;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.perl
            rubyWithNokogiri
            pkgs.inkscape
            pkgs.zip
            phantomjs
          ];
        };
      }
    );
}
