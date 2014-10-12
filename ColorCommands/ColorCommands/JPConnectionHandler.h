//
//  JPConnectionHandler.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPColorCommand.h"


@protocol JPConnectionHandlerDelegate;
@interface JPConnectionHandler : NSObject <NSStreamDelegate>
{
    NSInputStream* inputStream;
}

@property (nonatomic) BOOL connected;
@property (nonatomic, weak) id<JPConnectionHandlerDelegate> delegate;

+ (instancetype)sharedHandler;
- (void)initNetwork;

@end


@protocol JPConnectionHandlerDelegate <NSObject>

- (void)connectionHandler:(JPConnectionHandler*)handler didReceiveColorCommand:(JPColorCommand*)command;

@end