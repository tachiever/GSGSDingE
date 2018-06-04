//
//  PersonView.h
//  DingEr
//
//  Created by Tcy on 2018/4/26.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonView : UIView

- (void)updateWithPersonArr:(NSMutableArray *)personArr;

@property (nonatomic ) NSString *title;
@property (nonatomic ) NSInteger model;
@property (nonatomic ) BOOL isEdit;
@property (nonatomic ) BOOL isAdded;
@property (copy,nonatomic) void (^actionAddPerson)(NSInteger tag);

@end
