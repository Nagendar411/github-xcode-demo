//
//  LoginViewController.m
//  SampleSip
//
//  Created by Nagendar Reddy on 20/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneViewController.h"
#import "UCCallHandleManger.h"


@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeybrd)];
    [self.view addGestureRecognizer:tap];
}
- (void)dismissKeybrd{
    [self.view endEditing:YES];
}


- (IBAction)LoginAction:(UIButton *)sender {
    if (![self.UserNameTF.text isEqual:@""] && ![self.passwordTF.text isEqual:@""]) {
        
        UConnectStatus status=[[UConnect getSharedInstance] configAPIKey:@"no" withServer:@"192.168.36.67" appName:@"nn"];
        
         if (status == UConnectStatus_OK) {
             UConnectStatus loginSuccess =[[UConnect getSharedInstance] login:self.UserNameTF.text withPassword:self.passwordTF.text];
             if(loginSuccess == UConnectStatus_Wrong_Credentails) {
                 [self showAlertWithTitle:@"Alert" andMsg:@"Invalid Credentials"];
                 return;
             }
             [[UConnect getSharedInstance] configPhoneDelegate:[UCCallHandleManger shartedinstance]];
             [[NSUserDefaults standardUserDefaults] setObject:self.UserNameTF.text forKey:@"username"];
             [[NSUserDefaults standardUserDefaults] setObject:self.passwordTF.text forKey:@"password"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             PhoneViewController *phone = [self.storyboard instantiateViewControllerWithIdentifier:@"phone"];
             [self presentViewController:phone animated:YES completion:nil];
             
             
         }else{
             
         }
        
        
        
    }else{
        [self showAlertWithTitle:@"Alert" andMsg:@"Please enter credentials"];
        
    }
}

- (void)showAlertWithTitle:(NSString *)title andMsg:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
