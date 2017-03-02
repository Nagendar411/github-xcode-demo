//
//  LoginViewController.h
//  SampleSip
//
//  Created by Nagendar Reddy on 20/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UConnect/UConnect.h>


@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *UserNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)LoginAction:(UIButton *)sender;

@end
