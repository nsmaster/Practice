//
//  CostGroupManager.m
//  FamilyBudget
//
//  Created by Nikolay Shatilo on 31.07.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "CostGroupManager.h"
#import "AppDelegate.h"

@interface CostGroupManager()

@property (nonatomic, weak, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation CostGroupManager

+ (NSArray *)costGroupList
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CostGroup"];
    
    NSArray *fetchResult = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    return fetchResult;
}

+ (CostGroup *)createCostGroup
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"CostGroup" inManagedObjectContext:self.managedObjectContext];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return appDelegate.managedObjectContext;
}

+ (void)saveContext
{
    [self.managedObjectContext save:nil];
}

@end
