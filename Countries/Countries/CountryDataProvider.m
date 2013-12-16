//
//  NS_CountryDataProvider.m
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "CountryDataProvider.h"
#import "Country.h"

#ifndef BaseImageUrl
#define BaseImageUrl @"http://wareous.com/guest/country_list/"
#endif

@implementation CountryDataProvider


+ (NSArray *)getCountries
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"];
    
    NSArray *sourceList = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSString *item in sourceList) {        
        NSArray *parts = [item componentsSeparatedByString:@"."];
        
        Country *country = [[Country alloc] init];
        
        country.Name = [parts objectAtIndex:0];
        country.ImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageUrl, item]];
        
        [result addObject:country];
    }
    
    
    return result;
}

@end
