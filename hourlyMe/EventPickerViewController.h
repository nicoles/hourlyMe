//
//  EventPickerViewController.h
//  hourlyMe
//
//  Created by Rachel Binx on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventPickerViewController : UIViewController{
    UIDatePicker *timePicker;
}
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;
- (IBAction)markEvent:(id)sender;

@end
