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
      { version = "8.1.18"; hash = "sha256-0qww1rV0/KWU/gzAHAaT4jWFsnRD40KwqrBydM3kQW4="; patches = [ libxmlpatch ]; }
      { version = "8.1.19"; hash = "sha256-ZCByB/2jC+kmou8fZv8ma/H9x+AzObyZ+7oKEkXkJ5s="; patches = [ libxmlpatch ]; }
      { version = "8.1.20"; hash = "sha256-VVeFh1FKJwdQD4UxnlfA1N+biAPNsmVmWVrEv0WdxN0="; patches = [ libxmlpatch ]; }
      { version = "8.1.21"; hash = "sha256-bqSegzXWMhd/VrUHFgqhUcewIBhXianBSFn85dSgd20="; patches = [ libxmlpatch ]; }
      { version = "8.1.22"; hash = "sha256-mSNU44LGxhjQHtS+Br7qjewxeLFBU99k08jEi4Xp+8I="; patches = [ libxmlpatch ]; }
      { version = "8.1.23"; hash = "sha256-kppieFF32okt3/ygdLqy8f9XhHOg1K25FcEvXz407Bs="; patches = [ libxmlpatch ]; }
      { version = "8.1.24"; hash = "sha256-sK5YBKmtU6fijQoyYpSV+Bb5NbEIMMcfTsFYJxhac8k="; patches = [ libxmlpatch ]; }
      { version = "8.1.25"; hash = "sha256-qGqIwYQMG8gyvP0vvsO4oZQsgxTaXf9T8J+cmNDBLoo=c"; patches = [ libxmlpatch ]; }
      { version = "8.2.5"; hash = "sha256-5agGY8yk9gRK2GpIl5gUfHrwN+ypb2zTV6s20oy2N1c="; patches = [ libxmlpatch ]; }
      { version = "8.2.6"; hash = "sha256-RKcMUvU3ZiwQ2R7tv1H9dlyZYb5rolCO1jv3omzdMQA="; patches = [ libxmlpatch ]; }
      { version = "8.2.7"; hash = "sha256-W/sqNcZ5Ib3K3VyQyykK11N9JNoROl6LwtZGsC3nSI8="; patches = [ libxmlpatch ]; }
      { version = "8.2.8"; hash = "sha256-mV7UAJx5F8li0xg3oaNljzbUr081e2c8l//b5kA/hRc="; patches = [ libxmlpatch ]; }
      { version = "8.2.9"; hash = "sha256-SEYLmUrn61CWoxD0TRPoZd4XcRBNSlUNUwcr5YpvF2w="; patches = [ libxmlpatch ]; }
      { version = "8.2.10"; hash = "sha256-zJg06PG2E9dneviEPDZR6YKavKjr/pB5JR0Nhdmgqj4="; patches = [ libxmlpatch ]; }
      { version = "8.2.11"; hash = "sha256-OBktrv+r9K9sQnvxesH4JWXZx1IuDb0yIVFilEQ0sos="; patches = [ libxmlpatch ]; }
      { version = "8.2.12"; hash = "sha256-cEMl9WsbTBf5+VHh/+9cZOFIiWBT804mJhUsuqLwWJM="; patches = [ libxmlpatch ]; }
    ];
in
lib.mapAttrs
  (k: v: (makePhpPackage v))
  (makePackageSet versions)
