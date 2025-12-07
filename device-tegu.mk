#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

SHIPPING_API_LEVEL := 35

PRODUCT_PACKAGES += \
	hwservicemanager \
	android.hidl.allocator@1.0-service

TARGET_LINUX_KERNEL_VERSION := 6.1
TARGET_KERNEL_DEVICE := tegu
TARGET_KERNEL_DIR := device/google/$(TARGET_KERNEL_DEVICE)-kernels/$(TARGET_LINUX_KERNEL_VERSION)
TARGET_KERNEL_PLATFORM_SOURCE := google/gs-$(TARGET_LINUX_KERNEL_VERSION)

ifneq ($(TARGET_BOOTS_16K),true)
PRODUCT_16K_DEVELOPER_OPTION := true
endif

DEVICE_PACKAGE_OVERLAYS += device/google/tegu/tegu/overlay
DEVICE_PACKAGE_OVERLAYS += device/google/tegu/overlay-lineage

# Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

include device/google/zumapro/device-shipping-common.mk

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml

# Recovery files
PRODUCT_COPY_FILES += \
    device/google/tegu/recovery/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.tegu.rc

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml

PRODUCT_PACKAGES += \
	android.hardware.nfc-service.st \
	NfcOverlayTegu

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element-service.thales

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml

# Bluetooth OPUS codec
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.opus.enabled=true

# POF
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bluetooth.finder.supported=true

# Bluetooth AAC VBR
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.a2dp_aac.vbr_supported=true

# Bluetooth Super Wide Band
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.hfp.swb.supported=true

# Bluetooth LE Audio
PRODUCT_PRODUCT_PROPERTIES += \
	ro.bluetooth.leaudio_switcher.supported=true \
	bluetooth.profile.bap.unicast.client.enabled=true \
	bluetooth.profile.csip.set_coordinator.enabled=true \
	bluetooth.profile.hap.client.enabled=true \
	bluetooth.profile.mcp.server.enabled=true \
	bluetooth.profile.ccp.server.enabled=true \
	bluetooth.profile.vcp.controller.enabled=true \

# Bluetooth LE Audio enable hardware offloading
PRODUCT_PRODUCT_PROPERTIES += \
	ro.bluetooth.leaudio_offload.supported=true \
	persist.bluetooth.leaudio_offload.disabled=false \

# LE Audio toggle shown by default
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.leaudio.toggle_visible=true

# LE Audio use classic connection by default
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bluetooth.leaudio.le_audio_connection_by_default=true

# Bluetooth LE Audio CIS handover to SCO
# Set the property only for the controller couldn't support CIS/SCO simultaneously. More detailed in b/242908683.
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.leaudio.notify.idle.during.call=true

# Bluetooth LE Audio enable dual mic SWB call
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.leaudio.dual_bidirection_swb.supported=true

# LE Audio Unicast Allowlist
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.leaudio.allow_list=SM-R510,WF-1000XM5

# Keyboard height ratio and bottom padding in dp for portrait mode
PRODUCT_PRODUCT_PROPERTIES += \
          ro.com.google.ime.kb_pad_port_b=8 \
          ro.com.google.ime.height_ratio=1.09

# Override BQR mask to enable LE Audio Choppy report, remove BTRT logging
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.bqr.event_mask=295006 \
    persist.bluetooth.bqr.vnd_quality_mask=16 \
    persist.bluetooth.bqr.vnd_trace_mask=0 \
    persist.bluetooth.vendor.btsnoop=false

# Enable Bluetooth AutoOn feature
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.server.automatic_turn_on=true

# Set support One-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# WiFi Overlay
PRODUCT_PACKAGES += \
    WifiOverlay2024_M25

# Settings Overlay
PRODUCT_PACKAGES += \
    SettingsTeguOverlay

# Setup Wizard device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.enable_quick_start_flow=true

# Quick Start device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    ro.quick_start.oem_id=00e0 \
    ro.quick_start.device_id=tegu

# Telephony Satellite Feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Set support for LEA multicodec
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.core.le_audio.codec_extension_aidl.enabled=true

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE

# EUICC
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.euicc.mep.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.mep.xml \
    frameworks/native/data/etc/android.hardware.telephony.euicc.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.euicc.xml

PRODUCT_PACKAGES += \
    EuiccSupportPixelOverlay

# Fingerprint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# GPS
PRODUCT_PACKAGES += \
    android.hardware.location.gps.prebuilt.xml

# Init
PRODUCT_PACKAGES += \
    init.recovery.tegu.touch.rc

# Overlays
PRODUCT_PACKAGES += \
    PixelDisplayServiceOverlayTegu

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/$(DEVICE_CODENAME)/vendor.prop

# Sensors
PRODUCT_PACKAGES += \
    sensors.dynamic_sensor_hal
