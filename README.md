Work In Progress
================

This aims to be an example repo showing how to package a project for nix as a
flake using [flake.parts](https://flake.parts) and provide:

* Nix packages
* NixOS config modules
* Dev shell (`nix develop`) containing the same deps list as the packages.

This repo needs a code review to verify my understanding, which is part of the
purpose of creating it.

Useful Commands
---------------

```shell
nix flake show
nix flake check
nix build "#hello-world"
nix develop
```

How this can be used in a system flake
--------------------------------------

Add flake input:

```nix
nix-flake-example = {
 url = "github:haku/nix-flake-example";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Add the module in `inputs.nixpkgs.lib.nixosSystem`:

```
modules = [
  inputs.nix-flake-example.nixosModules.hello-world
];
```

Configure the service:

```
services.hello-world = {
  enable = true;
  port = 9999;
};
```
