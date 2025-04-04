set -e

BOOTLOADER_HEX="build/pslab-bootloader.hex"
FIRMWARE_HEX="build/pslab-firmware.hex"
OUTPUT_HEX="build/combined.hex"

srec_cat \
  $BOOTLOADER_HEX -intel -crop 0x0000 0x3000 \
  -fill 0xFF 0x0000 0x3000 \
  -offset 0x0000 \
  $FIRMWARE_HEX -intel -crop 0x3000 0x55000 \
  -fill 0xFF 0x3000 0x55000 \
  -offset 0x0000 \
  $BOOTLOADER_HEX -intel -crop 0x55000 0xFFFFFFFF \
  -fill 0xFF 0x55000 0xFFFFFFFF --big \
  -offset 0x0000 \
  -o $OUTPUT_HEX -intel
