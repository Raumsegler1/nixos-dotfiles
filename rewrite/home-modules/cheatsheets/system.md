# ❄️ My System/NixOS Cheat Sheet
    
**System rebuild**
    // update local git
    sudo git add .          
    // update flake & lockfile versions
    sudo nix flake update   
    // rebuild system using the flake "magnetar-next" and switch to new generation
    sudo nixos-rebuild switch --flake .#magnetar-next    
    nh os switch . -H magnetar-next   
    // rebuild system using the flake "magnetar-next" and add new generation to boot
    sudo nixos-rebuild boot --flake .#magnetar-next 
    nh os boot . -H magnetar-next   

**Nix / Home Manager**
    // test programs
    nix-shell -p <nixpkg>