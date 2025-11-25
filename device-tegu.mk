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
include device/google/gs-common/bcmbt/bluetooth.mk
include device/google/gs-common/touch/gti/predump_gti.mk
include device/google/gs-common/touch/syna/predump_syna20.mk
include device/google/gs-common/gril/aidl/2.0/gril_aidl.mk

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

# Recovery files
PRODUCT_COPY_FILES += \
        device/google/tegu/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.tegu.rc

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

# lhbm peak brightness delay: decided by kernel
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=0

# Bluetooth HAL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.a2dp_offload.supported=true \
    persist.bluetooth.a2dp_offload.disabled=false \
    persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac-opus

# Bluetooth OPUS codec
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.opus.enabled=true

# POF
PRODUCT_PRODUCT_PROPERTIES += \
    ro.bluetooth.finder.supported=true

# DCK properties based on target
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gms.dck.eligible_wcc=2 \
    ro.gms.dck.se_capability=1

# Bluetooth AAC VBR
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.a2dp_aac.vbr_supported=true

# Bluetooth Super Wide Band
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.hfp.swb.supported=true

# default BDADDR for EVB only
PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.bluetooth.evb_bdaddr="22:22:22:33:44:55"

# HdMic Audio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.app.audio.gsenet.version=1

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

# Audio CCA property
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.audio.cca.enabled=false

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

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += \
    device/google/tegu/powerstats/tegu

# WiFi Overlay
PRODUCT_PACKAGES += \
    WifiOverlay2024_M25

# Settings Overlay
PRODUCT_PACKAGES += \
    SettingsTeguOverlay

# Location
BOARD_VENDOR_SEPOLICY_DIRS += device/google/gs-common/gps/lsi/sepolicy

# For GPS property
PRODUCT_VENDOR_PROPERTIES += ro.vendor.gps.pps.enabled=true

PRODUCT_VENDOR_PROPERTIES += \
	persist.device_config.configuration.disable_rescue_party=true

# OIS with system imu
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.ois_with_system_imu=true

# Allow external binning setting
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.allow_external_binning_setting=true

# Camera Vendor property
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.front_720P_always_binning=true

# Enable camera exif model/make reporting
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.exif_reveal_make_model=true

# Media Performance Class 13
PRODUCT_PROPERTY_OVERRIDES += ro.odm.build.media_performance_class=33

# Display function property settings
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    vendor.display.lbe.supported=1 \
    ro.vendor.primarydisplay.google-tg4a.temperature_path=/dev/thermal/tz-by-name/disp_therm/temp \
    ro.vendor.display.read_temp_interval=30

# Vibrator HAL
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.vibrator.hal.f0.comp.enabled=1 \
    ro.vendor.vibrator.hal.redc.comp.enabled=0 \
    persist.vendor.vibrator.hal.context.enable=false \
    persist.vendor.vibrator.hal.context.scale=40 \
    persist.vendor.vibrator.hal.context.fade=true \
    persist.vendor.vibrator.hal.context.cooldowntime=1600 \
    persist.vendor.vibrator.hal.context.settlingtime=5000

# Override Output Distortion Gain
PRODUCT_VENDOR_PROPERTIES += \
    vendor.audio.hapticgenerator.distortion.output.gain=0.29

# Setup Wizard device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.enable_quick_start_flow=true

# Quick Start device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    ro.quick_start.oem_id=00e0 \
    ro.quick_start.device_id=tegu

# PKVM Memory Reclaim
PRODUCT_VENDOR_PROPERTIES += \
    hypervisor.memory_reclaim.supported=1

# Fingerprint exposure compensation
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.auth_filter.mt_filter.enabled=true \
    persist.vendor.udfps.boost_whole_auth_path_supported=true \
    persist.vendor.udfps.capture_retrying_acquired_msg_supported=false \
    persist.vendor.udfps.fps_touch_handler_supported=false \
    persist.vendor.udfps.fps_touch_handler.handle_down_up_events=true \
    persist.vendor.udfps.fth.touch_resolution_scaling_factor=10 \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true \
    persist.vendor.udfps.max_touch_filter_supported=true \
    persist.vendor.udfps.set_lhbm_in_advance=true \
    persist.vendor.udfps.auto_exposure_compensation_supported=true

# Telephony Satellite Feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Set support for LEA multicodec
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.core.le_audio.codec_extension_aidl.enabled=true

# Enable APF by default
PRODUCT_VENDOR_PROPERTIES += \
    vendor.powerhal.apf_disabled=false \
    vendor.powerhal.apf_enabled=true

# Increment the SVN for any official public releases
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.build.svn=18

# Set device family property for SMR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.device_family=CM4KM4TK4TG4

# ANGLE - Almost Native Graphics Layer Engine
PRODUCT_PACKAGES += \
    ANGLE \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

# Dumpstate
PRODUCT_PACKAGES += \
    dump_gsc.sh

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

# Wireless charging
include device/google/gs-common/wireless_charger/wireless_charger.mk
