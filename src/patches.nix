{ fetchpatch
}:
{
  libxmlpatch = (fetchpatch {
    url = "https://github.com/php/php-src/commit/0a39890c967aa57225bb6bdf4821aff7a3a3c082.patch";
    hash = "sha256-HvpTL7aXO9gr4glFdhqUWQPrG8TYTlvbNINq33M3zS0=";
  });
  ext_sqlite3 = (fetchpatch {
    url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/interpreters/php/skip-sqlite3_bind_bug68849.phpt.patch";
    hash = "sha256-D4UeUTHlSVJqcHiyj7smvhPnOyV51S2OloWcUmRWwJY=";
  });
  # https://github.com/php/php-src/commit/2a4775d6a73e9f6d4fc8e7df6f052aa18790a8e9
  ext_sqlite3_tests = (fetchpatch {
    url = "https://github.com/php/php-src/commit/2a4775d6a73e9f6d4fc8e7df6f052aa18790a8e9.patch";
    hash = "sha256-2VNfURGZmIEXtoLxOLX5wec9mqNGEWPY3ofCMw4E7S0=";
    excludes = [
      "NEWS"
    ];
  });
  ext_dom = (fetchpatch {
    url = "https://github.com/php/php-src/commit/061058a9b1bbd90d27d97d79aebcf2b5029767b0.patch";
    hash = "sha256-0hOlAG+pOYp/gUU0MUMZvzWpgr0ncJi5GB8IeNxxyEU=";
    excludes = [
      "NEWS"
    ];
  });
  ext_dom_tests_php81 = ./patches/0001-php81-libxml212-tests.patch;
  ext_dom_tests = (fetchpatch {
    url = "https://raw.githubusercontent.com/fossar/nix-phps/master/pkgs/patches/libxml-ext.patch";
    hash = "sha256-hDoxYTOf+cDo3CeTdDc6aNe+uIBqnjlXAq54agjmSqI=";
  });
}
