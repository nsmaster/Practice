//
//  CloudView.h
//  DCHP Visualization
//
//  Created by Nikolay Shatilo on 22.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudView : UIView

@property (nonatomic, strong) NSString *text;

+ (id)createInstanceWithPoint;
+ (id)createInstanceWithPoint:(CGPoint)point;

@end
