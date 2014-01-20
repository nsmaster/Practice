//
//  LoadedImage.h
//  Countries
//
//  Created by Nikolay Shatilo on 20.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LoadedImage : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * imageUrl;

@end
