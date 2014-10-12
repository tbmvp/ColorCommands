//
//  JPCommandsTracker.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPColorCommand.h"

static NSString* const kColorCommandsDidUpdateNotification = @"update";
static NSString* const kNewColorCommandNotification = @"new";

@interface JPCommandsTracker : NSObject

@property (nonatomic, strong) NSMutableArray* colorCommands;

@property (nonatomic) NSInteger redValueSum;
@property (nonatomic) NSInteger greenValueSum;
@property (nonatomic) NSInteger blueValueSum;


+ (instancetype)sharedTracker;

- (void)resetSelections;
- (void)addNewColorCommand: (JPColorCommand*)command;
- (void)toggleSelectionAtIndex:(NSInteger)index;

@end
