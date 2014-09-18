//
//  CostGroupItemViewController.m
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 23.05.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "CostGroupItemViewController.h"
#import "CostGroupManager.h"

@interface CostGroupItemViewController ()

@property (nonatomic, weak) UITextField *nameTextField;

@end

@implementation CostGroupItemViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveItem)];
}

- (void)saveItem
{
    if(!self.costGroup)
        self.costGroup = [CostGroupManager createCostGroup];
    
    self.costGroup.name = self.nameTextField.text;
    
    [CostGroupManager saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
            self.nameTextField = (UITextField *)[cell viewWithTag:100];
            
            if(!self.costGroup) {
                self.nameTextField.text = self.costGroup.name;
            }
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end
