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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.countries = [CountryDataProvider getCountries];
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
    
    cell.textLabel.text = country.Name;
    cell.imageView.image = nil;
    
    if(country.Image) {
        cell.imageView.image = country.Image;
    } else {
        NSBlockOperation* blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            country.Image = [UIImage imageWithData:[NSData dataWithContentsOfURL:country.ImageUrl]];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [[NSOperationQueue mainQueue] addOperation:blockOperation];
    }
    
    return cell;
}


@end
