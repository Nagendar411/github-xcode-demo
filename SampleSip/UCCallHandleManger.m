//
//  FACallHandleManger.m
//  UConnect
//
//  Created by Ramu on 15/05/13.
//  Copyright (c) 2013 Telivo Managed Services. All rights reserved.
//

#import "UCCallHandleManger.h"
#import "PhoneViewController.h"
#import "AnswerViewController.h"
#import "ListViewController.h"
static UCCallHandleManger *callhadleManger = nil;
@implementation UCCallHandleManger

@synthesize callReceievedFromNumber,callReceived,callToorFromNumber;
@synthesize isCallStaffCall,chatCallerName,callFromChat;

+ (UCCallHandleManger *)shartedinstance {
    if(callhadleManger==nil){
        callhadleManger = [[UCCallHandleManger alloc] init];
    }
    return callhadleManger;
}




#pragma mark - UConnect SDK Delegate Methods

- (void) loginSuccess : (UConnectCallStatus) reason {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] postNotificationName:UConnectLoginSuccess object:nil];
    
    NSLog(@"phone number is %@",[[UConnect getSharedInstance] myPhoneNumber]);
}

- (void) loginFailed : (UConnectCallStatus) reason {
    
    NSLog(@"%s %u",__func__ ,reason);
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSignedIn"] isEqualToString:@"NO"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UConnectLoginFailed object:nil];
    }
}


- (void) callReceived : (NSString *) fromPhoneNumber {
    NSLog(@"%s",__func__);
    /*Remove the keyboard when on icoming call*/
   // [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    callReceived =YES;
    callConnected = NO;
    outGoingCall = NO;
    [AnswerViewController sharedIntance].incomingCall = YES;
    // Show the AnswerCallView.
    NSLog(@"call receviedFrom:%@",fromPhoneNumber);
    [self performSelectorOnMainThread:@selector(showScreen) withObject:nil waitUntilDone:NO];
    self.callReceievedFromNumber = fromPhoneNumber;
    self.callToorFromNumber = fromPhoneNumber;
}

- (void) callConnected : (NSString *) fromPhoneNumber {
    NSLog(@"%s",__func__);
    callConnected=YES;
    callReceived=NO;
    [self performSelectorOnMainThread:@selector(startCallTimer) withObject:nil waitUntilDone:NO];
}

- (void) callDisconnected : (UConnectCallStatus) reason {
    if(isCallStaffCall){
        isCallStaffCall = NO;
    }
    
    NSLog(@"%s and the reason %u",__func__,reason);
    [self performSelectorOnMainThread:@selector(removeScreen) withObject:nil waitUntilDone:NO];
  //  [self performSelectorOnMainThread:@selector(removeStaffConnectScreen) withObject:nil waitUntilDone:NO];
    if(callConnected){
        [self performSelectorOnMainThread:@selector(invalidateCallTimer) withObject:nil waitUntilDone:NO];
    }
    if(callConnected&&!outGoingCall){
        callType = @"incomingCall";
      //  NSString *contactName = [[UCAddressBookManager sharedInstance] contactName:callReceievedFromNumber];
        //NSString *contactName=[[UCDataManager sharedInstance] deviceContactName:callReceievedFromNumber];
     //   [self addToDataBase:callReceievedFromNumber callType:callType contactName:contactName];
        
    }else if (callReceived&&!callConnected){
        callType = @"missedCall";
      //  NSString *contactName=[[UCDataManager sharedInstance] deviceContactName:callReceievedFromNumber];
      //  [self addToDataBase:callReceievedFromNumber callType:callType contactName:contactName];
        
    }
    callConnected=NO;
    callReceived=NO;//ashok
    if(callFromChat)
        callFromChat=NO;
  //  [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_History_USER_LIST_RELOAD object:nil];
}

- (void) callFailed : (NSString *) reason {
    NSLog(@"%s",__func__);
}
- (void) userPresence : (NSString*) user andStatus:(NSString *)status{
    
    [[PhoneViewController sharedInstance] addTxtToStatusField:user status:status];
    if ([ ListViewController sharedInstance].view) {
       [[ListViewController sharedInstance] showNumbersInListNumber:user status:status]; 
    }
    
    
}
- (void)addBuddyWithUserName:(NSString *)userName{
    
    [[UConnect getSharedInstance] addBuddy:userName];
}
- (void)startCallTimer{
   
       // [[UCViewController_iPhone sharedInstance].answerCallView startTimer];
        
       // [[UCViewController_iPhone sharedInstance].staffConnectAnswer startTimer];
    
    
    
    
}

