//
//  TRTableViewController.m
//  TestRestore
//
//  Created by Scarlett Che on 2018/4/27.
//  Copyright © 2018年 Scarlett Che. All rights reserved.
//

#import "TRTableViewController.h"
#import "TRWebViewController.h"

@interface TRTableViewController () <UIDataSourceModelAssociation, UIViewControllerRestoration>
@end

@implementation TRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row + 1).stringValue;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = @"https://www.talicai.com";
    if (indexPath.row % 2 == 0) {
        url = @"https://www.haoguihua.com";
    }

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TRWebViewController *vc = (TRWebViewController *)[sb instantiateViewControllerWithIdentifier:@"TRWebViewController"];
    vc.urlString = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable NSString *) modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view {
    NSString *identifier = [NSString stringWithFormat:@"name=%@",@(idx.row + 1).stringValue];
    return identifier;
}

- (nullable NSIndexPath *) indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    NSInteger index = [identifier substringFromIndex:5].integerValue - 1;
    
    [self.tableView reloadData];
    return [NSIndexPath indexPathForRow:index inSection:0];
}



+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TRTableViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.restorationClass = [TRTableViewController class];
    return vc;
}

@end
