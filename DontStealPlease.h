#define PLIST_PATH @"/var/mobile/Library/Preferences/com.ajaidan.thiefprefs.plist"
#import <LocalAuthentication/LAContext.h>

@interface SBLockHardwareButtonActions
- (void)performForceResetSequenceBeganActions;
- (void)performSOSActionsWithUUID:(id)arg1 triggerMechanism:(long long)arg2 completion:(/*^block*/ id)arg3;
- (void)performLongPressActions;
@end

@interface SBLockStateAggregator : NSObject
+ (id)sharedInstance;
- (id)init;
- (void)dealloc;
- (id)description;
- (unsigned long long)lockState;
- (void)_updateLockState;
- (BOOL)hasAnyLockState;
- (id)_descriptionForLockState:(unsigned long long)arg1;
@end

@interface SBTelephonyManager : NSObject
+ (id)sharedTelephonyManager;
- (BOOL)isInAirplaneMode;
@end

@interface SBWiFiManager
- (void)setWiFiEnabled:(BOOL)arg1;
@end

// Main switch
BOOL isEnabled;

BOOL SOS;

static void loadPrefs()
{
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
    isEnabled = [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : YES;
    SOS = [prefs objectForKey:@"SOS"] ? [[prefs objectForKey:@"SOS"] boolValue] : YES;
}