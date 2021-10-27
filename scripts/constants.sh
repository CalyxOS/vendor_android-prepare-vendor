#!/usr/bin/env bash

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && exit 1

# List of supported devices
declare -ra SUPPORTED_DEVICES=(
  "blueline"      # Pixel 3
  "crosshatch"    # Pixel 3 XL
  "flame"         # Pixel 4
  "coral"         # Pixel 4 XL
  "sargo"         # Pixel 3a
  "bonito"        # Pixel 3a XL
  "sunfish"       # Pixel 4a
  "redfin"        # Pixel 5
  "bramble"       # Pixel 4a (5G)
  "barbet"        # Pixel 5a
)

# URLs to download factory images from
readonly NID_URL="https://google.com"
readonly GURL="https://developers.google.com/android/images"
readonly GURL2="https://developers.google.com/android/ota"

# oatdump dependencies URLs as compiled from AOSP matching API levels
readonly L_OATDUMP_URL_API31='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21574&authkey=ADSQA_DtfAmmk2c'
readonly D_OATDUMP_URL_API31='https://onedrive.live.com/download?cid=D1FAC8CC6BE2C2B0&resid=D1FAC8CC6BE2C2B0%21582&authkey=ABMMORAJ-GGjs2k'

readonly L_OATDUMP_API31_SIG='394a47491de4def3b825b22713f5ecfd8f16e00497f35213ffd83c2cc709384e'
readonly D_OATDUMP_API31_SIG='95ce6c296c5115861db3c876eb5bfd11cdc34deebace18462275368492c6ea87'

# sub-directories that contain bytecode archives
declare -ra SUBDIRS_WITH_BC=("app" "framework" "priv-app" "product/app" "product/framework" "product/priv-app" "system_ext/app" "system_ext/framework" "system_ext/priv-app")

# ART runtime files
declare -ra ART_FILE_EXTS=("odex" "oat" "art" "vdex")

# Files to skip from vendor partition when parsing factory images (for all configs)
declare -ra VENDOR_SKIP_FILES=(
  "build.prop"
  "compatibility_matrix.xml"
  "default.prop"
  "etc/NOTICE.xml.gz"
  "etc/wifi/wpa_supplicant.conf"
  "manifest.xml"
  "bin/toybox_vendor"
  "bin/toolbox"
  "bin/grep"
)

# Files to skip from vendor partition when parsing factory images (for naked config only)
declare -ra VENDOR_SKIP_FILES_NAKED=(
  "etc/selinux/nonplat_file_contexts"
  "etc/selinux/nonplat_hwservice_contexts"
  "etc/selinux/nonplat_mac_permissions.xml"
  "etc/selinux/nonplat_property_contexts"
  "etc/selinux/nonplat_seapp_contexts"
  "etc/selinux/nonplat_sepolicy.cil"
  "etc/selinux/nonplat_service_contexts"
  "etc/selinux/plat_sepolicy_vers.txt"
  "etc/selinux/precompiled_sepolicy"
  "etc/selinux/precompiled_sepolicy.plat_and_mapping.sha256"
  "etc/selinux/vndservice_contexts"
)
