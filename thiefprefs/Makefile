ARCHS = arm64 arm64e

SDKVERSION = 13.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = thiefprefs

thiefprefs_FILES = BRUHRootListController.m
thiefprefs_INSTALL_PATH = /Library/PreferenceBundles
thiefprefs_FRAMEWORKS = UIKit
thiefprefs_PRIVATE_FRAMEWORKS = Preferences
thiefprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/thiefprefs.plist$(ECHO_END)
