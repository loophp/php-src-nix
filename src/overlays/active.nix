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
      version = "8.1.28";
      hash = "sha256-i+RQCW4BU8R9dThOfdWVzIl/HVPOAGBwjOlYm8wxQe4=";
      patches = {
        php = [ patches.libxmlpatch ];
      };
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.19";
      hash = "sha256-PBj3zlG3x7JreX4flwedOGswNH6wToF/XmyOmydeKmo=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.7";
      hash = "sha256-AcIM3hxaVpZlGHXtIvUHhJZ5+6dA+MQhYWt9Q9f3l9o=";
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
