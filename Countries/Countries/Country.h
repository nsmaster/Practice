//
//  NS_Country.h
//  Countries
//
//  Created by Nikolay Shatilo on 13.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString *Name;

@property (nonatomic, strong) NSURL *ImageUrl;

@property (strong) UIImage *Image;

@end
