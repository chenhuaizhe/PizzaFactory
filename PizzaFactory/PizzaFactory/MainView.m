//
//  MainView.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "MainView.h"
#import "MainViewModel.h"
#import "BottomView.h"
#import "ChefView.h"

@interface MainView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) BottomView *bottomView;

@property (nonatomic, strong)  ChefView *chefView0;
@property (nonatomic, strong)  ChefView *chefView1;
@property (nonatomic, strong)  ChefView *chefView2;
@property (nonatomic, strong)  ChefView *chefView3;
@property (nonatomic, strong)  ChefView *chefView4;
@property (nonatomic, strong)  ChefView *chefView5;
@property (nonatomic, strong)  ChefView *chefView6;

@end


@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self drawTopView];
    [self drawBottomView];
}

- (void)drawTopView {
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(20, 50, self.bounds.size.width-20*2, self.bounds.size.height*0.8-50)];
    [self addSubview:self.topView];
    self.topView.backgroundColor = [UIColor grayColor];
    self.topView.layer.borderColor = [UIColor blackColor].CGColor;
    self.topView.layer.borderWidth = 0.5;
    
    [self drawChefView];
}

- (void)drawBottomView {
    self.bottomView = [[BottomView alloc]initWithFrame:CGRectMake(20, self.bounds.size.height*0.8, self.bounds.size.width-20*2, self.bounds.size.height*0.2-50)];
    [self addSubview:self.bottomView];
    self.bottomView.backgroundColor = [UIColor lightGrayColor];
    self.bottomView.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomView.layer.borderWidth = 0.5;
    __weak typeof(self) weakSelf = self;
    self.bottomView.switchBlock = ^(BOOL isOn) {
        if (weakSelf.mainSwitchBlock) {
            weakSelf.mainSwitchBlock(isOn);
        }
        //如果将开关改为打开，则打开所有分开关，反之则关闭所有分开关
        if (isOn) {
            [weakSelf turnOnAllSwitch];
        }else {
            [weakSelf turnOffAllSwitch];
        }
    };
    self.bottomView.addPizzaBlock = ^(NSUInteger count) {
        if (weakSelf.addPizzaBlock) {
            weakSelf.addPizzaBlock(count);
        }
    };
}

- (void)drawChefView {
    CGFloat w = self.topView.bounds.size.width/7;
    CGFloat h = self.topView.bounds.size.height;
    self.chefView0 = [[ChefView alloc]initWithFrame:CGRectMake(w*0, 0, w, h)];
    [self.topView addSubview:self.chefView0];
    self.chefView1 = [[ChefView alloc]initWithFrame:CGRectMake(w*1, 0, w, h)];
     [self.topView addSubview:self.chefView1];
    self.chefView2 = [[ChefView alloc]initWithFrame:CGRectMake(w*2, 0, w, h)];
     [self.topView addSubview:self.chefView2];
    self.chefView3 = [[ChefView alloc]initWithFrame:CGRectMake(w*3, 0, w, h)];
     [self.topView addSubview:self.chefView3];
    self.chefView4 = [[ChefView alloc]initWithFrame:CGRectMake(w*4, 0, w, h)];
     [self.topView addSubview:self.chefView4];
    self.chefView5 = [[ChefView alloc]initWithFrame:CGRectMake(w*5, 0, w, h)];
     [self.topView addSubview:self.chefView5];
    self.chefView6 = [[ChefView alloc]initWithFrame:CGRectMake(w*6, 0, w, h)];
     [self.topView addSubview:self.chefView6];
    
    __weak typeof(self) weakSelf = self;
    self.chefView0.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView1.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView2.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView3.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView4.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView5.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    self.chefView6.switchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        if (weakSelf.chefSwitchBlock) {
            weakSelf.chefSwitchBlock(chefName, isOn);
        }
    };
    
}

#pragma mark - view model

- (void)setViewModel:(MainViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.chefView0.chef = viewModel.chef0;
    self.chefView1.chef = viewModel.chef1;
    self.chefView2.chef = viewModel.chef2;
    self.chefView3.chef = viewModel.chef3;
    self.chefView4.chef = viewModel.chef4;
    self.chefView5.chef = viewModel.chef5;
    self.chefView6.chef = viewModel.chef6;
}

#pragma mark - Update UI

- (void)reloadChefView0;
{
    self.chefView0.chef = _viewModel.chef0;
}

- (void)reloadChefView1;
{
    self.chefView1.chef = _viewModel.chef1;
}

- (void)reloadChefView2;
{
    self.chefView2.chef = _viewModel.chef2;
}

- (void)reloadChefView3;
{
    self.chefView3.chef = _viewModel.chef3;
}

- (void)reloadChefView4;
{
    self.chefView4.chef = _viewModel.chef4;
}

- (void)reloadChefView5;
{
    self.chefView5.chef = _viewModel.chef5;
}

- (void)reloadChefView6;
{
    self.chefView6.chef = _viewModel.chef6;
}

- (void)updateSummaryLabel; {
    [self.bottomView updateSummaryLabelWithText:self.viewModel.remindingPizzaSummary];
}

- (void)turnOffAllSwitch {
    [self.chefView0 turnOffSwitch];
    [self.chefView1 turnOffSwitch];
    [self.chefView2 turnOffSwitch];
    [self.chefView3 turnOffSwitch];
    [self.chefView4 turnOffSwitch];
    [self.chefView5 turnOffSwitch];
    [self.chefView6 turnOffSwitch];
}

- (void)turnOnAllSwitch {
    [self.chefView0 turnOnSwitch];
    [self.chefView1 turnOnSwitch];
    [self.chefView2 turnOnSwitch];
    [self.chefView3 turnOnSwitch];
    [self.chefView4 turnOnSwitch];
    [self.chefView5 turnOnSwitch];
    [self.chefView6 turnOnSwitch];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
