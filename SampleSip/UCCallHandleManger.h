//
//  FACallHandleManger.h
//  UConnect
//
//  Created by Ramu on 15/05/13.
//  Copyright (c) 2013 Telivo Managed Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UConnect/UConnect.h>
#import <AVFoundation/AVFoundation.h>

#define UConnectLoginSuccess @"UConnectLoginSuccessNotification"
#define UConnectLoginFailed @"UConnectLoginFailedNotification"

@interface UCCallHandleManger : NSObject<UConnectPhoneDelegate>
{
    NSString *callReceievedFromNumber;
    
    BOOL callReceived;
    BOOL callConnected;
    BOOL outGoingCall;
    BOOL callFromChat;
    BOOL isCallStaffCall;
    
    NSString *callType;
    NSString *chatCallerName;
    
}

@property (nonatomic,assign) BOOL isCallStaffCall;
@property (nonatomic,retain) NSString *callReceievedFromNumber;
@property (nonatomic,retain) NSString *callToorFromNumber;
@property (nonatomic,assign) BOOL callReceived;
@property (nonatomic,retain) NSString *chatCallerName;
@property (nonatomic,assign) BOOL callFromChat;

+ (UCCallHandleManger *)shartedinstance ;
- (void)makeCallFromStaffConnect:(NSString *)number staffActivityName:(NSString *)name;
- (void)makeCall:(NSString *)number;
- (void)rejectCall;
- (void)answerCall;
-(void)hangUpCall;
- (void)signOut:(id)isAlert;
- (void)signOut;
- (void)startCallTimer;

- (void)speakerOnAction;
- (void)speakerOffAction;
- (void)muteAction;
- (void)unMuteAction;
- (void)holdAction;
- (void)resumeAction;
- (void)getBackGroundMeesages;

-(void)sendDTMF:(char)digit;

//- (void)dtmfDigitsAction:(int)value;

-(void)showScreen;

- (void) addToDataBase:(NSString *)number callType:(NSString *)type contactName:(NSString *)name;

- (NSString *)phoneNumberFormat:(NSString *)number;

/* BlueTooth Enabled for call
 */

-(void) registerForAudioRoute;

/* Check is BlueTooth Enabled or not
 */

-(NSString *)checkForAudioRoute;
- (void)addBuddyWithUserName:(NSString *)userName;

@end
