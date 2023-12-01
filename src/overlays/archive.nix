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

  versions = [
    { version = "8.1.18"; hash = "sha256-0qww1rV0/KWU/gzAHAaT4jWFsnRD40KwqrBydM3kQW4="; }
    { version = "8.1.19"; hash = "sha256-ZCByB/2jC+kmou8fZv8ma/H9x+AzObyZ+7oKEkXkJ5s="; }
    { version = "8.1.20"; hash = "sha256-VVeFh1FKJwdQD4UxnlfA1N+biAPNsmVmWVrEv0WdxN0="; }
    { version = "8.1.21"; hash = "sha256-bqSegzXWMhd/VrUHFgqhUcewIBhXianBSFn85dSgd20="; }
    { version = "8.1.22"; hash = "sha256-mSNU44LGxhjQHtS+Br7qjewxeLFBU99k08jEi4Xp+8I="; }
    { version = "8.1.23"; hash = "sha256-kppieFF32okt3/ygdLqy8f9XhHOg1K25FcEvXz407Bs="; }
    { version = "8.1.24"; hash = "sha256-sK5YBKmtU6fijQoyYpSV+Bb5NbEIMMcfTsFYJxhac8k="; }
    { version = "8.1.25"; hash = "sha256-qGqIwYQMG8gyvP0vvsO4oZQsgxTaXf9T8J+cmNDBLoo=c"; }
    { version = "8.2.0"; hash = "sha256-G/T8pmP5PZ4LSQm9bq4Fg6HOOD5/Bd8Sbyjycvof1Ro="; }
    { version = "8.2.1"; hash = "sha256-ddb482WZPsDR2cYoHUVX5v7sWiYZSkaLiwFFnRd++yk="; }
    { version = "8.2.2"; hash = "sha256-9SI6UnTtqLQMGeR94N5GeMZdZEAcz3EOJGSWLrgTaAQ="; }
    { version = "8.2.3"; hash = "sha256-h7tYhl849eKUGBMCkVLOohAv4pYbtNaLiPgx3dBUjQ8="; }
    { version = "8.2.4"; hash = "sha256-eRhvlL1RDbhuMeU13USCd6Hrkqh4eDA6Hq1EYC2LEZc="; }
    { version = "8.2.5"; hash = "sha256-5agGY8yk9gRK2GpIl5gUfHrwN+ypb2zTV6s20oy2N1c="; }
    { version = "8.2.6"; hash = "sha256-RKcMUvU3ZiwQ2R7tv1H9dlyZYb5rolCO1jv3omzdMQA="; }
    { version = "8.2.7"; hash = "sha256-W/sqNcZ5Ib3K3VyQyykK11N9JNoROl6LwtZGsC3nSI8="; }
    { version = "8.2.8"; hash = "sha256-mV7UAJx5F8li0xg3oaNljzbUr081e2c8l//b5kA/hRc="; }
    { version = "8.2.9"; hash = "sha256-SEYLmUrn61CWoxD0TRPoZd4XcRBNSlUNUwcr5YpvF2w="; }
    { version = "8.2.10"; hash = "sha256-zJg06PG2E9dneviEPDZR6YKavKjr/pB5JR0Nhdmgqj4="; }
    { version = "8.2.11"; hash = "sha256-OBktrv+r9K9sQnvxesH4JWXZx1IuDb0yIVFilEQ0sos="; }
    { version = "8.2.12"; hash = "sha256-cEMl9WsbTBf5+VHh/+9cZOFIiWBT804mJhUsuqLwWJM="; }
  ];
in
lib.mapAttrs
  (k: v: (makePhpPackage v))
  (makePackageSet versions)
