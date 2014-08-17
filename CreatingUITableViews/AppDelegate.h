//
//  AppDelegate.h
//  CreatingUITableViews
//
//  Created by John Malloy on 8/9/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, strong) UINavigationController * navigationController;
@property (nonatomic, strong) MainTableViewController * tableViewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
