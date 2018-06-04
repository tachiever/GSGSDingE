//
//  AppDelegate.h
//  DingEr
//
//  Created by Tcy on 2018/4/10.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) AFNetworkReachabilityStatus status;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

