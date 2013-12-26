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

        
        self.backgroundColor = [UIColor redColor];
        // Initialization code
    }
    return self;
}

+ (id)createInstanceWithPoint
{
    UINib *nib = [UINib nibWithNibName:@"CloudView" bundle:nil];
    CloudView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    
    return view;
}

+ (id)createInstanceWithPoint:(CGPoint)point
{
    CloudView *view = [CloudView createInstanceWithPoint];
    view.center = point;
    
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (NSString *)text
{
    return self.label.text;
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}

@end
