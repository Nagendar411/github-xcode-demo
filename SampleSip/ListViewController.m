//
//  ListViewController.m
//  SampleSip
//
//  Created by Nagendar Reddy on 27/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import "ListViewController.h"
static ListViewController *listView = nil;
@interface ListViewController ()
{
    
}

@end

@implementation ListViewController
@synthesize listTable;
@synthesize listArr,statusArr;
+ (ListViewController *)sharedInstance{
    return listView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     listView = self;
    
   // listArr = [[NSMutableArray alloc]init];
  //  statusArr = [[NSMutableArray alloc]init];
   
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showNumbersInListNumber:(NSString *)number status:(NSString *)status{
    if (listArr.count == 0) {
        [listArr addObject:number];
        [statusArr addObject:status];
    }else{
    
        BOOL isTheObjectThere = [listArr containsObject:number];
        if (isTheObjectThere) {
            NSUInteger indexOfTheObject = [listArr indexOfObject: number];
            [listArr replaceObjectAtIndex:indexOfTheObject withObject:number];
            [statusArr replaceObjectAtIndex:indexOfTheObject withObject:status];
        }else{
            
            [listArr addObject:number];
            [statusArr addObject:status];
            
        }

    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.listTable reloadData];
    });

    
}

# pragma mark:Tableview Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [listArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [statusArr objectAtIndex:indexPath.row];
    NSString *statusString =  [statusArr objectAtIndex:indexPath.row];
    
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
