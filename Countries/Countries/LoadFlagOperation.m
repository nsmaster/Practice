//
//  PerformCellBlockOperation.m
//  Countries
//
//  Created by Nikolay Shatilo on 02.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "LoadFlagOperation.h"

@interface LoadFlagOperation ()

@property (nonatomic, strong) NSURL *flagUrl;
@property (nonatomic, copy) void(^block)(UIImage *image);

@property (nonatomic, strong) NSMutableData *receivedData;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isDone;

@end

@implementation LoadFlagOperation

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagUrl:(NSURL *)aFlagUrl completion:(void(^)(UIImage *image))aCompletionBlock
{
    self = [super init];
    if(self) {
        self.indexPath = aIndexPath;
        self.flagUrl = aFlagUrl;
        self.block = [aCompletionBlock copy];
        
        self.isDone = NO;
    }
    
    return self;
}

- (void)main
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.flagUrl];
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    while(!self.isCancelled && !self.isDone) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.isDone = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(!self.isCancelled) {
        [self.receivedData setLength:0];
        return;
    }
    
    [connection  cancel];
    self.isDone = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(!self.isCancelled) {
        [self.receivedData appendData:data];
        return;
    }

    [connection  cancel];
    self.isDone = YES;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(self.block) {
        self.block([[UIImage alloc] initWithData:self.receivedData]);
    }
    
    self.isDone = YES;
}

@end
