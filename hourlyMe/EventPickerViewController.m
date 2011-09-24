//
//  EventPickerViewController.m
//  hourlyMe
//
//  Created by Rachel Binx on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventPickerViewController.h"

@implementation EventPickerViewController
@synthesize timePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)markEvent:(id)sender{
    NSTimeInterval interval = [[timePicker date] timeIntervalSince1970];
    UIButton *resultButton = (UIButton *)sender;
    NSMutableString *logFile = [[NSMutableString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]];
    if (!logFile) logFile = [[NSMutableString alloc] init];
    NSLog(@"%@",resultButton.currentTitle);
    
    //if the sleep button is pressed, cancel all notifications! for sleeping!
    if (resultButton.tag == 1) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    [logFile appendFormat:@"%@,%f\r\n", resultButton.currentTitle, interval];
    [logFile writeToFile:[NSString stringWithFormat:@"%@/log.txt", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
        [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDate *now = [[NSDate alloc] init];
    [timePicker setDate:now animated:NO];    
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.timePicker = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
