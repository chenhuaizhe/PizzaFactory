//
//  MainViewModel.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "MainViewModel.h"
#import "Chef.h"
#import "Pizza.h"
#import "GCD.h"
#import "SQLManager.h"
#import "SQLManager+Data.h"

static NSString *chefName0 = @"Pizza Chef 0";
static NSString *chefName1 = @"Pizza Chef 1";
static NSString *chefName2 = @"Pizza Chef 2";
static NSString *chefName3 = @"Pizza Chef 3";
static NSString *chefName4 = @"Pizza Chef 4";
static NSString *chefName5 = @"Pizza Chef 5";
static NSString *chefName6 = @"Pizza Chef 6";

@interface MainViewModel()

@property (nonatomic, assign) NSUInteger pizzaCount;

@property (nonatomic, strong) GCDTimer *gcdTimer0;
@property (nonatomic, strong) GCDTimer *gcdTimer1;
@property (nonatomic, strong) GCDTimer *gcdTimer2;
@property (nonatomic, strong) GCDTimer *gcdTimer3;
@property (nonatomic, strong) GCDTimer *gcdTimer4;
@property (nonatomic, strong) GCDTimer *gcdTimer5;
@property (nonatomic, strong) GCDTimer *gcdTimer6;

@property (nonatomic, strong) GCDTimer *gcdTimer99;

@property (nonatomic, strong) NSMutableArray *array0;
@property (nonatomic, strong) NSMutableArray *array1;
@property (nonatomic, strong) NSMutableArray *array2;
@property (nonatomic, strong) NSMutableArray *array3;
@property (nonatomic, strong) NSMutableArray *array4;
@property (nonatomic, strong) NSMutableArray *array5;
@property (nonatomic, strong) NSMutableArray *array6;

@property (nonatomic, assign) BOOL isFromLocal;

@end

@implementation MainViewModel

- (instancetype)initWithRemainingPizza:(NSInteger)pizzaCount {
    if (self = [super init]) {
        _pizzaCount = pizzaCount;
        [[NSUserDefaults standardUserDefaults]setInteger:pizzaCount forKey:@"pizza_count"];
        
        [self init7ChefWithPizza];
    }
    return self;
}

- (instancetype)initFromLocal;
{
    if (self = [super init]) {
        _pizzaCount =     [[NSUserDefaults standardUserDefaults]integerForKey:@"pizza_count"];
        _isFromLocal = YES;
        [self init7ChefWithPizza];
    }
    return self;
}

- (void)initPizzaArray {
    if (!self.isFromLocal) {
        self.array0 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array1 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array2 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array3 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array4 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array5 = [[NSMutableArray alloc]initWithCapacity:10];
        self.array6 = [[NSMutableArray alloc]initWithCapacity:10];
    }else {
        self.array0 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef0];
        self.array1 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef1];
        self.array2 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef2];
        self.array3 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef3];
        self.array4 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef4];
        self.array5 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef5];
        self.array6 = [[SQLManager shareInstance]selectAllUnDoPizzaOfChef:self.chef6];;
    }
}

//将1000个披萨分配出去,分给7个厨师
- (void)init7ChefWithPizza {
    [self initPizzaArray];
    
    for (int i = 0; i < _pizzaCount; i++) {
        Pizza *pizza = [[Pizza alloc]initWithNumber:i];
        if (i % 7 == 0) {
            [self.array0 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef0];
            }
        }
        else if (i % 7 == 1) {
            [self.array1 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef1];
            }
        }
        else if (i % 7 == 2) {
            [self.array2 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef2];
            }
        }
        else if (i % 7 == 3) {
            [self.array3 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef3];
            }
        }
        else if (i % 7 == 4) {
            [self.array4 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef4];
            }
        }
        else if (i % 7 == 5) {
            [self.array5 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef5];
            }
        }
        else if (i % 7 == 6) {
            [self.array6 addObject:pizza];
            if (!self.isFromLocal) {
                [[SQLManager shareInstance]insertPizzaData:pizza withChef:self.chef6];
            }
        }
    }
    
    self.chef0 = [[Chef alloc]initWithName:chefName0 iconName:@"chef0" speed:1 remainPizza:self.array0];
    self.chef1 = [[Chef alloc]initWithName:chefName1 iconName:@"chef1" speed:2 remainPizza:self.array1];
    self.chef2 = [[Chef alloc]initWithName:chefName2 iconName:@"chef2" speed:3 remainPizza:self.array2];
    self.chef3 = [[Chef alloc]initWithName:chefName3 iconName:@"chef3" speed:4 remainPizza:self.array3];
    self.chef4 = [[Chef alloc]initWithName:chefName4 iconName:@"chef4" speed:5 remainPizza:self.array4];
    self.chef5 = [[Chef alloc]initWithName:chefName5 iconName:@"chef5" speed:6 remainPizza:self.array5];
    self.chef6 = [[Chef alloc]initWithName:chefName6 iconName:@"chef6" speed:7 remainPizza:self.array6];
    
    [self startAllPizzaQueue];
    
    [self everySecondUpdateAction];
    
}

#pragma mark - 每秒更新的操作

- (void)everySecondUpdateAction {
    self.gcdTimer99 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    __weak typeof(self) weakSelf = self;
    [self.gcdTimer99 event:^{
        [weakSelf handlePizzaSummaryString];
    } timeIntervalWithSecs:1.0];
    [self.gcdTimer99 start];
}

- (void)handlePizzaSummaryString {
    NSString *str = [NSString stringWithFormat:@"%@:%ld  %@:%ld  %@:%ld  \n%@:%ld  %@:%ld  %@:%ld  \n%@:%ld  ",chefName0,self.array0.count,chefName1,self.array1.count,chefName2,self.array2.count,chefName3,self.array3.count,chefName4,self.array4.count,chefName5,self.array5.count,chefName6,self.array6.count];
    self.remindingPizzaSummary = str;
}


