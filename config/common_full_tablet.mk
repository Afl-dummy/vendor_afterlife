# Inherit mobile full common Afterlife stuff
$(call inherit-product, vendor/afterlife/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/afterlife/config/tablet.mk)

$(call inherit-product, vendor/afterlife/config/telephony.mk)
