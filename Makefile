ARCHS = arm64 arm64e

SDKVERSION = 13.5

INSTALL_TARGET_PROCESSES = test

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DontStealPlease

DontStealPlease_FILES = Tweak.xm
DontStealPlease_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
