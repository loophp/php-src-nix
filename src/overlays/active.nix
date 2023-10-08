inputs:

final:
prev:

let
  inherit (prev) lib;

  makePhpPackage = import ../makePhpPackage.nix inputs final prev;

  makePackageSet = versions: lib.foldl'
    (a: set: a // (
      let
        name = set.name or "php-${builtins.replaceStrings [ "." ] [ "-" ] set.version}";
      in
      {
        "${name}" = {
          inherit (set) version;
          src = prev.fetchurl {
            inherit (set) hash;
            url = "https://www.php.net/distributions/php-${set.version}.tar.bz2";
          };
        };
      }
    ))
    { }
    versions;

  # Set of sets { PHP_VERSION = { filename = "", name = "", ...  }, ... }
  activeVersions = lib.foldlAttrs
    (acc: name: value: acc ++ [{ version = name; hash = "sha256:${value.sha256}"; } { version = name; name = "php-${builtins.replaceStrings [ "." ] [ "-" ] (lib.versions.majorMinor name)}-latest"; hash = "sha256:${value.sha256}"; }])
    [ ]
    (builtins.listToAttrs (builtins.concatMap (x: builtins.map (x: { name = x.version; value = builtins.elemAt x.source 1; }) (builtins.attrValues x)) (builtins.attrValues (builtins.fromJSON (builtins.readFile inputs.php-active)))));
in
lib.mapAttrs
  (k: v: (makePhpPackage v))
  (makePackageSet activeVersions)
