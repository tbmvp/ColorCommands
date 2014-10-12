//
//  JPCommandsViewController.m
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPCommandsViewController.h"
#import "JPCommandsTracker.h"

static NSString* const defaultCellIdentifier = @"defaultCell";

@interface JPCommandsViewController ()

@end

@implementation JPCommandsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    commandsTracker = [JPCommandsTracker sharedTracker];
    
    //View Initialization
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 69) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.clipsToBounds = YES;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultCellIdentifier];
    [self.view addSubview:self.tableView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInterface) name:kColorCommandsDidUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertNewColorCommand) name:kNewColorCommandNotification object:nil];

    [self updateInterface];
}


- (void)updateInterface
{
    [self.tableView reloadData];
}


- (void)insertNewColorCommand
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
}


#pragma mark - UITable View Data Source and Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commandsTracker.colorCommands count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:defaultCellIdentifier];
    JPColorCommand* colorCommand = [self colorCommandForIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Red: %i  Green: %i  Blue: %i", colorCommand.red, colorCommand.green, colorCommand.blue];
    
    if(colorCommand.selected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Color Commands";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JPColorCommand* colorCommand = [self colorCommandForIndexPath:indexPath];
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger trackerIndex = [self trackerIndexFromCellIndex:indexPath.row];
    [commandsTracker toggleSelectionAtIndex:trackerIndex];
    
    if(colorCommand.selected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}


#pragma mark - Convenience Methods

- (JPColorCommand*)colorCommandForIndexPath: (NSIndexPath*)indexPath
{
    NSUInteger count = [commandsTracker.colorCommands count];
    return commandsTracker.colorCommands[count-1 - indexPath.row];
}

- (NSInteger)trackerIndexFromCellIndex:(NSInteger)index
{
    NSUInteger count = [commandsTracker.colorCommands count];
    return count-1 - index;
}


#pragma mark - View Controller Life Cycle

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
