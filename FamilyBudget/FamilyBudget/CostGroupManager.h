//
//  CostGroupManager.h
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 31.07.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CostGroup.h"

@interface CostGroupManager : NSObject

+ (NSArray *)costGroupList;

+ (CostGroup *)createCostGroup;

+ (void)saveContext;

@end
