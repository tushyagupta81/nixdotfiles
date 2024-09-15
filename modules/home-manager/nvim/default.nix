{
  pkgs,
  inputs,
  ...
}: {
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };
}
