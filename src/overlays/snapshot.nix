inputs:

final:
prev:

let
  inherit (prev) lib;

  makePhpPackage = import ../makePhpPackage.nix inputs final prev;

  branches = {
    php-8-1-snapshot = {
      version = "8.1.999-${inputs.php-src-81.shortRev}";
      src = inputs.php-src-81;
      patches = [
        (prev.fetchpatch {
          url = "https://github.com/php/php-src/commit/0a39890c967aa57225bb6bdf4821aff7a3a3c082.patch";
          hash = "sha256-HvpTL7aXO9gr4glFdhqUWQPrG8TYTlvbNINq33M3zS0=";
        })
      ];
    };
    php-8-2-snapshot = { version = "8.2.999-${inputs.php-src-82.shortRev}"; src = inputs.php-src-82; };
    php-8-3-snapshot = { version = "8.3.999-${inputs.php-src-83.shortRev}"; src = inputs.php-src-83; };
    php-master-snapshot = { version = "8.4.999-${inputs.php-src-master.shortRev}"; src = inputs.php-src-master; };
  };
in
lib.mapAttrs
  (k: v: (makePhpPackage v))
  branches
