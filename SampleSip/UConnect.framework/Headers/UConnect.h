//
//  UConnect.h
//
//  Created by Ramulu Kambalapuram <ramu@telivo.net> on 4/16/12.
//  Copyright (c) 2012 Telivo Managed Services Pvt Ltd. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum UConnectStatus {
    UConnectStatus_OK=0,                  /* Everything is Okay */
    UConnectStatus_Delegate_Not_Found,    /* set Delegate by calling this method configDelegate method */
    UConnectStatus_Key_Not_Configured,    /* to set API Key by calling configAPIKey method */
    UConnectStatus_Wrong_Key,             /* APIKey is invalid */
    UConnectStatus_Wrong_Credentails,
    UConnectStatus_User_Not_Logged_In     /* User not logged-in, call login method */
} UConnectStatus;

typedef enum UConnectCallStatus {
    UConnectCallStatus_OK=0,
    UConnectCallStatus_Connecting,
    UConnectCallStatus_Connected,
    UConnectCallStatus_Bad_Number,
    UConnectCallStatus_No_Balance,
    UConnectCallStatus_Number_Busy,
    UConnectCallStatus_Unauthorized,
    UConnectCallStatus_Normal_Clearing,
    UConnectCallStatus_Error
} UConnectCallStatus;

/**
 Callbacks that let your app know when call received, SMS Received, Call Failure and Registration failure reasons.
 */

@protocol UConnectPhoneDelegate

- (void) callReceived : (NSString *) fromPhoneNumber;
- (void) callConnected : (NSString *) fromPhoneNumber;
- (void) callDisconnected : (UConnectCallStatus) reason;
- (void) callFailed : (NSString *) reason;

- (void) loginSuccess : (UConnectCallStatus) reason;
- (void) loginFailed : (UConnectCallStatus) reason;

- (void) userPresence : (NSString*) user andStatus:(NSString *)status;


@end

/**
 Callbacks that let your app know when SMS Received and SMS Failed.
 */

@protocol UConnectSMSDelegate

- (void) textMessageReceived : (NSString *) fromPhoneNumber withMessage:(NSString *) message;
- (void) textMessageFailed : (NSString *) reason;

@end

@interface UConnect : NSObject
{
    
}

/**
 * There can be only one! The API strictly enforces the existance of a single instance. Don't call
 * alloc init on this class, bad things will happen.
 */
+ (UConnect*) getSharedInstance;
/**
 <b>Required</b>. Set up the delegate so that you can recieve notifications about Incoming Calls, SMSes. 
 The delegate is not retained (behaves the same as a nonatomic,assign property).
 */
- (UConnectStatus)configPhoneDelegate:(id<UConnectPhoneDelegate, NSObject>) delegate;//required
- (UConnectStatus)configSMSDelegate:(id<UConnectSMSDelegate, NSObject>) delegate;//required
/**
 <b>Important: This method should be called first before any of the other methods. Required</b>. 
 */
- (UConnectStatus) configAPIKey :(NSString *) apiKey withServer:(NSString *)apiServer appName:(NSString *)appname;

/**
 Login with your user and password
 */
- (UConnectStatus) login :(NSString *) user withPassword:(NSString *) password;

/**
 After Successful login, call this method to know your Phone Number.  On this Phone Number you will receive Incoming Calls.  When you make calls this Phone Number will be shown to others.
 */
- (NSString *) myPhoneNumber;

/**
 After Successful login, call this method to know your display name.
 */
- (NSString *) myDisplayName;

/**
 This Method give us missed calls numbers(key is missedcallslist) and Incoming Caller number(key is callnumber) when we Receive Calls in Background....
 */
- (NSMutableDictionary *)backGroundCallNumber;

/**
 This Method give us background messages when we Receive messages notifications in Background....
 */
- (NSMutableArray *)getBackGroundMessages;

/**
 To logout current user, call this method.  You can login back with same or different user name and password with login method.
 */
- (UConnectStatus) logout;

// To register your previous user call this method.
- (void)registerSip;

// To unregister the user call this method.
- (void)unRegister;

/**
 To Dial out, call this method with Phone Number to be dialed out.
 */
- (UConnectCallStatus) makeCall:(NSString *) phoneNumber;

/**
 To Answer a call which is received from someone, call this method.  Phone Number will be known to you on callReceived method.
 */
- (UConnectCallStatus) answerCall:(NSString *) phoneNumber;

/**
 To Reject a call, call this method.
 */
- (UConnectCallStatus) rejectCall;

/**
 To Disconnect call, call this method.
 */
- (UConnectCallStatus) hangupCall;

/**
 To Mute Call
 */
- (UConnectCallStatus) muteCall ;

/**
 To UnMute Call
 */
- (UConnectCallStatus) unMuteCall ;

/**
 To Hold Call
 */
- (UConnectCallStatus) holdCall;
/**
 Resume call
 */
- (UConnectCallStatus) resumeCall;

/**
 To set Speaker On
 */
- (UConnectCallStatus) speakerOn;

/**
 To set Speaker Off
 */
- (UConnectCallStatus) speakerOff;



/**
 To send SMS Message to phone number call this method with text message to be sent
 */
- (UConnectCallStatus) sendTextMessage: (NSString *) toPhoneNumber withMessage:(NSString*)message;

/**
 After call gets answered you can call this method to send DTMF Digits.  This method is more usefull at the time of joining meeting which requires PIN to be entered.
 */
- (UConnectCallStatus) sendDTMFDigit : (char ) digit;

/** To Block the incoming call, call this method.
 */
- (void)blockInComingCall:(BOOL)value;

- (void)addBuddy:(NSString *)buddy;
- (NSString *)userStatus;

@end

