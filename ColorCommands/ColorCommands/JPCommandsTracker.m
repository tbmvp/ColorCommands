//
//  JPCommandsTracker.m
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPCommandsTracker.h"

@implementation JPCommandsTracker

+ (instancetype)sharedTracker
{
    static JPCommandsTracker* _sharedTracker = nil;
    
    @synchronized(self)
    {
        if(!_sharedTracker)
        {
            _sharedTracker = [[JPCommandsTracker alloc] init];
            [_sharedTracker resetTracker];
        }
    }
    
    return _sharedTracker;
}


- (void)resetTracker
{
    self.colorCommands = [[NSMutableArray alloc] init];
    self.redValueSum = 127;
    self.greenValueSum = 127;
    self.blueValueSum = 127;
}


#pragma mark - Public Methods

- (void)resetSelections
{
    //Set all color commands to unselected
    for(int i=0; i<[self.colorCommands count]; i++)
    {
        JPColorCommand* colorCommand = [self.colorCommands objectAtIndex:i];
        
        if(colorCommand.selected)
            colorCommand.selected = NO;
        
        [self.colorCommands replaceObjectAtIndex:i withObject:colorCommand];
    }
    
    //reset the current sums
    self.redValueSum = 0;
    self.greenValueSum = 0;
    self.blueValueSum = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kColorCommandsDidUpdateNotification object:nil];
}


//New command is initially set as selected and is incremented to the current sum
- (void)addNewColorCommand: (JPColorCommand*)command
{
    if(!command)
        return;
    
    //reset the current sum if the new command is absolute
    if(command.type == JPColorCommandTypeAbsolute)
        [self resetSelections];
    
    [self.colorCommands addObject:command];
    
    [self incrementColorCommand:command];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewColorCommandNotification object:nil];
}


//Deselecting/selecting a previous color command
- (void)toggleSelectionAtIndex:(NSInteger)index
{
    if(index < 0)
        return;
    
    JPColorCommand* command = self.colorCommands[index];
    command.selected = !command.selected;
    [self.colorCommands replaceObjectAtIndex:index withObject:command];
    
    if(command.selected) //newly selected
    {
        [self incrementColorCommand:command];
    }
    else {
        [self decrementColorCommand:command];
    }
}


#pragma mark - Convenience Methods

//Increment the current sum with a new color command
- (void)incrementColorCommand: (JPColorCommand*)command
{
    self.redValueSum = (self.redValueSum + command.red + 255) % 255;
    self.greenValueSum = (self.greenValueSum + command.green + 255) % 255;
    self.blueValueSum = (self.blueValueSum + command.blue + 255) % 255;
}

- (void)decrementColorCommand: (JPColorCommand*)command
{
    self.redValueSum = (self.redValueSum - command.red + 255) % 255;
    self.greenValueSum = (self.greenValueSum - command.green + 255) % 255;
    self.blueValueSum = (self.blueValueSum - command.blue + 255) % 255;
}


@end
