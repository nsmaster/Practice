//
//  NS_ViewController.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "CellBlockOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

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
	
    self.countries = [CountryDataProvider countries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.countries = nil;
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CountryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    Country *country = [self.countries objectAtIndex:indexPath.row];
    
    cell.textLabel.text = country.name;
    cell.imageView.image = [UIImage imageNamed:@"defaultFlag.jpg"];
    
    if(country.image) {
        cell.imageView.image = country.image;
    } else {
        BOOL operationWasAdded = NO;
        
        for (CellBlockOperation *operation in self.operationQueue.operations) {
            if([tableView.indexPathsForVisibleRows containsObject:operation.indexPath] == NO) {
                [operation cancel];
            }
            
            if(operation.indexPath == indexPath && operation.isCancelled == NO) {
                operationWasAdded = YES;
            }
        }
        
        if(!operationWasAdded) {
            [self.operationQueue addOperation:[[CellBlockOperation alloc] initWithIndexPath:indexPath block:^{
                country.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:country.imageUrl]];
            
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    if([tableView.indexPathsForVisibleRows containsObject:indexPath]) {
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                }];
            }]];
        }
    }
    
    return cell;
}


@end
