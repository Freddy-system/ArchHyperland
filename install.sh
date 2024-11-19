#!/bin/bash

# Actualización del sistema
echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar Wayland y los componentes necesarios
echo "Instalando Wayland y dependencias..."
sudo pacman -S --noconfirm wayland wayland-utils xorg-xwayland mesa vulkan-intel \
base-devel git pipewire pipewire-alsa pipewire-pulse wireplumber \
brightnessctl tlp swaybg mako alacritty rofi ranger nemo \
ttf-nerd-fonts-symbols ttf-firacode ttf-jetbrains-mono-nerd \
wl-clipboard qt5-wayland qt6-wayland gtk3 gtk4

# Clonar y compilar yay desde AUR
echo "Clonando y compilando yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Instalar Hyperland y Eww desde AUR
echo "Instalando Hyperland y Eww..."
yay -S --noconfirm hyperland eww

# Instalar navegador Brave
echo "Instalando navegador Brave..."
yay -S --noconfirm brave-bin

# Instalar otros paquetes útiles
echo "Instalando paquetes útiles..."
sudo pacman -S --noconfirm iwd libreoffice-fresh gimp vlc

# Configuración de seguridad y firewall
echo "Configurando firewall..."
sudo pacman -S --noconfirm ufw
sudo systemctl enable ufw
sudo systemctl start ufw

# Limpiar paquetes antiguos
echo "Limpiando paquetes antiguos..."
sudo pacman -S --noconfirm paccache

# Instalar temas y iconos
echo "Instalando temas y iconos..."
yay -S --noconfirm whitesur-gtk-theme-git nordzy-icons
sudo pacman -S --noconfirm lxappearance

# Instalar SDDM y habilitar el servicio
echo "Instalando y configurando SDDM..."
sudo pacman -S --noconfirm sddm sddm-kcm
sudo systemctl enable sddm.service
sudo systemctl start sddm.service

# Instalar bloqueo de pantalla
echo "Instalando swaylock..."
yay -S --noconfirm swaylock

echo "Instalación completada. ¡Reinicia tu sistema!"
