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
          inherit (set) patches version;
          src = prev.fetchurl {
            inherit (set) hash;
            url = "https://www.php.net/distributions/php-${set.version}.tar.bz2";
          };
        };
      }
    ))
    { }
    versions;

  versions =
    let
      libxmlpatch =
        (prev.fetchpatch {
          url = "https://github.com/php/php-src/commit/0a39890c967aa57225bb6bdf4821aff7a3a3c082.patch";
          hash = "sha256-HvpTL7aXO9gr4glFdhqUWQPrG8TYTlvbNINq33M3zS0=";
        })
      ;
    in
    [
      { version = "8.1.26"; hash = "sha256-g73iSchKoaBDqMjQ7qCTRcLK5puXhM3wIin8kW+7nqA="; patches = [ libxmlpatch ]; }
      { version = "8.2.13"; hash = "sha256-ZlKfQ7ITEx5rJTxWAr7wXwSUWNISknMPzNY7SKBtZ7o="; }
      { version = "8.3.0"; hash = "sha256-3mfQgz1CsZblpm+hozL0Xilsvo6UcuklayoHHDTcXtY="; }
    ];
in
lib.mapAttrs
  (k: v: (makePhpPackage v))
  (makePackageSet versions)
