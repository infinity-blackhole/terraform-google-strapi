{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.terraform
    pkgs.tflint
    pkgs.terraform-docs
    pkgs.pre-commit
    pkgs.tfsec
    pkgs.nixpkgs-fmt
  ];
}
