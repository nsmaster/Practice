//
//  BaseProvider.h
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseDataSource <NSObject>

@required

- (void)didReceiveData:(NSArray *)items;

@end

@interface BaseProvider : NSObject

+ (void)readData:(id<BaseDataSource>)delegate withFunctionName:(NSString *)functionName;

@end
