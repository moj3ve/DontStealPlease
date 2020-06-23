#include "BRUHRootListController.h"
#import <Preferences/PSSpecifier.h>
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>

@interface OBButtonTray : UIView
- (void)addButton:(id)arg1;
- (void)addCaptionText:(id)arg1;;
@end

@interface OBBoldTrayButton : UIButton
-(void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+(id)buttonWithType:(long long)arg1;
@end

@interface OBWelcomeController : UIViewController
- (OBButtonTray *)buttonTray;
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
@end

OBWelcomeController *welcomeController;

@implementation BRUHRootListController
- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

- (void)respring {
	AudioServicesPlaySystemSound(1520);
	pid_t pid;
	const char* args[] = {"sbreload", NULL, NULL};
	posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
}

- (void)sourceLink {
	AudioServicesPlaySystemSound(1520);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/ajaidan/dontstealplease"] options:@{} completionHandler:nil];
}

- (void)donate {
	AudioServicesPlaySystemSound(1520);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/ajaidan"] options:@{} completionHandler:nil];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}

- (void)respringPrompt {
	AudioServicesPlaySystemSound(1520);
	UIAlertController *respringAlert = [UIAlertController alertControllerWithTitle:@"StopAStupidThief"
	message:@"Do you want to respring?"
	preferredStyle:UIAlertControllerStyleActionSheet];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
		[self respring];
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Decline" style:UIAlertActionStyleCancel handler:nil];

	[respringAlert addAction:confirmAction];
	[respringAlert addAction:cancelAction];

	AudioServicesPlaySystemSound(1520);
	[self presentViewController:respringAlert animated:YES completion:nil];
}

-(void)setupWelcomeController {
	welcomeController = [[OBWelcomeController alloc] initWithTitle:@"DontStealPlease" detailText:@"A tweak to disable powering the device down when on the lock screen." icon:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/thiefprefs.bundle/WelcomeIcon.png"]];
	[welcomeController addBulletedListItemWithTitle:@"Rewritten" description:@"Remade from StopAStupidThief to fullfill it's purpose elegantly." image:[UIImage systemImageNamed:@"gear"]];
	[welcomeController addBulletedListItemWithTitle:@"Optimized" description:@"Extensively tested for battery drain." image:[UIImage systemImageNamed:@"gear"]];
	[welcomeController.buttonTray addCaptionText:@"Made with ❤️ by ajaidan0."];

	OBBoldTrayButton* continueButton = [OBBoldTrayButton buttonWithType:1];
	[continueButton addTarget:self action:@selector(dismissWelcomeController) forControlEvents:UIControlEventTouchUpInside];
	[continueButton setTitle:@"Continue" forState:UIControlStateNormal];
	[continueButton setClipsToBounds:YES]; // There seems to be an internal issue with the properties, so you may need to force this to YES like so.
	[continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; // There seems to be an internal issue with the properties, so you may need to force this to be [UIColor whiteColor] like so.
	[continueButton.layer setCornerRadius:15]; // Set your button's corner radius. This can be whatever. If this doesn't work, make sure you make setClipsToBounds to YES.
	[welcomeController.buttonTray addButton:continueButton];

	welcomeController.modalPresentationStyle = UIModalPresentationPageSheet; // The same style stock iOS uses.
	welcomeController.modalInPresentation = YES; //Set this to yes if you don't want the user to dismiss this on a down swipe.
	[self presentViewController:welcomeController animated:YES completion:nil]; // Don't forget to present it!
}

-(void)viewDidLoad {
	NSString *path = @"/var/mobile/Library/Preferences/com.ajaidan.mavalryprefs.plist";
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	NSNumber *didShowOBWelcomeController = [settings valueForKey:@"didShowOBWelcomeController"] ?: @0;
	if([didShowOBWelcomeController isEqual:@0]){
		[self setupWelcomeController];
	}
	[super viewDidLoad];
}

-(void)dismissWelcomeController {
	NSString *path = @"/var/mobile/Library/Preferences/com.ajaidan.mavalryprefs.plist";
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:@1 forKey:@"didShowOBWelcomeController"];
	[settings writeToFile:path atomically:YES];
	AudioServicesPlaySystemSound(1520);
	[welcomeController dismissViewControllerAnimated:YES completion:nil];
}
@end