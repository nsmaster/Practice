//
//  LoadedImageProvider.h
//  Countries
//
//  Created by Nikolay Shatilo on 14.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadedImageProvider : NSObject

- (UIImage *)imageFromUrl:(NSURL *)url;

- (void)insertImage:(UIImage *)image url:(NSURL *)url;

@end
