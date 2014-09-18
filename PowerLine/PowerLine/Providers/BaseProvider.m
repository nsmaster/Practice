//
//  BaseProvider.m
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "BaseProvider.h"
#import <AFNetworking.h>

@implementation BaseProvider

static NSString * const BaseURLString = @"http://109.251.99.209:7700/json/";

+ (void)readData:(id<BaseDataSource>)delegate withFunctionName:(NSString *)functionName
{
    // 1
    NSString *string = [NSString stringWithFormat:@"%@%@", BaseURLString, functionName];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *objects = [self parse:responseObject];
        
        //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [delegate didReceiveData:objects];
        //}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error retrieving data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}

+ (NSArray *)parse:(NSDictionary *)source
{
    return nil;
}

@end
