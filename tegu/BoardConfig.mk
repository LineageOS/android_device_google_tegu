#
# SPDX-FileCopyrightText: 2020 The Android Open-Source Project
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

TARGET_BOARD_INFO_FILE := device/google/tegu/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := tegu
TARGET_SCREEN_DENSITY := 420

include device/google/zumapro/BoardConfig-common.mk
include device/google/tegu/sepolicy/tegu-sepolicy.mk
include device/google/tegu/wifi/BoardConfig-wifi.mk

# Kernel modules
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist.vendor_kernel_boot
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_kernel_boot))
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD += $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW)
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES += $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_RAW)))

include $(VENDOR_PATH)/BoardConfigVendor.mk
