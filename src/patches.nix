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
}
