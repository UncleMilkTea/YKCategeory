//
//  ViewController.m
//  YKCategeory
//
//  Created by 侯玉昆 on 2019/8/29.
//  Copyright © 2019 houyukun. All rights reserved.
//

#import "ViewController.h"
#import "YKHeader.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tip;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self showLoading];
    [self.tip startLoading];
  
}

- (IBAction)button:(id)sender {
   
//    [self yk_presentAltertConfigure:^(YKAlterConfig * _Nonnull config) {
//        config.title = @"标题";
//        config.message = @"内容";
//        config.single = YES;
//        config.addInput = YES;
//        config.textFieldBlock = ^(UITextField * _Nonnull textField) {
//            NSLog(@"输入");
//        };
//    } sure:^{
//        [self.tip stopLoading];
//        NSLog(@"确定");
//    } cancle:^{
//        NSLog(@"取消");
//    }];
    
    [self.tip yk_showAltertConfigure:^(YKAlterConfig * _Nonnull config) {
        config.title = @"标题";
        config.message = @"内容";
//        config.single = YES;
        config.addInput = YES;
    } sure:^(NSString * _Nonnull text) {
     
    } cancle:^{
        
    }];
    
}

@end
