//
//  JPColorCommand.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JPColorCommandType)
{
    JPColorCommandTypeRelative = 0,
    JPColorCommandTypeAbsolute
};

@interface JPColorCommand : NSObject

@property (nonatomic) BOOL selected;
@property (nonatomic) JPColorCommandType type;
@property (nonatomic) NSInteger red;
@property (nonatomic) NSInteger green;
@property (nonatomic) NSInteger blue;

- (instancetype)initWithType:(JPColorCommandType)type red:(NSInteger)red green:(NSInteger)green blue: (NSInteger)blue;

@end
