//
//  PhoneViewController.h
//  SampleSip
//
//  Created by Nagendar Reddy on 20/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UConnect/UConnect.h>
#import "AnswerViewController.h"

@interface PhoneViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logOutAction;
@property (strong, nonatomic) IBOutlet UITextField *PhoneTf;
@property (retain,nonatomic) AnswerViewController *answerView;
@property (strong, nonatomic) IBOutlet UITableView *listTable;

- (IBAction)Calling:(id)sender;
- (IBAction)logOutUser:(id)sender;
+ (PhoneViewController *)sharedInstance;
- (IBAction)subscribeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *statusTxt;
- (IBAction)listAction:(id)sender;

- (void)showAnswerCall:(UIViewController *)rootController;
- (void)removeAnswerCallScreen;
- (void)addTxtToStatusField:(NSString *)txt status:(NSString *)status;

@end
