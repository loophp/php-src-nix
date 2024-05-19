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
      version = "8.1.18";
      hash = "sha256-0qww1rV0/KWU/gzAHAaT4jWFsnRD40KwqrBydM3kQW4=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8118 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.19";
      hash = "sha256-ZCByB/2jC+kmou8fZv8ma/H9x+AzObyZ+7oKEkXkJ5s=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8118 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.20";
      hash = "sha256-VVeFh1FKJwdQD4UxnlfA1N+biAPNsmVmWVrEv0WdxN0=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.21";
      hash = "sha256-bqSegzXWMhd/VrUHFgqhUcewIBhXianBSFn85dSgd20=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.22";
      hash = "sha256-mSNU44LGxhjQHtS+Br7qjewxeLFBU99k08jEi4Xp+8I=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.23";
      hash = "sha256-kppieFF32okt3/ygdLqy8f9XhHOg1K25FcEvXz407Bs=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.24";
      hash = "sha256-sK5YBKmtU6fijQoyYpSV+Bb5NbEIMMcfTsFYJxhac8k=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.25";
      hash = "sha256-qGqIwYQMG8gyvP0vvsO4oZQsgxTaXf9T8J+cmNDBLoo=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.26";
      hash = "sha256-g73iSchKoaBDqMjQ7qCTRcLK5puXhM3wIin8kW+7nqA=";
      patches = {
        php = [
          patches.ext_sqlite3_tests
          patches.libxmlpatch
          patches.ext_sqlite3
        ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
        dom = [ patches.ext_dom_tests_php8120 ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.1.27";
      hash = "sha256-oV/XPqRPLfMLB9JHhuB9GUiw6j7tC4uEVzXVANwov/E=";
      patches = {
        php = [ patches.libxmlpatch ];
      };
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
      extensions = extensions.php81-to-php8300;
    }

    {
      version = "8.2.5";
      hash = "sha256-5agGY8yk9gRK2GpIl5gUfHrwN+ypb2zTV6s20oy2N1c=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ patches.ext_dom_tests_php8118 ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.6";
      hash = "sha256-RKcMUvU3ZiwQ2R7tv1H9dlyZYb5rolCO1jv3omzdMQA=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ patches.ext_dom_tests_php8118 ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.7";
      hash = "sha256-W/sqNcZ5Ib3K3VyQyykK11N9JNoROl6LwtZGsC3nSI8=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.8";
      hash = "sha256-mV7UAJx5F8li0xg3oaNljzbUr081e2c8l//b5kA/hRc=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.9";
      hash = "sha256-SEYLmUrn61CWoxD0TRPoZd4XcRBNSlUNUwcr5YpvF2w=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.10";
      hash = "sha256-zJg06PG2E9dneviEPDZR6YKavKjr/pB5JR0Nhdmgqj4=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.11";
      hash = "sha256-OBktrv+r9K9sQnvxesH4JWXZx1IuDb0yIVFilEQ0sos=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.12";
      hash = "sha256-cEMl9WsbTBf5+VHh/+9cZOFIiWBT804mJhUsuqLwWJM=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.13";
      hash = "sha256-ZlKfQ7ITEx5rJTxWAr7wXwSUWNISknMPzNY7SKBtZ7o=";
      patches = {
        php = [
          patches.libxmlpatch
          patches.ext_sqlite3
          patches.ext_sqlite3_tests
        ];
        dom = [ ];
        sqlite3 = [ patches.ext_sqlite3_tests ];
      };
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.14";
      hash = "sha256-+HHhMTM9YK5sU3sa3dvCrqVMQ2xWKvmG+4MJwGAEC54=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.15";
      hash = "sha256-UMPiILeqY6hXFiM8kC60TMCkZn7QuDNXIq4jkbE1Xno=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.16";
      hash = "sha256-JljBuJNatrU6fyCTVGAnYasHBm5mkgvEcriBX9G0P3E=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.2.17";
      hash = "sha256-GRMWwgMmfZYWC0fSL5VdTcEXk96KXzJ+DCp2J1polOo=";
      extensions = extensions.php81-to-php8300;
    }

    {
      version = "8.3.0";
      hash = "sha256-3mfQgz1CsZblpm+hozL0Xilsvo6UcuklayoHHDTcXtY=";
      patches = {
        php = [
          patches.libxmlpatch8300only
          patches.ext_dom_tests_php83
        ];
        dom = [
          patches.libxmlpatch8300only
          patches.ext_dom_tests_php83
        ];
        sqlite3 = [ patches.ext_sqlite3 ];
      };
      extensions = extensions.php81-to-php8300;
      cflags = " -Wno-compare-distinct-pointer-types -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations -Wno-incompatible-function-pointer-types -Wno-incompatible-pointer-types-discards-qualifiers";
    }
    {
      version = "8.3.1";
      hash = "sha256-xA+ukZf6aKUy9qBiwxba/jsExUUTa1S56tSTL8JsauE=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.2";
      hash = "sha256-WCs8g3qNlS7//idKXklwbEOojBYoMMKow1gIn+dEkoQ=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.3";
      hash = "sha256-qvthO6eVlKI/5yL46QrUczAGEL+A50uKpS2pysLcTio=";
      extensions = extensions.php81-to-php8300;
    }
    {
      version = "8.3.4";
      hash = "sha256-PFyvGODAokOq7JE6OeywkgQxla3eTD/ELpRdpbkndpU=";
      extensions = extensions.php81-to-php8300;
    }
  ];
in
lib.mapAttrs (k: v: ((makePhpPackage v).withExtensions (v.extensions))) (makePackageSet versions)