#pragma mark - gcd
- (void)startWorkWithTimer:(GCDTimer *)timer chef:(Chef *)chef array:(NSMutableArray *)array second:(float)secs {
    [timer event:^{
        NSLog(@"定时器已执行");
        if (array.count > 0) {
            Pizza *pizza = array.firstObject;
            [array removeObject:pizza];
            chef.remainPizza = array;
            [[SQLManager shareInstance]pizzaDoneWithNumber:pizza.number];
        }else {
            NSLog(@"生产完成");
        }
    } cancelEvent:^{
        NSLog(@"定时器已取消");
    } timeIntervalWithSecs:secs];
    
    [timer start];
}


- (void)startWorkChef0 {
    self.gcdTimer0 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer0 chef:self.chef0 array:self.array0 second:1.0];
}


- (void)endWorkChef0 {
    [self.gcdTimer0 destroy];
}

- (void)startWorkChef1 {
    self.gcdTimer1 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer1 chef:self.chef1 array:self.array1 second:2.0];
}


- (void)endWorkChef1 {
    [self.gcdTimer1 destroy];
}

- (void)startWorkChef2 {
    self.gcdTimer2 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer2 chef:self.chef2 array:self.array2 second:3.0];
}


- (void)endWorkChef2 {
    [self.gcdTimer2 destroy];
}


- (void)startWorkChef3 {
    self.gcdTimer3 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer3 chef:self.chef3 array:self.array3 second:4.0];
}


- (void)endWorkChef3 {
    [self.gcdTimer3 destroy];
}

- (void)startWorkChef4 {
    self.gcdTimer4 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer4 chef:self.chef4 array:self.array4 second:5.0];
}


- (void)endWorkChef4 {
    [self.gcdTimer4 destroy];
}

- (void)startWorkChef5 {
    self.gcdTimer5 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer5 chef:self.chef5 array:self.array5 second:6.0];
}


- (void)endWorkChef5 {
    [self.gcdTimer5 destroy];
}

- (void)startWorkChef6 {
    self.gcdTimer6 = [[GCDTimer alloc]initInQueue:[GCDQueue globalQueue]];
    [self startWorkWithTimer:self.gcdTimer6 chef:self.chef6 array:self.array6 second:7.0];
}


- (void)endWorkChef6 {
    [self.gcdTimer6 destroy];
}


#pragma mark - view 触发的操作

- (void)chefSwitchActionWithName:(NSString *)name isOn:(BOOL)isOn; {
    if ([name isEqualToString:chefName0]) {
        if (isOn) {
            [self startWorkChef0];
        }else {
            [self endWorkChef0];
        }
    }else if ([name isEqualToString:chefName1]) {
        if (isOn) {
            [self startWorkChef1];
        }else {
            [self endWorkChef1];
        }
        
    }else if ([name isEqualToString:chefName2]) {
        if (isOn) {
            [self startWorkChef2];
        }else {
            [self endWorkChef2];
        }
        
    }else if ([name isEqualToString:chefName3]) {
        if (isOn) {
            [self startWorkChef3];
        }else {
            [self endWorkChef3];
        }
        
    }else if ([name isEqualToString:chefName4]) {
        if (isOn) {
            [self startWorkChef4];
        }else {
            [self endWorkChef4];
        }
        
    }else if ([name isEqualToString:chefName5]) {
        if (isOn) {
            [self startWorkChef5];
        }else {
            [self endWorkChef5];
        }
        
    }else if ([name isEqualToString:chefName6]) {
        if (isOn) {
            [self startWorkChef6];
        }else {
            [self endWorkChef6];
        }
        
    }
}

- (void)stopAllPizzaQueue; {
    [self endWorkChef0];
    [self endWorkChef1];
    [self endWorkChef2];
    [self endWorkChef3];
    [self endWorkChef4];
    [self endWorkChef5];
    [self endWorkChef6];
    
//    [self.gcdTimer99 destroy];
}

- (void)startAllPizzaQueue; {
    [self startWorkChef0];
    [self startWorkChef1];
    [self startWorkChef2];
    [self startWorkChef3];
    [self startWorkChef4];
    [self startWorkChef5];
    [self startWorkChef6];
}

//新增一些Pizza
- (void)addMorePizza:(NSUInteger)count;
{
    
    for (int i = 0; i < count; i++) {
        Pizza *pizza = [[Pizza alloc]initWithNumber:(i+_pizzaCount)];
        if (i % 7 == 0) {
            [self.array0 addObject:pizza];
        }
        else if (i % 7 == 1) {
            [self.array1 addObject:pizza];
        }
        else if (i % 7 == 2) {
            [self.array2 addObject:pizza];
        }
        else if (i % 7 == 3) {
            [self.array3 addObject:pizza];
        }
        else if (i % 7 == 4) {
            [self.array4 addObject:pizza];
        }
        else if (i % 7 == 5) {
            [self.array5 addObject:pizza];
        }
        else if (i % 7 == 6) {
            [self.array6 addObject:pizza];
        }
    }
    //更新pizza的总数量
    self.pizzaCount += count;
    [[NSUserDefaults standardUserDefaults]setInteger:self.pizzaCount forKey:@"pizza_count"];
    
    self.chef0.remainPizza = self.array0;
    self.chef1.remainPizza = self.array1;
    self.chef2.remainPizza = self.array2;
    self.chef3.remainPizza = self.array3;
    self.chef4.remainPizza = self.array4;
    self.chef5.remainPizza = self.array5;
    self.chef6.remainPizza = self.array6;
    
}

@end
