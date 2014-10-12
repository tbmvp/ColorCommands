//
//  JPValuesViewController.m
//  ColorCommands
//
//  Created by Si Te Feng on 10/11/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPValuesViewController.h"
#import "JPCommandsTracker.h"

@interface JPValuesViewController ()

@end

@implementation JPValuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    commandsTracker = [JPCommandsTracker sharedTracker];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 25)];
    titleLabel.text = @"Color Value Sums";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05];
    [self.view addSubview:titleLabel];
    
    UIView* redBack = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 150)];
    redBack.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:redBack];
    
    redValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
    redValue.textAlignment = NSTextAlignmentCenter;
    redValue.textColor = [UIColor whiteColor];
    redValue.font = [UIFont systemFontOfSize:25];
    [redBack addSubview:redValue];
    
    UIView* greenBack = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 150)];
    greenBack.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:greenBack];
    
    greenValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
    greenValue.textColor = [UIColor whiteColor];
    greenValue.textAlignment = NSTextAlignmentCenter;
    greenValue.font = [UIFont systemFontOfSize:25];
    [greenBack addSubview:greenValue];
    
    UIView* blueBack = [[UIView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 150)];
    blueBack.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:blueBack];
    
    blueValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 30)];
    blueValue.textColor = [UIColor whiteColor];
    blueValue.textAlignment = NSTextAlignmentCenter;
    blueValue.font = [UIFont systemFontOfSize:25];
    [blueBack addSubview:blueValue];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInterface) name:kColorCommandsDidUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInterface) name:kNewColorCommandNotification object:nil];
    
    [self updateInterface];
}


- (void)updateInterface
{
    redValue.text = [NSString stringWithFormat:@"Red: %i", commandsTracker.redValueSum];
    greenValue.text = [NSString stringWithFormat:@"Green: %i", commandsTracker.greenValueSum];
    blueValue.text = [NSString stringWithFormat:@"Blue: %i", commandsTracker.blueValueSum];
}


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
