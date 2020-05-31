//
//  BottomView.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomView : UIView

@property (nonatomic,copy) void (^switchBlock)(BOOL isOn);
@property (nonatomic,copy) void (^addPizzaBlock)(NSUInteger count);


- (void)updateSummaryLabelWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
