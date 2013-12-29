//
//  NS_ViewController.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *countries;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.countries = [CountryDataProvider countries];
    self.operationQueue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultFlag" ofType:@"jpg"];
    
    cell.imageView.image = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfFile:path]];
    
    if(country.image) {
        cell.imageView.image = country.image;
    } else {
        [self.operationQueue addOperationWithBlock:^{
            country.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:country.imageUrl]];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if([tableView.indexPathsForVisibleRows containsObject:indexPath]) {
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }];
    }
    
    return cell;
}


@end
