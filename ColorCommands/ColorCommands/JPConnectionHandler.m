//
//  JPConnectionHandler.m
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPConnectionHandler.h"

@implementation JPConnectionHandler


+ (instancetype)sharedHandler
{
    static JPConnectionHandler* _sharedHandler = nil;
    
    @synchronized(self)
    {
        if(!_sharedHandler)
        {
            _sharedHandler = [[JPConnectionHandler alloc] init];
            _sharedHandler.connected = NO;
        }
    }
    
    return _sharedHandler;
}


- (void)initNetwork
{
    NSInputStream* input = nil;
    NSOutputStream* output = nil;
    [NSStream getStreamsToHostWithName:@"localhost" port:1234 inputStream:&input outputStream:&output];
    
    inputStream = input;
    inputStream.delegate = self;
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
}


- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    switch (eventCode)
    {
        case NSStreamEventOpenCompleted:
            NSLog(@"Connection Opened");
            break;
        case NSStreamEventHasBytesAvailable:
        {
            if( aStream != inputStream) {
                NSLog(@"not inputs stream");
                return;
            }
            
            uint8_t buffer[1024];
            int len;
            
            while([inputStream hasBytesAvailable])
            {
                len = [inputStream read:buffer maxLength: sizeof(buffer)];
                
                JPColorCommandType commandType;
                NSInteger redVal;
                NSInteger greenVal;
                NSInteger blueVal;
                
                uint8_t command = buffer[0];
                //NSLog(@"command:%i", command);
                
                if(command == 1)
                {
                    commandType = JPColorCommandTypeRelative;
                    
                    uint16_t unsignedRed = ((uint16_t)buffer[1] << 8 ) + (uint16_t)buffer[2];
                    int8_t red = (int8_t)unsignedRed ;
                    redVal = (NSInteger)red;
                    
                    uint16_t unsignedGreen = ((uint16_t)buffer[3] << 8 ) + (uint16_t)buffer[4];
                    int8_t green = (int8_t)unsignedGreen;
                    greenVal = (NSInteger)green;
                    
                    uint16_t unsignedBlue = ((uint16_t)buffer[5] << 8 ) + (uint16_t)buffer[6];
                    int8_t blue = (int8_t)unsignedBlue;
                    blueVal = (NSInteger)blue;
                    
                }
                else
                {
                    commandType = JPColorCommandTypeAbsolute;
                    
                    uint8_t red = buffer[1];
                    redVal = (NSInteger)red;
                    
                    uint8_t green = buffer[2];
                    greenVal = (NSInteger)green;
                    
                    uint8_t blue = buffer[3];
                    blueVal = (NSInteger)blue;
                }
                
                //NSLog(@"r:%i g:%i b:%i", redVal, greenVal, blueVal);
                
                if([self.delegate respondsToSelector:@selector(connectionHandler:didReceiveColorCommand:)])
                {
                    JPColorCommand* colorCommand = [[JPColorCommand alloc] initWithType:commandType red:redVal green:greenVal blue:blueVal];
                    
                    [self.delegate connectionHandler:self didReceiveColorCommand:colorCommand];
                }
            }
        }
            break;
        case NSStreamEventHasSpaceAvailable:
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"Stream Error");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"Stream Ended");
            break;
        default:
            break;
            
    }
    
}

@end
