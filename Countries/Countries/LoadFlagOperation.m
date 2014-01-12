//
//  PerformCellBlockOperation.m
//  Countries
//
//  Created by Nikolay Shatilo on 02.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "LoadFlagOperation.h"

@interface LoadFlagOperation ()

@property (nonatomic, strong) Country *country;

@property (nonatomic, strong) NSMutableData *receivedData;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isDone;

@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, assign) BOOL isFinished;

@end

@implementation LoadFlagOperation

- (id)initWithIndexPath:(NSIndexPath *)aIndexPath tableView:(UITableView *)aTableView country:(Country *)aCountry;
{
    self = [super init];
    if(self) {
        _indexPath = aIndexPath;
        _tableView = aTableView;
        _country = aCountry;
        
        _isDone = NO;
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
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.country.imageUrl];
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    while(![self isCancelled] && !self.isDone) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    self.isExecuting = NO;
    self.isFinished = YES;
}

- (BOOL)isConcurrent
{
    return YES;
}

+ (BOOL)automaticallyNotifiesObserversForKey: (NSString*) key
{
    return YES;
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.isDone = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(![self isCancelled]) {
        [self.receivedData setLength:0];
        return;
    }
    
    [connection  cancel];
    self.isDone = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(![self isCancelled]) {
        [self.receivedData appendData:data];
        return;
    }

    [connection  cancel];
    self.isDone = YES;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:self.receivedData];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
        cell.imageView.image = image;
        self.country.image = image;
    }];
    
    self.isDone = YES;
}
@end
