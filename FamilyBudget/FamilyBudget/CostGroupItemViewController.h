//
//  CostGroupItemViewController.h
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 23.05.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostGroup.h"

@interface CostGroupItemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CostGroup *costGroup;

@end
