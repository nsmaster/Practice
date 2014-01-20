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
@property (nonatomic, copy) void(^completion)(NSData *);

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *receivedData;

@property (atomic, assign, getter = isExecuting) BOOL executing;
@property (atomic, assign, getter = isFinished) BOOL finished;

@end

@implementation LoadFlagOperation

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagURL:(NSURL *)aFlagURL completionBlock:(void(^)(NSData *data))aCompletionBlock
{
    self = [super init];
    if(self) {
        _indexPath = aIndexPath;
        _flagUrl = aFlagURL;
        _completion = [aCompletionBlock copy];
    }
    
    return self;
}

- (void)start
{
    if ([self isCancelled])
    {
        self.finished = YES;
        return;
    }
    
    self.executing = YES;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.flagUrl];
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    while(!self.isFinished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)completeOperation
{
    self.executing = NO;
    self.finished = YES;
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self completeOperation];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(![self isCancelled]) {
        [self.receivedData setLength:0];
        return;
    }
    
    [connection  cancel];
    [self completeOperation];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(![self isCancelled]) {
        [self.receivedData appendData:data];
        return;
    }

    [connection  cancel];
    [self completeOperation];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self completeOperation];
    
    if(self.completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completion(self.receivedData);
        });
    }
}
@end
