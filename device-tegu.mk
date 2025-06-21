#
# Copyright (C) 2021 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

SHIPPING_API_LEVEL := 35

PRODUCT_PACKAGES += \
	hwservicemanager \
	android.hidl.allocator@1.0-service

USES_RADIOEXT_V1_7 = false
USES_RADIOEXT_V2_0 = true

ifdef RELEASE_GOOGLE_TEGU_RADIO_DIR
RELEASE_GOOGLE_PRODUCT_RADIO_DIR := $(RELEASE_GOOGLE_TEGU_RADIO_DIR)
endif
ifdef RELEASE_GOOGLE_TEGU_RADIOCFG_DIR
RELEASE_GOOGLE_PRODUCT_RADIOCFG_DIR := $(RELEASE_GOOGLE_TEGU_RADIOCFG_DIR)
endif
RELEASE_GOOGLE_BOOTLOADER_TEGU_DIR ?= 25D4# Keep this for pdk TODO: b/327119000
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_TEGU_DIR)
$(call soong_config_set,tegu_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_TEGU_DIR))

TARGET_KERNEL_DEVICE := tegu
TARGET_KERNEL_DIR := device/google/$(TARGET_KERNEL_DEVICE)-kernels/$(TARGET_LINUX_KERNEL_VERSION)
TARGET_KERNEL_PLATFORM_SOURCE := google/gs-$(TARGET_LINUX_KERNEL_VERSION)

ifneq ($(TARGET_BOOTS_16K),true)
PRODUCT_16K_DEVELOPER_OPTION := true
endif

# display
DEVICE_PACKAGE_OVERLAYS += device/google/tegu/tegu/overlay

USE_AUDIO_HAL_AIDL := true

include device/google/tegu/audio/tegu/audio-tables.mk
include device/google/zumapro/device-shipping-common.mk
include device/google/gs-common/bcmbt/bluetooth.mk
include device/google/gs-common/touch/gti/predump_gti.mk
include device/google/gs-common/touch/syna/predump_syna20.mk
include device/google/gs-common/gril/aidl/2.0/gril_aidl.mk

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,tegu)
$(call soong_config_set,lyric,tuning_product,tegu)
$(call soong_config_set,google3a_config,target_device,tegu)
$(call soong_config_set,lyric,radioext_interface_type,aidl)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

# Init files
PRODUCT_COPY_FILES += \
	device/google/tegu/conf/init.tegu.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.tegu.rc

# Recovery files
PRODUCT_COPY_FILES += \
        device/google/tegu/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.tegu.rc

# Enable AIDL based oemservice HAL
USE_OEMSERVICE_HAL_AIDL := true
# Enable AIDL based radioExternal HAL
USE_RADIOEXTERNAL_HAL_AIDL := true

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
	device/google/tegu/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
	device/google/tegu/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	$(RELEASE_PACKAGE_NFC_STACK) \
	Tag \
	android.hardware.nfc-service.st \
	NfcOverlayTegu

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element-service.thales

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/tegu/nfc/libse-gto-hal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf

# lhbm peak brightness delay: decided by kernel
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=0

PRODUCT_SOONG_NAMESPACES += device/google/tegu/radio/coex

# Coex Configs
PRODUCT_PACKAGES += \
        display_primary_ssc_coex_table

# Thermal VT estimator
PRODUCT_PACKAGES += \
    libthermal_tflite_wrapper

# Thermal Model
TARGET_VENDOR_THERMAL_CONFIG_PATH := device/google/tegu/thermal
PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/vt_estimation_model_tegu.tflite:$(TARGET_COPY_OUT_VENDOR)/etc/vt_estimation_model.tflite \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/vt_estimation_odpm_model_tegu.tflite:$(TARGET_COPY_OUT_VENDOR)/etc/vt_estimation_odpm_model.tflite \
	$(TARGET_VENDOR_THERMAL_CONFIG_PATH)/vt_speaker_estimation_model_tegu.tflite:$(TARGET_COPY_OUT_VENDOR)/etc/vt_speaker_estimation_model.tflite \

# Bluetooth HAL
PRODUCT_COPY_FILES += \
	device/google/tegu/bluetooth/bt_vendor_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth/bt_vendor_overlay.conf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.a2dp_offload.supported=true \
    persist.bluetooth.a2dp_offload.disabled=false \
    persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac-opus

# Bluetooth OPUS codec
PRODUCT_PRODUCT_PROPERTIES += \
    persist.bluetooth.opus.enabled=true

