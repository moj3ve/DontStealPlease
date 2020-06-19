#import "DontStealPlease.h"

/*
* MASSIVE props to Greg0109 for all of his help with this tweak.
*/

BOOL isItLocked() {
	BOOL locked;
	if (isEnabled) {
		locked =  [[%c(SBLockStateAggregator) sharedInstance] lockState];
	} else {
		locked = FALSE;
	}
	return locked;
}


%hook SBLockHardwareButtonActions
-(void)performSOSActionsWithUUID:(id)arg1 triggerMechanism:(long long)arg2 completion:(/*^block*/id)arg3 {
    BOOL locked = isItLocked();
    if (!locked || (SOS && arg2 == 2)) {
%orig;
    }        
}
-(void)performLongPressActions {
	LAContext *context = [LAContext new];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
    	if (context.biometryType == 1) {
    		BOOL locked = isItLocked();
    		if (!locked) {
    			%orig;
    		}
    	} else {
    		%orig;
    	}
    }
}
-(void)performForceResetSequenceBeganActions {
	BOOL locked = isItLocked();
	  if (!locked) {
	  	%orig;
	  }
}
%end

%ctor {
	loadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ajaidan.thiefprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}