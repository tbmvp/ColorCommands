//
//  JPCommandsViewController.h
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPConnectionHandler.h"

@class JPCommandsTracker;
@interface JPCommandsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    JPCommandsTracker* commandsTracker;
}


@property (nonatomic, strong) UITableView* tableView;

@end
