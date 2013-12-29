//
//  NS_CountryDataProvider.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "CountryDataProvider.h"
#import "Country.h"

@implementation CountryDataProvider

NSString * const BaseImageUrl = @"http://wareous.com/guest/country_list/";

+ (NSArray *)countries
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"];
    
    NSArray *sourceList = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSString *item in sourceList) {        
        NSArray *parts = [item componentsSeparatedByString:@"."];
        
        Country *country = [[Country alloc] init];
        
        country.name = [parts objectAtIndex:0];
        country.imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageUrl, item]];
        
        [result addObject:country];
    }
    
    
    return result;
}

@end
