//
//  LoadedImageProvider.m
//  Countries
//
//  Created by Nikolay Shatilo on 14.01.14.
//  Copyright (c) 2014 Nikolay Shatilo. All rights reserved.
//

#import "LoadedImageProvider.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface LoadedImageProvider()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSEntityDescription *entity;

@end

@implementation LoadedImageProvider

- (id)init
{
    self = [super init];
    if(self) {
        _managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
        _entity = [NSEntityDescription entityForName:@"LoadedImage" inManagedObjectContext:_managedObjectContext];
    }
    
    return self;
}

- (UIImage *)imageFromUrl:(NSURL *)url
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:self.entity];
    [request setPredicate:[NSPredicate predicateWithFormat:@"imageUrl == %@", [url absoluteString]]];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if([result count] != 0) {
        NSManagedObject *loadedImage = [result objectAtIndex:0];
        return [[UIImage alloc] initWithData:[loadedImage valueForKey:@"image"]];
    }
    
    return nil;
}

- (void)insertImage:(UIImage *)image url:(NSURL *)url
{
    NSManagedObject *loadedImage = [NSEntityDescription insertNewObjectForEntityForName:[self.entity name] inManagedObjectContext:self.managedObjectContext];
    
    [loadedImage setValue:[url absoluteString] forKey:@"imageUrl"];
    [loadedImage setValue:UIImagePNGRepresentation(image) forKey:@"image"];
    
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;

    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
