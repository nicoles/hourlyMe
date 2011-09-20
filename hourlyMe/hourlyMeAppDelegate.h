//
//  hourlyMeAppDelegate.h
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class hourlyMeViewController;

@interface hourlyMeAppDelegate : NSObject <UIApplicationDelegate>{
    UITabBarController *rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@property (nonatomic, retain) IBOutlet hourlyMeViewController *viewController;

@end
