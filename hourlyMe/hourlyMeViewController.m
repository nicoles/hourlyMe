//
//  hourlyMeViewController.m
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "hourlyMeViewController.h"

@implementation hourlyMeViewController
@synthesize happinessIndex;
@synthesize energyIndex;
@synthesize happinessLabel;
@synthesize energyLabel;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

#pragma mark -
- (void)viewDidLoad{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        
        NSData *data = [[NSMutableData alloc]
                        initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        [unarchiver finishDecoding];
        
        [unarchiver release];
        [data release];
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    [super viewDidLoad];
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    [archiver release];
    [data release];
}

#pragma mark - user interaction
- (IBAction)happinessChanged:(id)sender{
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value + 0.5f);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d", progressAsInt];
    happinessLabel.text = newText;
    [newText release];
}
- (IBAction)energyChanged:(id)sender{
    UISlider *slider = (UISlider *)sender;
    int progressAsInt = (int)(slider.value + 0.5f);
    NSString *newText = [[NSString alloc] initWithFormat:@"%d", progressAsInt];
    energyLabel.text = newText;
    [newText release];
}

- (IBAction)logFieldsToFile{
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSMutableString *logFile = [[NSMutableString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
    if (!logFile) logFile = [[NSMutableString alloc] init];
    [logFile appendFormat:@"%@,%@,%f\r\n", happinessLabel.text,energyLabel.text,interval];//[happinessIndex titleForSegmentAtIndex:happinessIndex.selectedSegmentIndex],[energyIndex titleForSegmentAtIndex:energyIndex.selectedSegmentIndex], interval];
    [logFile writeToFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"%@", notifications);
    if(notifications.count == 0)
    {
        [self scheduleHourlyNotification];
    }
}

- (IBAction)sendToSelf{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"HourlyMe Output"];
    [controller setMessageBody:[[NSMutableString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]] isHTML:NO];
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - notification service

- (void)scheduleHourlyNotification
{
    NSLog(@"Schedule!", nil);
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *currentMoment = [[[NSDate alloc] init] autorelease];
    NSDateComponents *dateComponents = [[[NSDateComponents alloc] init] autorelease];
    [dateComponents setHour:1];
    NSLog(@"%@", currentMoment);
    NSLog(@"%i", dateComponents.minute);
    NSDate *futureMoment = [calendar dateByAddingComponents:dateComponents toDate:currentMoment options:0];
    NSLog(@"%@", futureMoment);
    UILocalNotification *hourlyNotification = [[UILocalNotification alloc] init];
    if (hourlyNotification == nil)
        return;
    hourlyNotification.fireDate = futureMoment;
    hourlyNotification.timeZone = [NSTimeZone defaultTimeZone];
    hourlyNotification.repeatInterval = NSHourCalendarUnit;
    
    
    hourlyNotification.alertBody = @"It's been an hour!";
    hourlyNotification.alertAction = NSLocalizedString(@"View Details", nil);
    
    hourlyNotification.soundName = UILocalNotificationDefaultSoundName;
    hourlyNotification.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:hourlyNotification];

    NSLog(@"%@", hourlyNotification);
    [hourlyNotification release];
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc{
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
