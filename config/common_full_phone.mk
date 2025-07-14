# Inherit mobile full common Afterlife stuff
$(call inherit-product, vendor/afterlife/config/common_mobile_full.mk)

# Enable support of one-handed mode and BT auto-on
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true \
    bluetooth.server.automatic_turn_on=true

$(call inherit-product, vendor/afterlife/config/telephony.mk)
