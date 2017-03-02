//
//  UCUtil.h
//  UConnectSDK
//
//  Created by Ramu on 07/05/13.
//  Copyright (c) 2013 Telivo Managed Services Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UConnect.h"
typedef enum UConnectPhoneDelegateMethod {
    CALL_RECEIVED=0,
    CALL_CONNECTED,
    CALL_DISCONNECTED,
    CALL_FAILED,
    LOGIN_SUCCESS,
    LOGIN_FAILED,
    SMS_RECEIVED
}UConnectPhoneDelegateMethod;

typedef enum UConnectPresenceDelegateMethod {
    BUDDY_ONLINE=0,
    BUDDY_OFFLINE,
    BUDDY_UNKOWN,
    
}UConnectPresenceDelegateMethod;

@interface UCUtil : NSObject
{
    UConnectCallStatus ucCallStatus;
    UConnectPhoneDelegateMethod method;
   
    NSString *phoneNumber;
    NSString *textMsg;
}
@property UConnectCallStatus ucCallStatus;
@property UConnectPhoneDelegateMethod method;
@property UConnectPresenceDelegateMethod PresenceMethod;
@property (copy) NSString *phoneNumber;
@property (copy) NSString *textMsg;

@end
