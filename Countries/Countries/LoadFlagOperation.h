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
@property (nonatomic, strong, readonly) NSURL *flagUrl;
@property (nonatomic, strong, readonly) UIImage *flag;

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagUrl:(NSURL *)aFlagUrl;

- (id)init UNAVAILABLE_ATTRIBUTE;

@end
