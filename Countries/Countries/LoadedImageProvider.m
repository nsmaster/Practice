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

@end

@implementation LoadedImageProvider

- (id)init
{
    self = [super init];
    if(self) {
        _managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    }
    
    return self;
}

- (UIImage *)imageFromURL:(NSURL *)url
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"LoadedImage"];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"imageUrl == %@", [url absoluteString]]];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if([result count] != 0) {
        NSManagedObject *loadedImage = [result firstObject];
        return [[UIImage alloc] initWithData:[loadedImage valueForKey:@"image"]];
    }
    
    return nil;
}

- (void)storeImage:(NSData *)imageData URL:(NSURL *)url
{
    NSManagedObject *loadedImage = [NSEntityDescription insertNewObjectForEntityForName:@"LoadedImage" inManagedObjectContext:self.managedObjectContext];
    
    [loadedImage setValue:[url absoluteString] forKey:@"imageUrl"];
    [loadedImage setValue:imageData forKey:@"image"];
    
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
