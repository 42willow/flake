{
  self,
  inputs,
  ...
}: {
  darwin-unstable = final: _prev: {
    unstable = import inputs.darwin-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nixos-unstable = final: _prev: {
    unstable = import inputs.nixos-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  additions = final: _prev: import "${self}/pkgs" final.pkgs;
}