- (void)invalidateCallTimer{
   
       // [[UCViewController_iPhone sharedInstance].answerCallView invalidateTimer];
        //[[UCViewController_iPhone sharedInstance].staffConnectAnswer invalidateTimer];
        
    
}

- (void)removeScreen{
    
        [[PhoneViewController sharedInstance] removeAnswerCallScreen];
    
    
}

-(void)removeStaffConnectScreen{
//    if (IS_IPAD) {
//        [[UCViewController sharedInstance] removeStaffConnectAnswerScreen];
//    }
//    else{
//        [[UCViewController_iPhone sharedInstance] removeStaffConnectAnswerScreen];
//    }
    
}
-(void)showScreen{
//    if (IS_IPAD) {
//        [[UCViewController sharedInstance] showAnswerCallView:[UIApplication sharedApplication].keyWindow.rootViewController];
//    }
//    else{
       [[PhoneViewController sharedInstance] showAnswerCall:[UIApplication sharedApplication].keyWindow.rootViewController];
//    }
    
}

-(void)showScreenStaff{
//    if (IS_IPAD) {
//        [[UCViewController sharedInstance] showAnswerCallForStaffConnect:[UIApplication sharedApplication].keyWindow.rootViewController];
//    }
//    else{
//        [[UCViewController_iPhone sharedInstance] showAnswerCallForStaffConnect:[UIApplication sharedApplication].keyWindow.rootViewController];
//    }
    
}


- (void)makeCall:(NSString *)number{
    /*Remove the keyboard when on icoming call*/
  //  [[UIApplication sharedApplication].keyWindow endEditing:YES];
    /*CHANGES*/
    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9+]" options:0 error:NULL];
//    NSString *OriginalNumber = [regex stringByReplacingMatchesInString:number options:0 range:NSMakeRange(0, [number length]) withTemplate:@""];
//    
//    NSString *dialledNumber=OriginalNumber;
 //   NSString *myNumber=[[UCDataManager sharedInstance] number];
  //  myNumber=[myNumber substringWithRange:NSMakeRange([myNumber length]-10, 10)];
//    if([dialledNumber length]>9)
//        dialledNumber=[dialledNumber substringWithRange:NSMakeRange([dialledNumber length]-10, 10)];
    
//    if([dialledNumber isEqualToString:myNumber]){
//        [[UCAlertViewManager sharedInstance] showAlertWithTitle:NSLocalizedString(@"Call Failed",nil) message:NSLocalizedString(@"you are calling to your own Number",nil) identifier:1 overwrite:YES buttonTitles:@"OK",nil];
//        return;
//    }
//    
//    if(isCallStaffCall){
//        [[UCAlertViewManager sharedInstance] showAlertWithTitle:NSLocalizedString(@"Call Failed",nil) message:NSLocalizedString(@"Already in Call",nil) identifier:1 overwrite:YES buttonTitles:@"OK",nil];
//        return;
//    }
//    
//    if(![[UCReachability sharedInstance] reachability]){
//        [[UCAlertViewManager sharedInstance] showAlertWithTitle:NSLocalizedString(@"Network Issue",nil) message:NSLocalizedString(@"No Internet Connection to Make Calls.",nil) identifier:1 overwrite:YES buttonTitles:@"OK",nil];
//        return;
//    }
//    if(OriginalNumber.length<=0) {
//        return;
//    }
    
   // self.callToorFromNumber=OriginalNumber;
    outGoingCall = YES;
    UConnectCallStatus callStatus = [[UConnect getSharedInstance] makeCall:number];
    NSLog(@"status is %u",callStatus);
    if(callStatus == UConnectCallStatus_Error) {
        NSLog(@"call not allowed:");
    }else if(callStatus == UConnectCallStatus_Number_Busy) {
        
        NSLog(@"number is busy:");
    }else if(callStatus == UConnectCallStatus_Bad_Number) {
        
        NSLog(@"number is Bad_Number:");
    }
    [self performSelectorOnMainThread:@selector(showScreen) withObject:nil waitUntilDone:NO];
//    if (IS_IPAD) {
//        [UCViewController sharedInstance].answerCallView.displayName.text = OriginalNumber;
//    }
//    else{
//        [UCViewController_iPhone sharedInstance].answerCallView.displayName.text = OriginalNumber;
//    }
    
    NSLog(@"after answercall screen:");
    if(!callFromChat) {
        callType = @"outGoingCall";
     //   NSString *contactName=[[UCDataManager sharedInstance] deviceContactName:OriginalNumber];
      //  [self addToDataBase:OriginalNumber callType:callType contactName:contactName];
    }
}



