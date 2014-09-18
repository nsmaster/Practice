//
//  User.h
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSNumber *roleId;

@property (nonatomic, strong) NSString *comment;

@end
