//
//  NetRequestViewController.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2018/1/9.
//  Copyright © 2018年 XXT. All rights reserved.
//

#import "NetRequestViewController.h"

@interface NetRequestViewController ()

@end

@implementation NetRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    learn demo from http://www.jianshu.com/p/6930f335adba
    
    UIButton *Btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn1.frame = CGRectMake(100, 100, 100, 40);
    Btn1.backgroundColor = [UIColor grayColor];
    [Btn1 setTitle:@"noConduct" forState:UIControlStateNormal];
    [Btn1 addTarget:self action:@selector(Btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn1];
    
    
    //2.group
    UIButton *Btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn2.frame = CGRectMake(100, 200, 100, 40);
    Btn2.backgroundColor = [UIColor grayColor];
    [Btn2 setTitle:@"group--" forState:UIControlStateNormal];
    [Btn2 addTarget:self action:@selector(Btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn2];
    
    
    //3.semaphore
    UIButton *Btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn3.frame = CGRectMake(100, 300, 100, 40);
    Btn3.backgroundColor = [UIColor grayColor];
    [Btn3 setTitle:@"semaphore" forState:UIControlStateNormal];
    [Btn3 addTarget:self action:@selector(Btn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn3];
    
    //4.NSOperation
    UIButton *Btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn4.frame = CGRectMake(100, 400, 100, 40);
    Btn4.backgroundColor = [UIColor grayColor];
    [Btn4 setTitle:@"NSOperation" forState:UIControlStateNormal];
    [Btn4 addTarget:self action:@selector(Btn4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn4];
    
    
    //5.semaphore---order
    UIButton *Btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn5.frame = CGRectMake(100, 500, 100, 40);
    Btn5.backgroundColor = [UIColor grayColor];
    [Btn5 setTitle:@"order" forState:UIControlStateNormal];
    [Btn5 addTarget:self action:@selector(Btn5) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn5];
}

- (void)Btn1 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d --- %d", i, i);
        }];
        [task resume];
    }
    NSLog(@"end");
}

- (void)Btn2 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    for (int i=0; i<10; i++) {
        dispatch_group_enter(downloadGroup);
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d --- %d",i, i);
            dispatch_group_leave(downloadGroup);
        }];
        [task resume];
    }
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)Btn3 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    __block NSUInteger count = 0;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d  --  %d",i ,i);
            count ++;
            if (count==10) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
        }];
        [task resume];
    }
    NSLog(@"1111");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"1222222221");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)Btn4 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableArray *operationArr = [NSMutableArray new];
    for (int i=0; i<10; i++) {
        NSBlockOperation *operatin = [NSBlockOperation blockOperationWithBlock:^{
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"%d ---- %d", i, i);
            }];
            [task resume];
            NSLog(@"noRequest - %d", i);
        }];
        [operationArr addObject:operatin];
        NSLog(@"ddddddddd");
        if (i>0) {
            NSBlockOperation *operation1 = operationArr[i-1];
            NSBlockOperation *operation2 = operationArr[i];
            [operation2 addDependency:operation1];
            NSLog(@"eeeeeeee");
        }
    }
    NSLog(@"bbbbbbb");
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperations:operationArr waitUntilFinished:NO];
    NSLog(@"ccccccccc");
}

- (void)Btn5 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%d ---- %d", i, i);
            dispatch_semaphore_signal(sem);
        }];
        [task resume];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"aaaa %d", i);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
