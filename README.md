Work In Progress
================

This aims to be an example repo showing how to package a project for nix and provide:

* Nix package
* NixOS config module
* Dev shell (`nix develop`) containing the same deps list as the package.

This repo needs a code review to config to verify my understanding, which is
part of the purpose of creating it.

Useful Commands
---------------

```shell
nix flake show
nix flake check
nix build "#hello-world"
nix develop
```
