//
//  AppDelegate.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPConnectionHandler.h"


@class JPConnectionHandler, JPCommandsTracker;
@interface AppDelegate : UIResponder <UIApplicationDelegate, JPConnectionHandlerDelegate>
{
    JPConnectionHandler* connectionHandler;
    JPCommandsTracker* commandsTracker;
}

@property (strong, nonatomic) UIWindow *window;


@end

