//
//  Demo_TableViewController.m
//  Demo for AD_AutoScrollCell
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Chen Defore. All rights reserved.
//

#import "Demo_TableViewController.h"
#import "AD_AutoScrollCell.h"
#import "model.h"

@interface Demo_TableViewController ()

@end

@implementation Demo_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AD_AutoScrollCell *cell = (AD_AutoScrollCell*)[tableView dequeueReusableCellWithIdentifier:@"testID" forIndexPath:indexPath];
    
    model *mm = [[model alloc] init];
    mm.bannerImg = [UIImage imageNamed:@"01"];
    mm.urlStr = @"https://www.baidu.com/s?wd=wkwebview%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B&rsp=3&f=1&oq=WKWebview%20%E6%8C%89%E9%94%AE%E5%93%8D%E5%BA%94&ie=utf-8&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec&rqlang=cn&rsv_ers=xn1&rs_src=0&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec";
    
    model *aa = [[model alloc] init];
    aa.bannerImg = [UIImage imageNamed:@"02"];
    aa.urlStr = @"https://www.baidu.com/s?wd=wkwebview%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B&rsp=3&f=1&oq=WKWebview%20%E6%8C%89%E9%94%AE%E5%93%8D%E5%BA%94&ie=utf-8&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec&rqlang=cn&rsv_ers=xn1&rs_src=0&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec";
    
    model *bb = [[model alloc] init];
    bb.bannerImg = [UIImage imageNamed:@"03"];
    bb.urlStr = @"https://www.baidu.com/s?wd=wkwebview%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B&rsp=3&f=1&oq=WKWebview%20%E6%8C%89%E9%94%AE%E5%93%8D%E5%BA%94&ie=utf-8&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec&rqlang=cn&rsv_ers=xn1&rs_src=0&rsv_pq=c51f31b50000f9aa&rsv_t=cf48LRT0ae8Qlz8Co5WUA9f8ElUSlOw5Hu%2B80NFcMUIpueWfeSQd%2Btlebec";

    model *cc = [[model alloc] init];
    cc.bannerImg = [UIImage imageNamed:@"04"];
    cc.urlStr = nil;
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:mm,aa,bb,cc,nil];
    
    [cell setParamsWithModel:array
            pageCtrlPosition:LEFT
             timeForEachPage:2
        tapBannerCompleteBlk:^(UIViewController *vc) {
            NSLog(@"execute... block");
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }
     ];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


