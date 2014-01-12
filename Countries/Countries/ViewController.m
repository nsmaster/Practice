//
//  NS_ViewController.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "LoadFlagOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

NSString * const CellId = @"CountryCell";

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
}

- (NSArray *)countries
{
    if(!_countries) {
        _countries = [CountryDataProvider countries];
    }
    
    return _countries;
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
    
    if(country.image) {
        cell.imageView.image = country.image;
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
            [self.operationQueue addOperation:[[LoadFlagOperation alloc] initWithIndexPath:indexPath tableView:tableView country:country]];
        }
    }
    
    return cell;
}
@end
