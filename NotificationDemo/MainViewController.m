//
//  MainViewController.m
//  NotificationDemo
//
//  Created by Jack on 14-7-25.
//  Copyright (c) 2014年 jack. All rights reserved.
//

#import "MainViewController.h"
#define BNRTableBgColorKey @"BNRTableBgColorKey"

@interface MainViewController ()

@end

@implementation MainViewController

NSString * const BNRColorChangedNotification = @"BNRColorChanged";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (![super init])
        return nil;
    employees = [[NSMutableArray alloc] init];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //添加观察者
    [nc addObserver:self
           selector:@selector(handleColorChange:)
               name:BNRColorChangedNotification
             object:nil];
    NSLog(@"Registered with notification center");
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 80, 30);
    button.center = self.view.center;
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button addTarget: self action:@selector(changeBackgroundColor:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}


- (void)changeBackgroundColor:(id)sender
{
    UIColor *color = [UIColor blueColor];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSLog(@"111111111111Sending notification");
    
    //使用NSDictionary 存储要传递的数据
    
    NSDictionary *d = [NSDictionary dictionaryWithObject:color
                                                  forKey:@"color"];
    //发送notification
    [nc postNotificationName:BNRColorChangedNotification
                      object:self
                    userInfo:d];
}

- (void)handleColorChange:(NSNotification *)note
{
    NSLog(@"2222222222222Received notification: %@", note);
    //读取传递过来的userInfo,并从中取数据
    UIColor *color = [[note userInfo] objectForKey:@"color"];
    [self.view setBackgroundColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
