//
//  NS_ViewController.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "NS_ViewController.h"

@interface NS_ViewController ()
{
    NSArray *countries;
}

@end

@implementation NS_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    countries = [NS_CountryDataProvider getCountries];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CountruCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    NS_Country *country = [countries objectAtIndex:indexPath.row];
    
    cell.textLabel.text = country.Name;
    
    
    if(country.Image) {
        cell.imageView.image = country.Image;
    }
    else {
        NSBlockOperation* blockOperation = [NSBlockOperation blockOperationWithBlock:^{
            country.Image = [UIImage imageWithData:[NSData dataWithContentsOfURL:country.ImageUrl]];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [[NSOperationQueue currentQueue] addOperation:blockOperation];
    }
    
    return cell;
}


@end
