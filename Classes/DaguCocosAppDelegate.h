//
//  DaguCocosAppDelegate.h
//  DaguCocos
//
//  Created by Tiancai HB on 11-10-2.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

//#import <UIKit/UIKit.h>

@class RootViewController;

@interface DaguCocosAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
