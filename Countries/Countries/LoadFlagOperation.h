//
//  PerformCellBlockOperation.h
//  Countries
//
//  Created by Nikolay Shatilo on 02.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadFlagOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong, readonly) NSIndexPath *indexPath;

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagUrl:(NSURL *)aFlagUrl completion:(void(^)(UIImage *image))aCompletionBlock;

- (id)init __attribute__((unavailable()));

@end
