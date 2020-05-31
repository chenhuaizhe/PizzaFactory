//
//  ChefView.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Chef;

NS_ASSUME_NONNULL_BEGIN

@interface ChefView : UIView

@property (nonatomic,strong) Chef *chef;

@property (nonatomic,copy) void (^switchBlock)(NSString *chefName,BOOL isOn);

- (void)turnOffSwitch;
- (void)turnOnSwitch;

@end

NS_ASSUME_NONNULL_END
