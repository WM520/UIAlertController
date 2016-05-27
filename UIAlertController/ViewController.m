//
//  ViewController.m
//  UIAlertController
//
//  Created by David on 16/5/26.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"正常" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 210, 100, 100)];
    [btn1 setBackgroundColor:[UIColor orangeColor]];
    [btn1 setTitle:@"登陆" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 320, 100, 100)];
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [btn2 setTitle:@"上拉菜单" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onClick2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)onClick:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你好" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"111111");
    }];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"222222");
    }];
    
    [alertController addAction:cancleAction];
    [alertController addAction:commitAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)onClick1:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"文本对话框" message:@"登陆和密码对话框" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"登陆";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"密码";
        /**
         *  是否隐藏输入
         */
        textField.secureTextEntry = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];
    
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /**
         *  这里面可以做一些与服务器端交互的事情
         */
        NSLog(@"%@\n", alertController.textFields.firstObject.text);
        NSLog(@"%@", alertController.textFields.lastObject.text);
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
    commitAction.enabled = NO;

    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"用户取消了登陆");
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }];
    /**
     *  添加交互按钮
     */
    [alertController addAction:cancleAction];
    [alertController addAction:commitAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)onClick2:(UIButton *)btn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存和删除数据" message:@"删除数据不可恢复" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"保存");
    }];
    
    [alertController addAction:cancleAction];
    [alertController addAction:commitAction];
    [alertController addAction:saveAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  监听textField是否改变
 */
- (void)alertTextFieldDidChange:(NSNotification *)nc
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *userField = alertController.textFields.firstObject;
        UITextField *passWordField = alertController.textFields.lastObject;
        UIAlertAction *commitAction = alertController.actions.lastObject;
        commitAction.enabled = userField.text.length > 2 && passWordField.text.length > 6;
        NSLog(@"%d", commitAction.enabled);
    }
}



@end
