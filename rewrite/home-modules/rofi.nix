{config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
  };

  # Matugen config for rofi
  # This tells Matugen how to write the rasi file
  xdg.configFile."matugen/templates/rofi-colors.rasi".text = ''
    * {
    main-rgba:         rgba({{colors.surface.default.red}}, {{colors.surface.default.green}}, {{colors.surface.default.blue}}, 0.92);
    main-bg:           {{colors.surface.default.hex}};
    main-fg:           {{colors.primary.default.hex}};
    main-br:           {{colors.primary_container.default.hex}};

    select-bg:         {{colors.surface_container.default.hex}};
    select-fg:         {{colors.tertiary.default.hex}};

    separatorcolor:    transparent;
    border-color:      {{colors.error.default.hex}};
    }
    '';

  # 2. THE CONFIG (The Instruction)
  # This tells Matugen where to find the template and where to save the result
  xdg.configFile."matugen/config.toml".text = ''
    [config]

    [templates.rofi]
    input_path = '${config.home.homeDirectory}/.config/matugen/templates/rofi-colors.rasi'
    output_path = '${config.home.homeDirectory}/.config/rofi/colors.rasi'
  '';

  # 3. ROFI CONFIG
  xdg.configFile."rofi/launcher.rasi".text = ''
/*****----- Configuration -----*****/
configuration {
	modi:                       "drun";
    show-icons:                 true;
    display-drun:               "APPS";
	drun-display-format:        "{name}";
	window-format:              "{w} · {c} · {t}";
}

/*****----- Global Properties -----*****/
@theme "~/.config/rofi/colors.rasi"
* {
    font:                        "Fira Code Nerd Font 12";
    background:                  @main-bg;
    background-alt:              @main-br;
    foreground:                  @main-fg;
    selected:                    @select-fg;
    active:                      @select-bg;
    urgent:                      red;
}

/*****----- Main Window -----*****/
window {
    /* properties for window widget */
    location:                    center;
    anchor:                      center;
    fullscreen:                  false;
    width:                       40%;
    x-offset:                    0px;
    y-offset:                    0px;

    /* properties for all widgets */
    enabled:                     true;
    border:                      0px solid;
    border-color:                @background-alt;
    cursor:                      "default";
    background-color:            transparent;
}

/*****----- Main Box -----*****/
mainbox {
    border-radius:               0px;
    enabled:                     true;
    spacing:                     0px;
    background-color:            transparent;
    orientation:                 vertical;
    children:                    [ "inputbar", "listbox" ];
}

/*imagebox {
    padding:                     20px;
    background-color:            transparent;
    background-image:            url("~/Pictures/Wallpapers/current.set", height); 
    orientation:                 vertical;
    children:                    [ "inputbar" ];
}*/

listbox {
    spacing:                     20px;
    padding:                     20px;
    background-color:            @background;
    orientation:                 vertical;
    children:                    [ "message", "listview" ];
}

dummy {
    background-color:            transparent;
}

/*****----- Inputbar -----*****/
inputbar {
    enabled:                     true;
    spacing:                     10px;
    padding:                     20px;
    border-radius:               0px;
    background-color:            @background-alt;
    text-color:                  @foreground;
    children:                    [ "textbox-prompt-colon", "entry" ];
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         " ";
    background-color:            inherit;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    background-color:            inherit;
    text-color:                  inherit;
    cursor:                      text;
    placeholder:                 "Search";
    placeholder-color:           inherit;
}

/*****----- Mode Switcher -----*****/
/*mode-switcher{
    enabled:                     true;
    spacing:                     20px;
    padding:                     20px;
    background-color:            transparent;
    text-color:                  @foreground;
}
button {
    padding:                     15px;
    border-radius:               10px;
    background-color:            @background-alt;
    text-color:                  inherit;
    cursor:                      pointer;
}
button selected {
    background-color:            @select-fg;
    text-color:                  @select-bg;
}
*/
/*****----- Listview -----*****/
listview {
    enabled:                     true;
    columns:                     1;
    lines:                       8;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      vertical;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;
    
    spacing:                     10px;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      "default";
}

/*****----- Elements -----*****/
element {
    enabled:                     true;
    spacing:                     15px;
    padding:                     8px;
    border-radius:               10px;
    background-color:            transparent;
    text-color:                  @foreground;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            inherit;
    text-color:                  inherit;
}
element normal.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
}
element normal.active {
    background-color:            @active;
    text-color:                  @foreground;
}
element selected.normal {
    background-color:            @select-fg;
    text-color:                  @select-bg;
}
element selected.urgent {
    background-color:            @urgent;
    text-color:                  @foreground;
}
element selected.active {
    background-color:            @urgent;
    text-color:                  @foreground;
}
element-icon {
    background-color:            transparent;
    text-color:                  inherit;
    size:                        32px;
    cursor:                      inherit;
}
element-text {
    background-color:            transparent;
    text-color:                  inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}

/*****----- Message -----*****/
message {
    background-color:            transparent;
}
textbox {
    padding:                     15px;
    border-radius:               10px;
    background-color:            @background-alt;
    text-color:                  @foreground;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}
error-message {
    padding:                     15px;
    border-radius:               20px;
    background-color:            @background;
    text-color:                  @foreground;
}
  '';

    # 3. ROFI CONFIG
  xdg.configFile."rofi/wallpaper.rasi".text = ''
   configuration {
        modi: "drun";
        show-icons: true;
        drun-display-format: "{name}";
        font: "Fira Code Nerd Font 12";
    }

    @theme "~/.config/rofi/colors.rasi"

    window {
        enabled: true;
        fullscreen: false;
        width: 100%;
        transparency: "real";
        cursor: "default";
        spacing: 0px;
        padding: 0px;
        border: 0px solid;
        border-color: @border-color;
        border-radius: 0px;
        background-color: transparent;
    }

    mainbox {
        enabled: true;
        children: [ "listview" ];
        background-color: @main-rgba;
    }

    listview {
        enabled: true;
        layout: vertical;
        lines: 2;
        columns: 6;
        fixed-columns: true;
        spacing: 5px;
        padding: 25px;
        cycle: true;
        dynamic: false;
        scrollbar: false;
        reverse: false;
        cursor: "default";
        background-color: transparent;
        text-color: @main-fg;
        align-items: center;
    }

    element {
        width: 16.66%;        
        halign: center;
        enabled: true;
        orientation: vertical;
        padding: 20px;
        spacing: 30px;
        cursor: pointer;
        background-color: transparent;
        text-color: @main-fg;
        border-radius: 0px;
    }

    element selected.normal {
        background-color: @select-bg;
        text-color: @select-fg;
        border-color: @border-color;
        border: 2px solid;
        border-radius: 4px;
    }

    element-icon {
        size: 20%;
        horizontal-align: 0.5;
        vertical-align: 0.5;
        cursor: inherit;
        background-color: transparent;
        text-color: inherit;
    }

    element-text {
        padding: 40px 10px 20px;
        height: 20%;
        vertical-align: 0.5;
        horizontal-align: 0.5;
        cursor: inherit;
        background-color: transparent;
        text-color: inherit;
    }
  '';
}
