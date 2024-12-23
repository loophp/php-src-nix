inputs:

final: prev:

let
  inherit (prev) lib;

  patches = prev.callPackage ../patches.nix { };
  extensions = prev.callPackage ../extensions.nix { };

  makePhpPackage = import ../makePhpPackage.nix inputs final prev;

  branches = {
    php-8-1-snapshot = {
      version = "8.1.999-${inputs.php-src-81.shortRev}";
      src = inputs.php-src-81;
      patches = {
        php = [ patches.libxmlpatch ];
      };
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
      extensions = extensions.php81-to-php8300;
    };
    php-8-2-snapshot = {
      version = "8.2.999-${inputs.php-src-82.shortRev}";
      src = inputs.php-src-82;
      extensions = extensions.php81-to-php8300;
    };
    php-8-3-snapshot = {
      version = "8.3.999-${inputs.php-src-83.shortRev}";
      src = inputs.php-src-83;
      extensions = extensions.php81-to-php8300;
    };
    php-8-4-snapshot = {
      version = "8.4.999-${inputs.php-src-84.shortRev}";
      src = inputs.php-src-84;
      extensions = extensions.php-from-8400;
    };
    php-master-snapshot = {
      version = "8.5.999-${inputs.php-src-master.shortRev}";
      src = inputs.php-src-master;
      extensions = extensions.php-from-8400;
    };
  };
in
lib.mapAttrs (k: v: ((makePhpPackage v).withExtensions (v.extensions))) branches
