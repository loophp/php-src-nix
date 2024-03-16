inputs:

final:
prev:

let
  inherit (prev) lib;

  patches = prev.callPackage ../patches.nix { };
  extensions = prev.callPackage ../extensions.nix { };

  makePhpPackage = import ../makePhpPackage.nix inputs final prev;

  makePackageSet = versions: lib.foldl'
    (a: set: a // (
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
    ))
    { }
    versions;

  versions = [
    {
      version = "8.1.27";
      hash = "sha256-oV/XPqRPLfMLB9JHhuB9GUiw6j7tC4uEVzXVANwov/E=";
      patches = { php = [ patches.libxmlpatch ]; };
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.17";
      hash = "sha256-GRMWwgMmfZYWC0fSL5VdTcEXk96KXzJ+DCp2J1polOo=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.4";
      hash = "sha256-PFyvGODAokOq7JE6OeywkgQxla3eTD/ELpRdpbkndpU=";
      extensions = extensions.php81-to-php8300;
    }
  ];
in
lib.mapAttrs
  (k: v: ((makePhpPackage v).withExtensions (v.extensions)))
  (makePackageSet versions)
