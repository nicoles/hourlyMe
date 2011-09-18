//
//  hourlyMeViewController.h
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fourLines.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#define kFileName @"archive"
#define kDataKey  @"Data"

@interface hourlyMeViewController : UIViewController <MFMailComposeViewControllerDelegate>{

}

@property (nonatomic, retain) IBOutlet UITextField *field1;
@property (nonatomic, retain) IBOutlet UITextField *field2;
@property (nonatomic, retain) IBOutlet UITextField *field3;
@property (nonatomic, retain) IBOutlet UITextField *field4;
@property (nonatomic, retain) IBOutlet UISegmentedControl *happinessIndex;
@property (nonatomic, retain) IBOutlet UISegmentedControl *energyIndex;

- (NSString *)dataFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;
- (IBAction)logFieldsToFile;
- (IBAction)markEvent:(id)sender;
- (IBAction)sendToSelf;

@end
