//
//  CloudView.m
//  DCHP Visualization
//
//  Created by Nikolay Shatilo on 22.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "CloudView.h"

@interface CloudView ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation CloudView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

+ (id)createInstance
{
    UINib *nib = [UINib nibWithNibName:@"CloudView" bundle:nil];
    CloudView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    return view;
}

- (NSString *)text
{
    return self.label.text;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}

@end
