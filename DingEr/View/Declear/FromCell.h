//
//  FromCell.h
//  DingEr
//
//  Created by Tcy on 2018/4/24.
//  Copyright © 2018年 Tcytachiever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FromCell : UIView
@property (nonatomic ) BOOL isRead;
- (void)createWithName:(NSString *)name Price:(NSString *)price Count:(NSString *)count;

@property (copy, nonatomic) void (^closeCell)(NSInteger sig);

@end
