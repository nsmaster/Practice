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

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagURL:(NSURL *)aFlagURL completionBlock:(void(^)(NSData *data))aCompletionBlock;

- (id)init UNAVAILABLE_ATTRIBUTE;

@end
