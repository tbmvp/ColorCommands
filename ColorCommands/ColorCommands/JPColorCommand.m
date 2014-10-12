//
//  JPColorCommand.m
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPColorCommand.h"

@implementation JPColorCommand


- (instancetype)initWithType:(JPColorCommandType)type red:(NSInteger)red green:(NSInteger)green blue: (NSInteger)blue
{
    self = [super init];
    
    if(self)
    {
        self.type = type;
        self.red = red;
        self.green = green;
        self.blue = blue;
        self.selected = YES;
    }
    
    return self;
}


@end