- (void)makeCallFromStaffConnect:(NSString *)number staffActivityName:(NSString *)name{
    
   
    isCallStaffCall = YES;
//    if(![[UCReachability sharedInstance] reachability]){
//        [[UCAlertViewManager sharedInstance] showAlertWithTitle:NSLocalizedString(@"Network Issue",nil) message:NSLocalizedString(@"No Internet Connection to Make Calls.",nil) identifier:1 overwrite:YES buttonTitles:@"OK",nil];
//        return;
//    }
//    self.callToorFromNumber=number;
//    outGoingCall = YES;
//    UConnectCallStatus callStatus = [[UConnect getSharedInstance] makeCall:number];
//    NSLog(@"status is %u",callStatus);
//    if(callStatus == UConnectCallStatus_Error) {
//        NSLog(@"call not allowed:");
//    }else if(callStatus == UConnectCallStatus_Number_Busy) {
//        
//        NSLog(@"number is busy:");
//    }else if(callStatus == UConnectCallStatus_Bad_Number) {
//        
//        NSLog(@"number is Bad_Number:");
//    }
//    [self performSelectorOnMainThread:@selector(showScreenStaff) withObject:nil waitUntilDone:YES];
//    
//    
//    if(IS_IPAD){
//        [UCViewController sharedInstance].staffConnectAnswer.calledNumber.text=  name;
//    }else{
//        [UCViewController_iPhone sharedInstance].staffConnectAnswer.calledNumber.text=  name;
//    }
//    
//    
    
    /*We dont want the Call the Staff numbers to add into database so we are just restricting these to add into database...*/
    
    //    callType = @"outGoingCall";
    //    NSString *contactName = [[UCAddressBookManager sharedInstance] contactName:number];
    //    [self addToDataBase:number callType:callType contactName:contactName];
}


- (void)getBackGroundMeesages {
    if([[UConnect getSharedInstance] respondsToSelector:@selector(getBackGroundMessages)]) {
        NSMutableArray *messagesArray=[[NSMutableArray alloc] init];
        messagesArray = [[UConnect getSharedInstance] getBackGroundMessages];
    }
}


- (void)rejectCall{
    NSLog(@"%s",__func__);
    [[UConnect getSharedInstance] rejectCall];
}

-(void)hangUpCall{
    if(isCallStaffCall){
        isCallStaffCall = NO;
    }
    [[UConnect getSharedInstance] hangupCall];
}

- (void)answerCall{
    NSLog(@"%s",__func__);
    [[UConnect getSharedInstance] answerCall:callReceievedFromNumber];
}
- (void)signOut{
   [[UConnect getSharedInstance] logout];
}

- (void)signOut:(id)isAlert {
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isSignedIn"];
//    if (IS_IPAD) {
//        
//        //Check whether contact popover in history is presented or not if it is presented then dismiss it
//        
//        [[UCViewController sharedInstance]dismissPopOver];
//        if([[UCTopBar instance].conatctPopover isPopoverVisible]){
//            [[UCTopBar instance].conatctPopover dismissPopoverAnimated:YES];
//            
//        }
//        
//        if(IOSVersion>=9.0) {
//            if ([[MTContactsUIManager sharedInstance].conatctPopover isPopoverVisible]) {
//                
//                [[MTContactsUIManager sharedInstance].conatctPopover dismissPopoverAnimated:YES];
//            }
//        } else {
//            if ([[UCAddressBookUIManager sharedInstance].conatctPopover isPopoverVisible]) {
//                
//                [[UCAddressBookUIManager sharedInstance].conatctPopover dismissPopoverAnimated:YES];
//            }
//        }
//        
//        //Check Whether Ucbuddy list view in chat list view controller is presented or not before signout,if it is visible then dismiss that view controller
//        if([UCChatListViewController currentInstance]!=nil)
//        {
//            if([UCChatListViewController currentInstance].addBuddyListView!=nil){
//                
//                if([[UCChatListViewController currentInstance].presentedViewController isKindOfClass:[UCAddBuddy class]])
//                    
//                    [[UCChatListViewController currentInstance] dismissBuddyView];
//                
//            }
//            
//        }
//        //Check Whether uiaction sheet in chat list view controller is presented or not before signout,if it is visible then dismiss it
//        if([UCChatListViewController currentInstance]!=nil){
//            
//            if([UCChatListViewController currentInstance].addUserSheet!=nil){
//                
//                
//                if([[UCChatListViewController currentInstance].addUserSheet isVisible ])
//                {
//                    [[UCChatListViewController currentInstance].addUserSheet dismissWithClickedButtonIndex:0 animated:NO];
//                }
//                
//                
//            }
//            
//        }
//        
//        [[UCViewController sharedInstance] removeSpltViewScreens];
//    }
//    else{
//        
//        [[UCTabViewController shareInstance].tabBarController setSelectedIndex:0];
//    }
//    
//    
//    if (isAlert != nil) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Disconnected" message:NSLocalizedString(@"Somebody logged in with same user name on other device", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//        [alertView show];
//        [alertView release];
//        
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password_prefrences"];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"username_prefrences"] forKey:@"previousLoggedIn_User"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    
//#if !TARGET_IPHONE_SIMULATOR
//    [[UCPushNotification sharedInstance] registerforAPNS:NO];
//#endif
//    [[UConnect getSharedInstance] logout];
//    [[UCXMPPManager sharedInstance] disconnect];
}

