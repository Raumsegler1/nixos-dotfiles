{config, pkgs, ... }:

{
  # Config for Macchina
  xdg.configFile."macchina/macchina.toml".text = ''
    # Specifies the network interface to use for the LocalIP readout
interface = "wlan0"

# Lengthen uptime output
long_uptime = true

# Lengthen shell output
long_shell = false

# Lengthen kernel output
long_kernel = false

# Toggle between displaying the current shell or your user's default one.
current_shell = true

# Toggle between displaying the number of physical or logical cores of your
# processor.
physical_cores = true

# Disks to show disk usage for. Defaults to `["/"]`.
# disks = ["/", "/home/user"]

# Show percentage next to disk information
disk_space_percentage = true

# Show percentage next to memory information
memory_percentage = true

# Themes need to be placed in "$XDG_CONFIG_DIR/macchina/themes" beforehand.
# e.g.:
#  if theme path is /home/foo/.config/macchina/themes/Sodium.toml
#  theme should be uncommented and set to "Sodium"
#
theme = "magnetar"

# Displays only the specified readouts.
# Accepted values (case-sensitive):
#   - Host
#   - Machine
#   - Kernel
#   - Distribution
#   - OperatingSystem
#   - DesktopEnvironment
#   - WindowManager
#   - Resolution
#   - Backlight
#   - Packages
#   - LocalIP
#   - Terminal
#   - Shell
#   - Uptime
#   - Processor
#   - ProcessorLoad
#   - Memory
#   - Battery
#   - GPU
#   - DiskSpace
# Example:
   show = ["Host", "Machine", "Kernel", "Distribution", "DesktopEnvironment", "Terminal", "Shell", "DiskSpace", "ProcessorLoad", "Memory", "GPU", "Processor" ]
  '';
  
  # Customization for Macchina
  xdg.configFile."macchina/themes/magnetar.toml".text = ''
    # Magnetar

title           = "Magnetar"
spacing         = 2
padding         = 0
hide_ascii      = true
separator       = " " # 
key_color       = "Cyan"
separator_color = "White"

[palette]
type = "Full"
visible = false

[custom_ascii]
path = "${config.home.homeDirectory}/.config/macchina/themes/ghost_ascii.txt"
color = "Cyan" # Optional: color the art

[bar]
glyph           = ""
symbol_open     = ''
symbol_close    = ''
hide_delimiters = true
visible         = true

[box]
border          = "rounded"
visible         = true

[box.inner_margin]
x               = 1
y               = 0

[randomize]
key_color       = false
separator_color = false

[keys]
host            = "Host"
kernel          = "Kernel"
battery         = "Battery"
os              = "OS"
de              = "DesktopEnv"
wm              = "WM"
distro          = "Distro"
terminal        = "Terminal"
shell           = "Shell"
packages        = "Packages"
uptime          = "Uptime"
memory          = "Memory"
machine         = "Machine"
local_ip        = "Local IP"
backlight       = "Brightness"
resolution      = "Resolution"
cpu_load        = "CPU Load"
cpu             = "CPU"
gpu             = "GPU"
disk_space      = "Disk Space"
  '';
  
  # Customization for Macchina
  xdg.configFile."macchina/themes/ghost_ascii.txt".text = ''
⠀⠀⣠⡶⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⣰⣿⠃⠀⠀⠀⠀⠀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣯⠀⠀⠀⠀⠀⠀⢠⣴⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀
⣿⣿⣿⣆⠀⢀⣀⣀⣴⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢻⣿⠋⠙⢿⣿⣿⡀⠀⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⠿⢆⣀⣼⣿⣿⣿⣿⡏⠀⢹⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⡀⣨⡙⠟⣩⣙⣡⣬⣴⣤⠏⠀⠀⠀⠀⠀⠀⣀⡀
⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⣀⣤⣾⣿⣿⡇
⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣇⠀⢸⣿⣿⠿⠿⠛⠃
⠀⠀⠀⠀⢠⣿⣿⢹⣿⢹⣿⣿⣿⢰⣿⠿⠃⠀⠀⠀⠀
⠀⢀⣀⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡛⠀⠀⠀⠀⠀⠀
⠀⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠛⠓⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠉⠀⠉⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
  '';
}
