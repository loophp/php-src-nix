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
    { version = "8.1.0"; hash = "sha256-ByXtK66hJUlqiYRV1QGndGAhiyoM+tdz+pMi9JG4K2E="; }
    { version = "8.1.1"; hash = "sha256-j4vJytbNEk7cER99sKEJdF4vY4dwoQGzwiopU/eptA4="; }
    { version = "8.1.2"; hash = "sha256-kT3H3UOIQn+jPqSsiYNOhW/1OU9CGOrOJgo6J59bU6k="; }
    { version = "8.1.3"; hash = "sha256-NUxOLFBgRuyoEtH8JSaISi9UtePSDvDt6RmmnrIy0L4="; }
    { version = "8.1.4"; hash = "sha256-s/aIy2l1hSODi45/UJqu8BUhM9m4SoSgt89o7q/B33Y="; }
    { version = "8.1.5"; hash = "sha256-gn3lZ3HDq4MToGmBLxX27EmYnVEK69Dc4YCDnG2Nb/M="; }
    { version = "8.1.6"; hash = "sha256-ezUzBLdAdVT3DT4QGiJqH8It7K5cTELtJwxOOJv6G2Y="; }
    { version = "8.1.7"; hash = "sha256-uBZ1PrAFUR5pXZCUXCcJPDI2zHPbEmJlbZ+t1z6tfp0="; }
    { version = "8.1.8"; hash = "sha256-uIFaWgJDFFPUJh41mL0fKFFuTANU8yjBKJDyV4cOTAE="; }
    { version = "8.1.9"; hash = "sha256-nrsOLlcdtv1ZMEKNyy0Z7T4FAzjsHxNHwoLK6S/Ahv8="; }
    { version = "8.1.10"; hash = "sha256-LejgQCKF98Voh97+ZRkiMIre1YumC+/PO3dyAgnjHxA="; }
    { version = "8.1.11"; hash = "sha256-r2JQsYtEA7bu/5tKAnhqyGoSoggUH29lR495JW9H8kY="; }
    { version = "8.1.12"; hash = "sha256-+H1z6Rf6z3jee83lP8L6pNTb4Eh6lAbhq2jIro8z6wM="; }
    { version = "8.1.13"; hash = "sha256-k/z9+qo9CUoP2xjOCNIPINUm7j8HoUaoqOyCzgCyN8o="; }
    { version = "8.1.14"; hash = "sha256-FMqZMz3WBKUEojaJRkhaw103nE2pbSjcUV1+tQLf+jI="; }
    { version = "8.1.15"; hash = "sha256-GNoKlCKPQgf4uePiPogfK3TQ1srvuQi9tYY9SgEDXMY="; }
    { version = "8.1.16"; hash = "sha256-zZ8OoU2C2UVVh6SaC2yAKnuNj/eXA/n0ixfbAQ+2M84="; }
    { version = "8.1.17"; hash = "sha256-9Pspig6wkflE7OusV7dtqudoqXDC9RYQpask802MDK8="; }
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
