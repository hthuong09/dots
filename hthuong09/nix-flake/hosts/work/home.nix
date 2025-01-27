{ config, pkgs, ... }:
{
  # Import base home configuration
  imports = [ ../../base/home.nix ];

  home.file.".wakatime.cfg".text = ''
    [settings]
    debug = false
    hide_file_names =
      /Users/tyson.nguyen/ShopBack/
    hide_project_folder = true
    hostname = shopback-m3-macbook
    ignore =
        COMMIT_EDITMSG$
        PULLREQ_EDITMSG$
        MERGE_MSG$
        TAG_EDITMSG$
  '';
}
