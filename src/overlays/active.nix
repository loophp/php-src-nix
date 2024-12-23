inputs:

final: prev:

let
  inherit (prev) lib;

  patches = prev.callPackage ../patches.nix { };
  extensions = prev.callPackage ../extensions.nix { };

  makePhpPackage = import ../makePhpPackage.nix inputs final prev;

  makePackageSet =
    versions:
    lib.foldl' (
      a: set:
      a
      // (
        let
          name = set.name or "php-${builtins.replaceStrings [ "." ] [ "-" ] set.version}";
        in
        {
          "${name}" = {
            inherit (set) version extensions;
            patches = set.patches or [ ];
            src = prev.fetchurl {
              inherit (set) hash;
              url = "https://www.php.net/distributions/php-${set.version}.tar.bz2";
            };
          };
        }
      )
    ) { } versions;

  versions = [
    {
      version = "8.1.31";
      hash = "sha256-CzmCizRRUcrxt5XZ9LkjyYhyMXdsMwdt/J2QpEOQ0Nw=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.27";
      hash = "sha256-blfbr3aafz3rTw9IuMU15nHMChgCLtf2/yO1DpQdS2A=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.15";
      hash = "sha256-sWdaT/cwtYEbjmp2h0iMQug14Vapl3aqPm8Ber2jvpg=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.4.2";
      hash = "sha256-70/pkhuIXOOwR3kqtgJg6vZX4igSvlEdGdDkXt+YR4M=";
      extensions = extensions.php-from-8400;
    }
  ];
in
lib.mapAttrs (k: v: ((makePhpPackage v).withExtensions (v.extensions))) (makePackageSet versions)
