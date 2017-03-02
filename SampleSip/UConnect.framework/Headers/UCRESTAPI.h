//
//  RESTAPI.h
//  UConnectSDK
//
//  Created by Ramu on 09/04/13.
//  Copyright (c) 2013 Telivo Managed Services Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCRESTAPI : NSObject

    +getSharedInstance;
    /**
     Request:
     
     URI: uconnect/user/plan
     Method: POST
     Parameters: user=ramu&password=ramuk
     
     Response:
     Type : JSON
     E.g. Response : {"status":"SUCCESS","plan":"T","username":"ramu","name":"Ramu Test","number":"14242504067"}.

     */

    -(NSDictionary*) userPlan : (NSString *) userName withPassword:(NSString *) password ;

    /**
     Request:
     URI: uconnect/api/check
     METHOD: GET
     Parameters: apiKey=""
     
     Response:
     Type: JSON
     E.g. Response: {"sipServer":"","imServer":"","propertyID":"","plan-code":""}.
     */
    - (NSDictionary*) apiDetails : (NSString *) apiKey andServer :(NSString *) apiServer appName:(NSString *)appNameIs;

@end
