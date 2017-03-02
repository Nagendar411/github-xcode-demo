//
//  AnswerViewController.h
//  SampleSip
//
//  Created by Nagendar Reddy on 21/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UConnect/UConnect.h>

@interface AnswerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *CallInView;
@property (strong, nonatomic) IBOutlet UIView *CallingView;
- (IBAction)answerAction:(UIButton *)sender;

- (IBAction)speakerAction:(UIButton *)sender;
- (IBAction)hangUpAction:(UIButton *)sender;


+ (AnswerViewController *)sharedIntance;
- (void)showAnswerCall:(UIViewController *)rootController;


@property BOOL incomingCall;
- (void)removeAnswerCallScreen;

@end
