//
//  AnswerViewController.m
//  SampleSip
//
//  Created by Nagendar Reddy on 21/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import "AnswerViewController.h"
#import "UCCallHandleManger.h"
static AnswerViewController *answer = nil;
@interface AnswerViewController ()

@end

@implementation AnswerViewController


+ (AnswerViewController *)sharedIntance{
    return answer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    answer = self;
     [self.CallingView setHidden:YES];
    
    
}

- (void)showAnswerCall:(UIViewController *)rootController{
    
    if (self.incomingCall) {
        [self.CallInView setHidden:NO];
        [self.CallingView setHidden:YES];
        self.incomingCall = NO;
    }else{
        [self.CallInView setHidden:YES];
        [self.CallingView setHidden:NO];
    }
    
}
- (void)removeAnswerCallScreen{
    if (self.incomingCall) {
        [self.CallInView removeFromSuperview];
        self.incomingCall = NO;
    }else{
        [self.CallingView removeFromSuperview];
    }
}






- (IBAction)answerAction:(UIButton *)sender {
    [[UCCallHandleManger shartedinstance] answerCall];
}

- (IBAction)speakerAction:(UIButton *)sender {
    [[UCCallHandleManger shartedinstance] speakerOnAction];
}

- (IBAction)hangUpAction:(UIButton *)sender {
     [[UCCallHandleManger shartedinstance] hangUpCall];
}
@end
