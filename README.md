
# ArchHyperland

Este es un script de instalación para configurar Hyperland en Arch Linux.

## Pasos para la instalación

1. **Actualizar el sistema**:
   ```bash
   sudo pacman -Syu
   ```

2. **Instalar Wayland y los componentes necesarios**:
   ```bash
   sudo pacman -S wayland wayland-utils xorg-xwayland mesa vulkan-intel base-devel git pipewire pipewire-alsa pipewire-pulse wireplumber brightnessctl tlp swaybg mako alacritty rofi ranger nemo ttf-nerd-fonts-symbols ttf-firacode ttf-jetbrains-mono-nerd wl-clipboard qt5-wayland qt6-wayland gtk3 gtk4
   ```

3. **Clonar y compilar yay desde AUR**:
   ```bash
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```

4. **Instalar Hyperland y Eww desde AUR**:
   ```bash
   yay -S hyperland eww
   ```

5. **Instalar el navegador Brave**:
   ```bash
   yay -S brave-bin
   ```

6. **Instalar otros paquetes útiles**:
   ```bash
   sudo pacman -S iwd libreoffice-fresh gimp vlc
   ```

7. **Configurar el firewall y la seguridad**:
   ```bash
   sudo pacman -S ufw
   sudo systemctl enable ufw
   sudo systemctl start ufw
   ```

8. **Limpiar paquetes antiguos**:
   ```bash
   sudo pacman -S paccache
   ```

9. **Instalar temas y iconos**:
   ```bash
   yay -S whitesur-gtk-theme-git nordzy-icons
   sudo pacman -S lxappearance
   ```

10. **Instalar y configurar SDDM (opcional)**:
    ```bash
    sudo pacman -S sddm sddm-kcm
    sudo systemctl enable sddm.service
    sudo systemctl start sddm.service
    ```

11. **Instalar bloqueo de pantalla (Swaylock)**:
    ```bash
    yay -S swaylock
    ```

## ¡Listo! Ahora tienes Hyperland configurado en tu Arch Linux.
