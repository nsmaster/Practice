//
//  PerformCellBlockOperation.m
//  Countries
//
//  Created by Nikolay Shatilo on 02.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "LoadFlagOperation.h"

@interface LoadFlagOperation ()

@property (nonatomic, copy) void(^block)(void);

@end

@implementation LoadFlagOperation

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath block:(void(^)(void))aBlock
{
    self = [super init];
    if(self) {
        _indexPath = aIndexPath;
        _block = [aBlock copy];
    }
    
    return self;
}

- (void)main
{
    if(!self.isCancelled && self.block) {
        self.block();
    }
}

@end
