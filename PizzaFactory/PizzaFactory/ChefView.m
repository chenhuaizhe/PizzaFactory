//
//  ChefView.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "ChefView.h"
#import "Chef.h"
#import "Pizza.h"

@interface ChefView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UILabel *chefNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainPizzaLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ChefView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ChefView" owner:self options:nil].firstObject;
        self.frame = frame;
        [self initBorder];
        
    }
    return self;
}

- (void)initBorder {
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.view1.layer.borderColor = [UIColor blackColor].CGColor;
    self.view1.layer.borderWidth = 0.5;
    self.view2.layer.borderColor = [UIColor blackColor].CGColor;
    self.view2.layer.borderWidth = 0.5;
    self.view3.layer.borderColor = [UIColor blackColor].CGColor;
    self.view3.layer.borderWidth = 0.5;
}

- (void)setChef:(Chef *)chef {
    _chef = chef;
    
    self.iconView.image = [UIImage imageNamed:chef.iconName];
    self.chefNameLabel.text = chef.name;
    self.remainPizzaLabel.text = [NSString stringWithFormat:@"Remaining Piza:%ld",chef.remainPizza.count];
    self.speedLabel.text = [NSString stringWithFormat:@"Speed:%ld second per pizza",chef.speed];
    [self.tableView reloadData];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chef.remainPizza.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"chef_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
    }
    Pizza *pizza = self.chef.remainPizza[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"PIZZA_%ld",pizza.number];
    return cell;
}

#pragma mark - action 

- (IBAction)switchValueChanged:(UISwitch *)sender {
    if (self.switchBlock) {
        self.switchBlock(_chef.name, sender.isOn);
    }
}

- (void)turnOffSwitch {
    if (self.switch1.isOn) {
        self.switch1.on = NO;
    }
}

- (void)turnOnSwitch {
    if (!self.switch1.isOn) {
        self.switch1.on = YES;
    }
}

@end
