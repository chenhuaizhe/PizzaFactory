//
//  MainView.h
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface MainView : UIView

@property (nonatomic,strong) MainViewModel *viewModel;

@property (nonatomic,copy) void (^chefSwitchBlock)(NSString *chefName,BOOL isOn);
@property (nonatomic,copy) void (^mainSwitchBlock)(BOOL isOn);
@property (nonatomic,copy) void (^addPizzaBlock)(NSUInteger count);



#pragma mark - Update UI

- (void)reloadChefView0;
- (void)reloadChefView1;
- (void)reloadChefView2;
- (void)reloadChefView3;
- (void)reloadChefView4;
- (void)reloadChefView5;
- (void)reloadChefView6;

- (void)updateSummaryLabel;

@end

NS_ASSUME_NONNULL_END
