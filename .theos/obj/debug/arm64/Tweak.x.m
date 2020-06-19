#line 1 "Tweak.x"
#import "Thief.h"


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBLockHardwareButtonActions; @class SBLockStateAggregator; 
static void (*_logos_orig$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$)(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL, id, long long, id); static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL, id, long long, id); static void (*_logos_orig$_ungrouped$SBLockHardwareButtonActions$performLongPressActions)(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performLongPressActions(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions)(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST, SEL); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBLockStateAggregator(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBLockStateAggregator"); } return _klass; }
#line 3 "Tweak.x"
BOOL isItLocked() {
	BOOL locked;
	if (isEnabled) {
		locked =  [[_logos_static_class_lookup$SBLockStateAggregator() sharedInstance] lockState];
	} else {
		locked = FALSE;
	}
	return locked;
}


static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, long long arg2, id arg3) {
    BOOL locked = isItLocked();
    if (!locked || (SOS && arg2 == 2)) {
_logos_orig$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$(self, _cmd, arg1, arg2, arg3);
    }        
}
static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performLongPressActions(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	LAContext *context = [LAContext new];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
    	if (context.biometryType == 1) {
    		BOOL locked = isItLocked();
    		if (!locked) {
    			_logos_orig$_ungrouped$SBLockHardwareButtonActions$performLongPressActions(self, _cmd);
    		}
    	} else {
    		_logos_orig$_ungrouped$SBLockHardwareButtonActions$performLongPressActions(self, _cmd);
    	}
    }
}
static void _logos_method$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions(_LOGOS_SELF_TYPE_NORMAL SBLockHardwareButtonActions* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	BOOL locked = isItLocked();
	  if (!locked) {
	  	_logos_orig$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions(self, _cmd);
	  }
}


static __attribute__((constructor)) void _logosLocalCtor_d26df6f8(int __unused argc, char __unused **argv, char __unused **envp) {
	loadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ajaidan.thiefprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBLockHardwareButtonActions = objc_getClass("SBLockHardwareButtonActions"); MSHookMessageEx(_logos_class$_ungrouped$SBLockHardwareButtonActions, @selector(performSOSActionsWithUUID:triggerMechanism:completion:), (IMP)&_logos_method$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$, (IMP*)&_logos_orig$_ungrouped$SBLockHardwareButtonActions$performSOSActionsWithUUID$triggerMechanism$completion$);MSHookMessageEx(_logos_class$_ungrouped$SBLockHardwareButtonActions, @selector(performLongPressActions), (IMP)&_logos_method$_ungrouped$SBLockHardwareButtonActions$performLongPressActions, (IMP*)&_logos_orig$_ungrouped$SBLockHardwareButtonActions$performLongPressActions);MSHookMessageEx(_logos_class$_ungrouped$SBLockHardwareButtonActions, @selector(performForceResetSequenceBeganActions), (IMP)&_logos_method$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions, (IMP*)&_logos_orig$_ungrouped$SBLockHardwareButtonActions$performForceResetSequenceBeganActions);} }
#line 46 "Tweak.x"
