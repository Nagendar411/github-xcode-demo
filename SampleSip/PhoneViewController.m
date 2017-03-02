//
//  PhoneViewController.m
//  SampleSip
//
//  Created by Nagendar Reddy on 20/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import "PhoneViewController.h"
#import "UCCallHandleManger.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ListViewController.h"

static PhoneViewController *phone = nil;
@interface PhoneViewController (){
    NSMutableArray *ArrayList;
     NSMutableArray *statusList;
}

@end

@implementation PhoneViewController
@synthesize answerView;

+ (PhoneViewController *)sharedInstance{
    return phone;
}

- (IBAction)subscribeAction:(id)sender {
    if (![self.PhoneTf.text isEqualToString:@""]) {
        [[UCCallHandleManger shartedinstance] addBuddyWithUserName:self.PhoneTf.text];
      //  [[ListViewController sharedInstance].listArr addObject:self.PhoneTf.text];
    }
    [self.listTable setHidden:NO];
    [self.view endEditing:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ArrayList = [[NSMutableArray alloc]init];
    statusList = [[NSMutableArray alloc]init];
    [self.listTable setHidden:YES];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeybrd)];
     [self.view addGestureRecognizer:tap];
    phone = self;
}
- (void)dismissKeybrd{
    [self.view endEditing:YES];
}

- (void)addTxtToStatusField:(NSString *)txt status:(NSString *)status{
    self.statusTxt.text = txt;
    if (ArrayList.count == 0) {
        [ArrayList addObject:txt];
        [statusList addObject:status];
        
    }else{
        BOOL isTheObjectThere = [ArrayList containsObject:txt];
        if (isTheObjectThere) {
            NSUInteger indexOfTheObject = [ArrayList indexOfObject: txt];
            [ArrayList replaceObjectAtIndex:indexOfTheObject withObject:txt];
            [statusList replaceObjectAtIndex:indexOfTheObject withObject:status];
        }else{
       
        [ArrayList addObject:txt];
        [statusList addObject:status];
       
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.listTable reloadData];
    });
}


- (IBAction)Calling:(id)sender {
    if (![self.PhoneTf.text isEqualToString:@""]) {
        [[UCCallHandleManger shartedinstance] makeCall:self.PhoneTf.text];
        
        [self.view endEditing:YES];
        
    }
}

- (IBAction)logOutUser:(id)sender {
    [[UConnect getSharedInstance] logout];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate *delegte = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegte.window.rootViewController == phone) {
        
        LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        delegte.window.rootViewController = login;
    }else{
         [self dismissViewControllerAnimated:YES completion:nil];
    }
    //delegte.window.rootViewController =
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)listAction:(id)sender {
    ListViewController *list = [self.storyboard instantiateViewControllerWithIdentifier:@"list"];
    list.listArr = ArrayList;
    list.statusArr = statusList;
    [self presentViewController:list animated:YES completion:nil];
}

- (void)showAnswerCall:(UIViewController *)rootController{
    if (answerView == NULL) {
        answerView  = (AnswerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"answer"];

    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:answerView.view];

     answerView.view.frame = [[UIScreen mainScreen] bounds];
    if ([UCCallHandleManger shartedinstance].callReceived) {
        [answerView.CallInView setHidden:YES];
        [answerView.CallingView setHidden:NO];
    }else{
        [answerView.CallInView setHidden:NO];
        [answerView.CallingView setHidden:YES];
    }
    
}
- (void)removeAnswerCallScreen{
    
    [answerView.view removeFromSuperview];
}
#pragma  tableview delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ArrayList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [ArrayList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [statusList objectAtIndex:indexPath.row];
    NSString *statusString =  [statusList objectAtIndex:indexPath.row];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-30, 10, 20, 20)];
    if ([statusString isEqualToString:@"offline"]) {
        imageView.image = [UIImage imageNamed:@"minus_circle.png"];
        [cell.contentView addSubview:imageView];
    }else if ([statusString isEqualToString:@"online"]){
        imageView.image = [UIImage imageNamed:@"tick_circle.png"];
        [cell.contentView addSubview:imageView];
    }
   
    
    
    return cell;
}
@end
