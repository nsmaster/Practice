//
//  PerformCellBlockOperation.h
//  Countries
//
//  Created by Nikolay Shatilo on 02.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"

@interface LoadFlagOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong, readonly) NSIndexPath *indexPath;

@property (nonatomic, assign, readonly) BOOL isExecuting;

@property (nonatomic, assign, readonly) BOOL isFinished;

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath tableView:(UITableView *)aTableView country:(Country *)aCountry;

- (id)init UNAVAILABLE_ATTRIBUTE;

@end