# Bluetooth Tx power caps
PRODUCT_COPY_FILES += \
    device/google/tegu/bluetooth/bluetooth_power_limits_tegu.csv:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_power_limits.csv \
    device/google/tegu/bluetooth/bluetooth_power_limits_tegu_EU.csv:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_power_limits_EU.csv \
    device/google/tegu/bluetooth/bluetooth_power_limits_tegu_JP.csv:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_power_limits_JP.csv \
    device/google/tegu/bluetooth/bluetooth_power_limits_tegu_US.csv:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_power_limits_US.csv \
    device/google/tegu/bluetooth/bluetooth_power_limits_tegu_CA.csv:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_power_limits_CA.csv

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

ifneq ($(USE_AUDIO_HAL_AIDL),true)
# HIDL Sound Dose
PRODUCT_PACKAGES += \
	android.hardware.audio.sounddose-vendor-impl \
	audio_sounddose_aoc
endif

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

# Include Bluetooth soong namespace
PRODUCT_SOONG_NAMESPACES += \
    device/google/tegu/bluetooth

# Bluetooth LE Auido offload capabilities setting
PRODUCT_PACKAGES += \
    le_audio_codec_capabilities.xml

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

# Keymaster HAL
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# Gatekeeper HAL
#LOCAL_GATEKEEPER_PRODUCT_PACKAGE ?= android.hardware.gatekeeper@1.0-service.software


# Gatekeeper
# PRODUCT_PACKAGES += \
# 	android.hardware.gatekeeper@1.0-service.software

# Keymint replaces Keymaster
# PRODUCT_PACKAGES += \
# 	android.hardware.security.keymint-service

# Keymaster
#PRODUCT_PACKAGES += \
#	android.hardware.keymaster@4.0-impl \
#	android.hardware.keymaster@4.0-service

#PRODUCT_PACKAGES += android.hardware.keymaster@4.0-service.remote
#PRODUCT_PACKAGES += android.hardware.keymaster@4.1-service.remote
#LOCAL_KEYMASTER_PRODUCT_PACKAGE := android.hardware.keymaster@4.1-service
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# PRODUCT_PROPERTY_OVERRIDES += \
# 	ro.hardware.keystore_desede=true \
# 	ro.hardware.keystore=software \
# 	ro.hardware.gatekeeper=software

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
include device/google/tegu/location/device-gnss.mk
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
$(call soong_config_set,haptics,kernel_ver,v$(subst .,_,$(TARGET_LINUX_KERNEL_VERSION)))
ADAPTIVE_HAPTICS_FEATURE := adaptive_haptics_v1
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

# Battery Mitigation Config
ifeq (,$(TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH))
TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH := device/google/tegu/battery_mitigation
endif

# Telephony Satellite Feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

PRODUCT_COPY_FILES += \
	$(TARGET_VENDOR_BATTERY_MITIGATION_CONFIG_PATH)/bm_config_tegu.json:$(TARGET_COPY_OUT_VENDOR)/etc/bm_config.json

# IRadio HAL
USE_RADIO_HAL_2_1 := false
USE_RADIO_HAL_2_2 := true

# Allow RIL enable/disable ENDC mode during Radio OFF
ALLOW_SET_ENDC_DURING_RADIO_OFF := true

# Set support for LEA multicodec
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.core.le_audio.codec_extension_aidl.enabled=true

# LE Audio configuration scenarios
PRODUCT_COPY_FILES += \
    device/google/tegu/bluetooth/audio_set_scenarios.json:$(TARGET_COPY_OUT_VENDOR)/etc/aidl/le_audio/aidl_audio_set_scenarios.json

PRODUCT_COPY_FILES += \
    device/google/tegu/bluetooth/audio_set_configurations.json:$(TARGET_COPY_OUT_VENDOR)/etc/aidl/le_audio/aidl_audio_set_configurations.json

# Enable APF by default
PRODUCT_VENDOR_PROPERTIES += \
    vendor.powerhal.apf_disabled=false \
    vendor.powerhal.apf_enabled=true

# Increment the SVN for any official public releases
ifdef RELEASE_SVN_TEGU
TARGET_SVN ?= $(RELEASE_SVN_TEGU)
else
# Set this for older releases that don't use build flag
TARGET_SVN ?= 6
endif

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.build.svn=$(TARGET_SVN)

# Set device family property for SMR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.device_family=CM4KM4TK4TG4

# Set build properties for SMR builds
ifeq ($(RELEASE_IS_SMR), true)
    ifneq (,$(RELEASE_BASE_OS_TEGU))
        PRODUCT_BASE_OS := $(RELEASE_BASE_OS_TEGU)
    endif
endif

# Set build properties for EMR builds
ifeq ($(RELEASE_IS_EMR), true)
    ifneq (,$(RELEASE_BASE_OS_TEGU))
        PRODUCT_PROPERTY_OVERRIDES += \
        ro.build.version.emergency_base_os=$(RELEASE_BASE_OS_TEGU)
    endif
endif
