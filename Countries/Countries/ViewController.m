//
//  NS_ViewController.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "LoadFlagOperation.h"
#import "AppDelegate.h"
#import "LoadedImageProvider.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) LoadedImageProvider *imageProvider;

@end

@implementation ViewController

NSString * const CellId = @"CountryCell";
NSString * const PropertyNameIsFinished = @"isFinished";

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        [self.operationQueue setMaxConcurrentOperationCount:5];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.countries = nil;
    self.imageProvider = nil;
}

- (NSArray *)countries
{
    if(!_countries) {
        _countries = [CountryDataProvider countries];
    }
    
    return _countries;
}

- (LoadedImageProvider *)imageProvider
{
    if(!_imageProvider) {
        _imageProvider = [[LoadedImageProvider alloc] init];
    }
    
    return _imageProvider;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isKindOfClass:[LoadFlagOperation class]] && [keyPath isEqualToString:PropertyNameIsFinished]) {
        LoadFlagOperation *loadFlagOperation = object;
        
        if(loadFlagOperation.flag) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:loadFlagOperation.indexPath];
                cell.imageView.image = loadFlagOperation.flag;
                
                [self.imageProvider insertImage:loadFlagOperation.flag url:loadFlagOperation.flagUrl];
            }];
        }
        
        [object removeObserver:self forKeyPath:PropertyNameIsFinished context:nil];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    Country *country = [self.countries objectAtIndex:indexPath.row];
    
    cell.textLabel.text = country.name;
    cell.imageView.image = [UIImage imageNamed:@"defaultFlag.jpg"];
    
    UIImage *flag = [self.imageProvider imageFromUrl:country.imageUrl];
    
    if(flag) {
        cell.imageView.image = flag;
    } else {
        BOOL isOperationInQueue = NO;
        
        NSArray *operations = [NSArray arrayWithArray:self.operationQueue.operations];
        for (LoadFlagOperation *operation in operations) {
            if([tableView.indexPathsForVisibleRows containsObject:operation.indexPath] == NO) {
                [operation cancel];
            }
            
            if(operation.indexPath == indexPath && operation.isCancelled == NO) {
                isOperationInQueue = YES;
            }
        }
        
        if(!isOperationInQueue) {
            LoadFlagOperation *loadFlagOperation = [[LoadFlagOperation alloc] initWithIndexPath:indexPath flagUrl:country.imageUrl];
            [loadFlagOperation addObserver:self forKeyPath:PropertyNameIsFinished options:NSKeyValueObservingOptionNew context:nil];
            
            [self.operationQueue addOperation:loadFlagOperation];
        }
    }
    
    return cell;
}
@end
