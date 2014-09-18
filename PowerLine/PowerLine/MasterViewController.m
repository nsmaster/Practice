//
//  MasterViewController.m
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "MasterViewController.h"
#import <MBProgressHUD.h>

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *users;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Загрузка";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.users = nil;
}

- (NSArray *)users
{
    if(!_users)
    {
        _users = [[NSArray alloc] init];
        [UserProvider readUsers:self];
    }
    
    return _users;
}

- (void)didReceiveData:(NSArray *)items
{
    self.users = items;
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    User *user = [self.users objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = user.comment;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

@end
