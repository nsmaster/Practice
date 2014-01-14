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
@property (nonatomic, strong) UIImage *flag;

@property (nonatomic, strong) NSMutableData *receivedData;

@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, assign) BOOL isFinished;

@end

@implementation LoadFlagOperation

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath flagUrl:(NSURL *)aFlagUrl
{
    self = [super init];
    if(self) {
        _indexPath = aIndexPath;
        _flagUrl = aFlagUrl;
        
        _isExecuting = NO;
        _isFinished = NO;
    }
    
    return self;
}

- (void)start
{
    if ([self isCancelled])
    {
        self.isFinished = YES;
        return;
    }
    
    self.isExecuting = YES;
    
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
}

- (void)main
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.flagUrl];
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    while(![self isCancelled] && !self.isFinished) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (BOOL)isConcurrent
{
    return YES;
}

+ (BOOL)automaticallyNotifiesObserversForKey: (NSString*) key
{
    return YES;
}

- (void)completeOperation
{
    self.isExecuting = NO;
    self.isFinished = YES;
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
    self.flag = [[UIImage alloc] initWithData:self.receivedData];
    
    [self completeOperation];
}
@end
