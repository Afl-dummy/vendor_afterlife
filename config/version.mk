PRODUCT_VERSION_MAJOR = 8
PRODUCT_VERSION_MINOR = 3

# versionin
AFTERLIFE_CODENAME := Liberum
AFTERLIFE_VERSION_EXTRA := Baklava

OFFICIAL_MAINTAINER := $(shell cat vendor/afterlife/signed/signed.mk | awk '{ print $$1 }')

ifeq ($(AFTERLIFE_VERSION_APPEND_TIME_OF_DAY),true)
    AFTERLIFE_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    AFTERLIFE_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

ifndef AFTERLIFE_BUILD_TYPE
    AFTERLIFE_BUILD_TYPE := COMMUNITY
endif

ifdef AFTERLIFE_MAINTAINER
    ifeq ($(filter $(AFTERLIFE_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(AFTERLIFE_MAINTAINER))
        $(warning "Lify: $(AFTERLIFE_MAINTAINER) is verified as official maintainer, build as official build.")
        AFTERLIFE_BUILD_TYPE := OFFICIAL

        PRODUCT_PACKAGES += \
            Updater

        PRODUCT_COPY_FILES += \
            vendor/afterlife/prebuilt/common/etc/init/init.afterlife-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.afterlife-updater.rc
    else
        $(warning "Lify: Unofficial maintainer detected, building as community build.")
    endif

    PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
        ro.afterlife.maintainer=$(AFTERLIFE_MAINTAINER)
else
    $(warning "Lify: No maintainer name detected, building as community build.")
endif

AFTERLIFE_VERSION_SUFFIX := $(AFTERLIFE_BUILD_TYPE)_$(AFTERLIFE_BUILD_DATE)

# Internal version
AFTERLIFE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(AFTERLIFE_CODENAME)-$(AFTERLIFE_VERSION_SUFFIX)

# Display version
AFTERLIFE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR)-$(AFTERLIFE_VERSION_SUFFIX)

# Codename version
AFTERLIFE_DISPLAY_VERSION_CODENAME := 16.0 | $(AFTERLIFE_CODENAME)

# AfterLife System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.afterlife.version=$(AFTERLIFE_VERSION) \
    ro.afterlife.releasetype=$(AFTERLIFE_BUILD_TYPE) \
    ro.afterlife.releasevarient=$(AFTERLIFE_ZIP_TYPE) \
    ro.afterlife.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.afterlife.version.codename=$(AFTERLIFE_CODENAME) \
    ro.afterlife.version.extra=$(AFTERLIFE_VERSION_EXTRA)
