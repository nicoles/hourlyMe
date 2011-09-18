//
//  fourLines.h
//  hourlyMe
//
//  Created by Nicole Aptekar on 11/09/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fourLines : NSObject <NSCoding, NSCopying>{
    NSString *field1;
    NSString *field2;
    NSString *field3;
    NSString *field4;

}
@property (nonatomic, retain) NSString *field1;
@property (nonatomic, retain) NSString *field2;
@property (nonatomic, retain) NSString *field3;
@property (nonatomic, retain) NSString *field4;

@end
