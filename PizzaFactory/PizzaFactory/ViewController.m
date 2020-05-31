//
//  ViewController.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "ViewController.h"
#import "FBKVOController.h"
#import "MainView.h"
#import "MainViewModel.h"
#import "GCD.h"
#import "Toast.h"

@interface ViewController ()

@property (nonatomic, strong) MainView *mainView;
@property (nonatomic, strong) MainViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self KVOHandler];
    [self.view addSubview:self.mainView];
    self.mainView.viewModel = self.viewModel;
    
}
#pragma mark -观察者
- (void)KVOHandler {
    __weak ViewController *weakSelf = self;
    [self.KVOController observe:weakSelf.viewModel.chef0 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView0];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef1 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView1];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef2 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView2];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef3 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView3];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef4 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView4];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef5 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView5];
        }];
    }];
    [self.KVOController observe:weakSelf.viewModel.chef6 keyPath:@"remainPizza" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView reloadChefView6];
        }];
    }];
    //remindingPizzaSummary
    [self.KVOController observe:weakSelf.viewModel keyPath:@"remindingPizzaSummary" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        __strong typeof(self) strongSelf = self;
        [GCDQueue executeInMainQueue:^{
            [strongSelf.mainView updateSummaryLabel];
        }];
    }];
}


#pragma mark - lazy load
- (MainView *)mainView {
    if (!_mainView) {
        _mainView = [[MainView alloc]initWithFrame:self.view.bounds];
        [self mainViewBlocks];
    }
    return _mainView;
}

- (MainViewModel *)viewModel {
    if (!_viewModel) {
        BOOL app_need_resume = [[NSUserDefaults standardUserDefaults]boolForKey:@"app_need_resume"];
        if (app_need_resume) {
            _viewModel = [[MainViewModel alloc]initFromLocal];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"app_need_resume"];
            [GCDQueue executeInMainQueue:^{
                [Toast makeToast:@"App terminate unexpected, resumed Success!" duration:3.f position:CSToastPositionCenter];
            } afterDelaySecs:2.f];
        }else {
            _viewModel = [[MainViewModel alloc]initWithRemainingPizza:1000];
        }
    }
    return _viewModel;
}

#pragma mark - action

- (void)mainViewBlocks {
    __weak typeof(self) weakSelf = self;
    _mainView.chefSwitchBlock = ^(NSString * _Nonnull chefName, BOOL isOn) {
        [weakSelf.viewModel chefSwitchActionWithName:chefName isOn:isOn];
    };
    _mainView.mainSwitchBlock = ^(BOOL isOn) {
        if (isOn) {
            [weakSelf.viewModel startAllPizzaQueue];
        }else {
            [weakSelf.viewModel stopAllPizzaQueue];
        }
    };
    _mainView.addPizzaBlock = ^(NSUInteger count) {
        [weakSelf.viewModel addMorePizza:count];
    };
}


@end
