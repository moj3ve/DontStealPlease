ARCHS = arm64 arm64e

export SDKVERSION = 13.5

0INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DontStealPlease

StopAStupidThief_FILES = DontStealPlease.xm
StopAStupidThief_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += thiefprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
