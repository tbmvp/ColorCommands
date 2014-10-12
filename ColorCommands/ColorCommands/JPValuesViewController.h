//
//  JPValuesViewController.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPCommandsTracker;
@interface JPValuesViewController : UIViewController
{
    JPCommandsTracker* commandsTracker;
    
    UILabel* redValue;
    UILabel* greenValue;
    UILabel* blueValue;
}




@end
