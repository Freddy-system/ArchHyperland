<<<<<<< HEAD
# ArchHyperland
instalación de hyperland en arch
=======
# Actualización del sistema
sudo pacman -Syu

# Instalar Wayland y los componentes necesarios
sudo pacman -S wayland wayland-utils xorg-xwayland mesa vulkan-intel \
base-devel git pipewire pipewire-alsa pipewire-pulse wireplumber \
brightnessctl tlp swaybg mako alacritty rofi ranger nemo \
ttf-nerd-fonts-symbols ttf-firacode ttf-jetbrains-mono-nerd \
wl-clipboard qt5-wayland qt6-wayland gtk3 gtk4

# Clonar y compilar yay desde AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Instalar Hyperland y Eww desde AUR
yay -S hyperland eww

# Instalar navegador Brave
yay -S brave-bin

# Instalar otros paquetes útiles
sudo pacman -S iwd
sudo pacman -S libreoffice-fresh
sudo pacman -S gimp
sudo pacman -S vlc

# Configuración de seguridad y firewall
sudo pacman -S ufw
sudo systemctl enable ufw
sudo systemctl start ufw

# Limpiar paquetes antiguos
sudo pacman -S paccache

# Instalar temas y iconos
yay -S whitesur-gtk-theme-git
yay -S nordzy-icons
sudo pacman -S lxappearance

#
sudo pacman -S sddm sddm-kcm
sudo systemctl enable sddm.service
sudo systemctl start sddm.service

# bloqueo de pantalla
yay -S swaylock
>>>>>>> a865e70 (Primer commit: añadir script de instalación)
