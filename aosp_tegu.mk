#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-License-Identifier: Apache-2.0
#

$(call inherit-product, device/google/zumapro/aosp_common.mk)
$(call inherit-product, device/google/tegu/device-tegu.mk)

PRODUCT_NAME := aosp_tegu
PRODUCT_DEVICE := tegu
PRODUCT_MODEL := Pixel 9a
PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Google

PRODUCT_NAME_FOR_ATTESTATION := tegu
PRODUCT_DEVICE_FOR_ATTESTATION := tegu
PRODUCT_MODEL_FOR_ATTESTATION := Pixel 9a
PRODUCT_BRAND_FOR_ATTESTATION := google
PRODUCT_MANUFACTURER_FOR_ATTESTATION := Google