- (void)speakerOnAction {
    
    [[UConnect getSharedInstance] speakerOn];
}

- (void)speakerOffAction {
    
    [[UConnect getSharedInstance] speakerOff];
}
- (void)muteAction {
    [[UConnect getSharedInstance] muteCall];
}
- (void)unMuteAction {
    [[UConnect getSharedInstance] unMuteCall];
}
- (void)holdAction {
    [[UConnect getSharedInstance] holdCall];
}
- (void)resumeAction {
    [[UConnect getSharedInstance] resumeCall];
}

-(void)sendDTMF:(char)digit{
    [[UConnect getSharedInstance] sendDTMFDigit:digit];
}


//- (NSString *)phoneNumberFormat:(NSString *)number{
//    RMPhoneFormat *formatNumber = [[RMPhoneFormat alloc] init];
//    //    PhoneNumberFormatter *formatNumber = [[PhoneNumberFormatter alloc] init];
//    //    NSString *myLocale=[[NSLocale currentLocale] localeIdentifier];
//    //    return [formatNumber format:number withLocale:myLocale];
//    NSString *formatedNumber=[formatNumber format:number];
//    [formatNumber release];
//    return formatedNumber;
//}




#pragma mark CallRecords TO Database .
- (void) addToDataBase:(NSString *)number callType:(NSString *)type contactName:(NSString *)name{
    
//    NSString *loginEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"username_prefrences"];
//    NSDate * now = [NSDate date];
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss "];
//    NSString *newDateString = [outputFormatter stringFromDate:now];
//    NSLog(@"newDateString %@", newDateString);
//    [outputFormatter release];
//    
//    NSDictionary *callDic = [[NSDictionary alloc] initWithObjectsAndKeys:number,@"phoneNumber",callType,@"callTypes",name,@"name",loginEmail,@"emailid",newDateString,@"myDate",nil];
//    if(callDic){
//        NSLog(@"callDic is %@",callDic);
//        UCSQliteConnector *sqliteConnector =[[UCSQliteConnector alloc] init];
//        [sqliteConnector insertData:callDic intoTable:HISTORY_TABLE_NAME];
//        [sqliteConnector release];
//    }
//    [callDic release];
}


#pragma mark Bluetooth implementation .

#pragma mark Bluetooth implementation .
-(void) registerForAudioRoute{
    /* For Bluetooth implementation
     */
    /*Registering for CallBack Method of AudioSession...*/
    // Registers this class as the delegate of the audio session.
    // [[AVAudioSession sharedInstance] setDelegate: self];
    
    // Use this code instead to allow the app sound to continue to play when the screen is locked.
    //[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    AVAudioSessionCategoryOptions AVAudioSessionCategoryOptionsNone = 0;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionsNone error:nil];
    
    // Registers the audio route change listener callback function
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(routeChange:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:nil];
   
}

-(NSString *)checkForAudioRoute{
    // check the audio route
    UInt32 size = sizeof(CFStringRef);
    CFStringRef route;
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &size, &route);
    NSLog(@"route = %@", route);
    
    NSString *audioRouteType = (__bridge NSString *)route;
    
    return audioRouteType;
}


- (void)routeChange:(NSNotification*)notification {
    
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonUnknown:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonUnknown");
            break;
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // a headset was added or removed
        {
            NSLog(@"Headset plugged in");
            NSString *headSetStatus = @"PluggedIn";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HeadSetStatus" object:headSetStatus];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            // a headset was added or removed
        {
            NSLog(@"Headset Unplugged");
            NSString *headSetStatus = @"Unplugged";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HeadSetStatus" object:headSetStatus];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonCategoryChange");//AVAudioSessionRouteChangeReasonCategoryChange
            break;
            
        case AVAudioSessionRouteChangeReasonOverride:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonOverride");
            break;
            
        case AVAudioSessionRouteChangeReasonWakeFromSleep:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonWakeFromSleep");
            break;
            
        case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory:
            NSLog(@"routeChangeReason : AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory");
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HeadSetStatus" object:nil];
}


@end
