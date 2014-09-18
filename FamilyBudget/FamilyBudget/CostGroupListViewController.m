//
//  CostGroupViewController.m
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 23.05.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "CostGroupListViewController.h"
#import "CostGroupManager.h"
#import "CostGroupItemViewController.h"

@interface CostGroupListViewController ()

@property (nonatomic, strong) NSArray *costGroups;

@end

@implementation CostGroupListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewItem
{
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CostGroupItem"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma marks - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.costGroups = [CostGroupManager costGroupList];
    
    return [self.costGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CostGroupCell"];
    
    CostGroup *costGroup = [self.costGroups objectAtIndex:indexPath.row];
    
    cell.textLabel.text = costGroup.name;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
