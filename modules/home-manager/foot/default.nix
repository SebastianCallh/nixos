{config, lib, ...}:

{
  options.foot= with lib; {
    font = mkOption {
      type = types.str;
      default = "Consolas";
    };

    fontSize = mkOption {
      type = types.int;
      default = 10;
    };
  };

  config = { 
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "foot";
          font = "${config.foot.font}: size=${toString config.foot.fontSize}";
          dpi-aware = "yes";
          pad = "15x10";
        };
    
        mouse = {
          hide-when-typing = "yes";
        };
    
        colors = {
          background=config.colorScheme.palette.base01;
          foreground=config.colorScheme.palette.base05;
          regular0=config.colorScheme.palette.base00; # black
          regular1=config.colorScheme.palette.base08; # red
          regular2=config.colorScheme.palette.base0B; # green
          regular3=config.colorScheme.palette.base0A; # yellow
          regular4=config.colorScheme.palette.base0D; # blue
          regular5=config.colorScheme.palette.base0E; # magenta
          regular6=config.colorScheme.palette.base0C; # cyan
          regular7=config.colorScheme.palette.base06; # white
          alpha=1;
        };
      };
    };
  };
}
