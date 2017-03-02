//
//  ListViewController.h
//  SampleSip
//
//  Created by Nagendar Reddy on 27/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *listTable;
@property(nonatomic,retain) NSMutableArray *listArr;
@property(nonatomic,retain) NSMutableArray *statusArr;
- (IBAction)cancelAction:(id)sender;

- (void)showNumbersInListNumber:(NSString *)number status:(NSString *)status;
+ (ListViewController *)sharedInstance;

@end
