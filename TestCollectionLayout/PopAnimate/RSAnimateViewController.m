//
//  RSAnimateViewController.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2018/1/10.
//  Copyright © 2018年 XXT. All rights reserved.
//

#import "RSAnimateViewController.h"

#import "RSPlayPauseButton.h"

@interface RSAnimateViewController ()

@end

@implementation RSAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RSPlayPauseButton *button = [[RSPlayPauseButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonClick:(RSPlayPauseButton *)sender {
    sender.selected = !sender.selected;
    [sender setPaused:sender.selected animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
