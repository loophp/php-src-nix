inputs:

final:
prev:

let
  inherit (prev) lib;

  pear = prev.fetchurl {
    url = "https://pear.php.net/install-pear-nozlib.phar";
    hash = "sha256-UblKVcsm030tNSA6mdeab+h7ZhANNz7MkFf4Z1iigjs=";
  };

  generic = "${inputs.nixpkgs}/pkgs/development/interpreters/php/generic.nix";

  makePhpPackage = { src, version ? null }: (prev.callPackage generic {
    hash = null;

    version = if version != null then version else
    let
      configureFile = "${src}/configure.ac";

      extractVersionFromConfigureAc = configureText:
        let
          match = builtins.match ".*AC_INIT\\(\\[PHP],\\[([^]-]+)(-dev)?].*" configureText;
        in
        if match != null then builtins.head match else null;

      version =
        let
          configureText = builtins.readFile configureFile;
          version = extractVersionFromConfigureAc configureText;
        in
        if version != null then version else "0.0.0+unknown";
    in
    "${version}.snapshot.${inputs.self.lastModifiedDate}";

    phpAttrsOverrides = attrs: {
      inherit src;

      preInstall = attrs.preInstall or "" + ''
        if [[ ! -f ./pear/install-pear-nozlib.phar ]]; then
          cp ${pear} ./pear/install-pear-nozlib.phar
        fi
      '';
    };

    packageOverrides = finalPO: prevPO: {
      extensions = prevPO.extensions // {
        dom = prevPO.extensions.dom.overrideAttrs (attrs: {
          postPatch =
            lib.concatStringsSep "\n" [
              (attrs.postPatch or "")

              (lib.optionalString (lib.versionOlder prevPO.php.version "8.0.8") ''
                # 4cc261aa6afca2190b1b74de39c3caa462ec6f0b deletes this file but fetchpatch does not support deletions.
                rm ext/dom/tests/bug80268.phpt
                rm ext/dom/tests/DOMDocument_loadXML_error1.phpt
                rm ext/dom/tests/DOMDocument_load_error1.phpt
              '')

              (lib.optionalString ((lib.versionAtLeast prevPO.php.version "8.0") && (lib.versionOlder prevPO.php.version "8.1.20")) ''
                rm ext/dom/tests/DOMDocument_loadXML_error2.phpt
                rm ext/dom/tests/DOMDocument_load_error2.phpt
              '')

              (lib.optionalString ((lib.versionAtLeast prevPO.php.version "8.2") && (lib.versionOlder prevPO.php.version "8.2.7")) ''
                rm ext/dom/tests/DOMDocument_loadXML_error2.phpt
                rm ext/dom/tests/DOMDocument_load_error2.phpt
              '')
            ];
        });

        opcache = prevPO.extensions.opcache.overrideAttrs (attrs: {
          postPatch =
            lib.concatStringsSep "\n" [
              (attrs.postPatch or "")

              (lib.optionalString (prevPO.php.version == "8.1.14") ''
                rm ext/opcache/tests/gh9968.phpt
              '')

              (lib.optionalString (prevPO.php.version == "8.2.1") ''
                rm ext/opcache/tests/gh9968.phpt
              '')
            ];
        });

        openssl = prevPO.extensions.openssl.overrideAttrs (attrs: {
          buildInputs =
            let
              replaceOpenssl = pkg:
                if pkg.pname == "openssl" && lib.versionOlder prevPO.php.version "8.1" then
                  prev.openssl_1_1.overrideAttrs
                    (old: {
                      meta = builtins.removeAttrs old.meta [ "knownVulnerabilities" ];
                    })
                else
                  pkg;
            in
            builtins.map replaceOpenssl attrs.buildInputs;
        });

        sockets = prevPO.extensions.sockets.overrideAttrs (attrs: {
          patches = attrs.patches or [ ] ++ lib.optionals (prevPO.php.version == "8.0.15") [
            # See https://github.com/php/php-src/pull/7981
            (prev.fetchpatch {
              url = "https://github.com/php/php-src/commit/6a6c8a60965c6fc3f145870a49b13b719ebd4a72.patch";
              hash = "sha256-WCdHQIKBg24AWLAftHuCLZ+QqRVZXWdHFqZhmRSJ7+Y=";
            })
          ] ++ lib.optionals (prevPO.php.version == "8.1.2") [
            # See https://github.com/php/php-src/pull/7981
            (prev.fetchpatch {
              url = "https://github.com/php/php-src/commit/6a6c8a60965c6fc3f145870a49b13b719ebd4a72.patch";
              hash = "sha256-WCdHQIKBg24AWLAftHuCLZ+QqRVZXWdHFqZhmRSJ7+Y=";
            })
          ];
        });

        tokenizer = prevPO.extensions.tokenizer.overrideAttrs (attrs: {
          patches = [ ] ++ lib.optionals (lib.versionAtLeast prevPO.php.version "8.1") attrs.patches;
        });
      };
    };
  });
in
v: (makePhpPackage v).withExtensions ({ all, ... }: with all; [
  bcmath
  calendar
  curl
  ctype
  dom
  exif
  fileinfo
  filter
  ftp
  gd
  gettext
  gmp
  iconv
  imap
  intl
  ldap
  mbstring
  mysqli
  mysqlnd
  opcache
  openssl
  pcntl
  pdo
  pdo_mysql
  pdo_odbc
  pdo_pgsql
  pdo_sqlite
  pgsql
  posix
  readline
  session
  simplexml
  sockets
  soap
  sodium
  sysvsem
  sqlite3
  tokenizer
  xmlreader
  xmlwriter
  xsl
  zip
  zlib
])
