//
//  UserProvider.m
//  PowerLine
//
//  Created by Nikolay Shatilo on 17.09.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "UserProvider.h"
#import <AFNetworking.h>
#import "User.h"

@implementation UserProvider

+ (void)readUsers:(id<UserDataSource>)delegate;
{
    [super readData:delegate withFunctionName:@"GetUsers"];    
}

+ (NSArray *)parse:(NSDictionary *)source
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *list = [source valueForKey:@"GetUsersResult"];
    
    for (NSDictionary *item in list) {
        User *user = [[User alloc] init];
        
        user.id = [item valueForKey:@"Id"];
        user.name = [item valueForKey:@"Name"];
        user.password = [item valueForKey:@"Password"];
        user.comment = [item valueForKey:@"Comment"];
        user.roleId = [item valueForKey:@"RoleId"];
        
        [result addObject:user];
    }
    
    return result;
}

@end
