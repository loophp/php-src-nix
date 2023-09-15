# PHP binaries from sources

[![GitHub Workflow Status][github workflow status]][github actions link]
[![Donate!][donate github]][donate github link]

This repository maintains a continuous integration workflow powered by
[Nix][nix], designed to build all existing PHP versions starting from version
8.0, including snapshots of the current development versions.

Our workflow operates daily, triggering a build at midnight. To enhance
efficiency, we have implemented a caching mechanism that stores the generated
binary to prevent redundant builds of identical versions.

We provide not only archived versions but also the most recent active and
development versions, pulled directly from the respective git branches.

The naming pattern is the following:

- `php-8.1.0`: Specifies the PHP version 8.1.0 build
  (released on 26th Nov 2020).
- `php-8.1-latest`: An alias that points to the latest stable release in the
  PHP 8.1 series.
- `php-8.1-snapshot`: Represents the latest development version of PHP 8.1,
  pulled from the corresponding git branch.

PHP is compiled with the following built-in extensions: `bcmath`, `calendar`,
`curl`, `ctype`, `dom`, `exif`, `fileinfo`, `filter`, `ftp`, `gd`, `gettext`,
`gmp`, `iconv`, `imap`, `intl`, `ldap`, `mbstring`, `mysqli`, `mysqlnd`,
`opcache`, `openssl`, `pcntl`, `pdo`, `pdo_mysql`, `pdo_odbc`, `pdo_pgsql`,
`pdo_sqlite`, `pgsql`, `posix`, `readline`, `session`, `simplexml`, `sockets`,
`soap`, `sodium`, `sysvsem`, `sqlite3`, `tokenizer`, `xmlreader`, `xmlwriter`,
`xsl`, `zip`, `zlib`.

The list of default architectures the CI builds are made for:

 - `x86_64-linux`
 - `x86_64-darwin`

## Usage

To view the list of available packages, execute the following command:

```shell
nix flake show github:loophp/php-src-nix
```

To use the binaries, execute the following command:

```shell
nix run github:loophp/php-src-nix#php-8-1-latest -- -v
```

To use any of the PHP versions in a Nix expression, we provide a Nix overlay:

```shell
pkgs = import nixpkgs {
    inherit system;
    overlays = [
        inputs.php-src-nix.overlays.default
    ];
};
```

## Compilation

If you attempt to use a PHP version not previously compiled
(*in the unlikely event that the version is unavailable*), the compilation will
occur locally on your machine. Note that this process is time-consuming.
Thankfully, we offer a binary cache to bypass redundant compilations and save
time (*If it build once, why bother compiling it again anyway?*).

We leverage [Cachix](https://cachix.org/) to facilitate this binary caching
mechanism. A big thank you to them!

To use the binary cache, issue the following command:

```shell
cachix use php-src-nix
```

Two architectures are available: `x86_64-linux` and `x86_64-darwin`, those are
provided for free by GitHub.

The compilation process is therefore totally transparent to the end-user.

## Contributing

Feel free to contribute by sending pull requests. We are a usually very
responsive team and we will help you going through your pull request from the
beginning to the end.

For some reasons, if you can't contribute to the code and willing to help,
sponsoring is a good, sound and safe way to show us some gratitude for the hours
we invested in this package.

Sponsor me on [Github][donate github link] and/or any of [the
contributors][github contributors].

[github workflow status]: https://img.shields.io/github/actions/workflow/status/loophp/php-src-nix/build.yaml?branch=main&style=flat-square
[github actions link]: https://github.com/loophp/php-src-nix/actions
[donate github]: https://img.shields.io/badge/Sponsor-Github-brightgreen.svg?style=flat-square
[donate github link]: https://github.com/sponsors/drupol
[nix]: https://nixos.org/
[github contributors]: https://github.com/loophp/php-src-nix/graphs/contributors
