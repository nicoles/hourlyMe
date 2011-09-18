//
//  hourlyMeViewController.m
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "hourlyMeViewController.h"
#import "fourLines.h"

@implementation hourlyMeViewController
@synthesize field1;
@synthesize field2;
@synthesize field3;
@synthesize field4;
@synthesize happinessIndex;
@synthesize energyIndex;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

#pragma mark -
- (void)viewDidLoad{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        field1.text = [array objectAtIndex:0];
        field2.text = [array objectAtIndex:1];
        field3.text = [array objectAtIndex:2];
        field4.text = [array objectAtIndex:3];
        [array release];
        
        NSData *data = [[NSMutableData alloc]
                        initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        fourLines *FourLines = [unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding];
        
        field1.text = FourLines.field1;
        field2.text = FourLines.field2;
        field3.text = FourLines.field3;
        field4.text = FourLines.field4;
        
        [unarchiver release];
        [data release];
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    [super viewDidLoad];
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:field1.text];
    [array addObject:field2.text];
    [array addObject:field3.text];
    [array addObject:field4.text];
    [array writeToFile:[self dataFilePath] atomically:YES];
    [array release];
    
    fourLines *FourLines = [[fourLines alloc] init];
    FourLines.field1 = field1.text;
    FourLines.field2 = field2.text;
    FourLines.field3 = field3.text;
    FourLines.field4 = field4.text;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:FourLines forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    [FourLines release];
    [archiver release];
    [data release];
}

- (IBAction)logFieldsToFile{
    
    
    NSMutableString *logFile = [[NSMutableString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
    if (!logFile) logFile = [[NSMutableString alloc] init];
    [logFile appendFormat:@"%@,%@,%@\r\n", [happinessIndex titleForSegmentAtIndex:happinessIndex.selectedSegmentIndex],[energyIndex titleForSegmentAtIndex:energyIndex.selectedSegmentIndex], [NSDate dateWithTimeIntervalSinceNow:0]];
    [logFile writeToFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

- (IBAction)markEvent:(id)sender{
    UIButton *resultButton = (UIButton *)sender;
    NSMutableString *logFile = [[NSMutableString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
    if (!logFile) logFile = [[NSMutableString alloc] init];
    [logFile appendFormat:@"%@,%@\r\n", resultButton.currentTitle, [NSDate dateWithTimeIntervalSinceNow:0]];
    [logFile writeToFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] atomically:YES encoding:NSUTF8StringEncoding error:nil];

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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    self.field1 = nil;
    self.field2 = nil;
    self.field3 = nil;
    self.field4 = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc{
    [field1 release];
    [field2 release];
    [field3 release];
    [field4 release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
