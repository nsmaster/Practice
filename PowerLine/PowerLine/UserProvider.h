//
//  UserProvider.h
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProvider.h"
#import "User.h"

@protocol UserDataSource <BaseDataSource>


@end

@interface UserProvider : BaseProvider

+ (void)readUsers:(id<UserDataSource>)delegate;

@end
