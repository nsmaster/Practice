//
//  CostGroup.h
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 23.05.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CostGroup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * image;

@end
