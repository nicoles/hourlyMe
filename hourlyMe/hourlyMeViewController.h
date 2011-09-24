//
//  hourlyMeViewController.h
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#define kFileName @"archive"
#define kDataKey  @"Data"

@interface hourlyMeViewController : UIViewController <MFMailComposeViewControllerDelegate>{

}

@property (nonatomic, retain) IBOutlet UISlider *happinessIndex;
@property (nonatomic, retain) IBOutlet UILabel *happinessLabel;
@property (nonatomic, retain) IBOutlet UISlider *energyIndex;
@property (nonatomic, retain) IBOutlet UILabel *energyLabel;

- (NSString *)dataFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;
- (IBAction)logFieldsToFile;
- (IBAction)sendToSelf;
- (IBAction)happinessChanged:(id)sender;
- (IBAction)energyChanged:(id)sender;
- (void)scheduleHourlyNotification;

@end
