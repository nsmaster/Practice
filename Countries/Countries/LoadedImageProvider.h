//
//  LoadedImageProvider.h
//  Countries
//
//  Created by Nikolay Shatilo on 14.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadedImageProvider : NSObject

- (UIImage *)imageFromURL:(NSURL *)url;

- (void)storeImage:(NSData *)imageData URL:(NSURL *)url;

@end
