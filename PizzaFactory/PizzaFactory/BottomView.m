//
//  BottomView.m
//  PizzaFactory
//
//  Created by ChenYuan's Macbook Pro on 2020/5/30.
//  Copyright © 2020 ChenYuan's Macbook. All rights reserved.
//

#import "BottomView.h"
#import "Toast.h"

@interface BottomView()

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;


@end

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:self options:nil].firstObject;
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
    self.view4.layer.borderColor = [UIColor blackColor].CGColor;
    self.view4.layer.borderWidth = 0.5;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)button1Clicked:(id)sender {
    [Toast makeToast:@"10 Pizza added!" duration:2.f position:CSToastPositionCenter];
    
    if (self.addPizzaBlock) {
        self.addPizzaBlock(10);
    }
}
- (IBAction)button2Clicked:(id)sender {
    [Toast makeToast:@"100 Pizza added!" duration:2.f position:CSToastPositionCenter];

    if (self.addPizzaBlock) {
        self.addPizzaBlock(100);
    }
}

- (IBAction)switchChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [Toast makeToast:@"Turn On All Pizza Queue!" duration:2.f position:CSToastPositionCenter];
    }else {
        [Toast makeToast:@"Turn Off All Pizza Queue!" duration:2.f position:CSToastPositionCenter];
    }
    
    if (self.switchBlock) {
        self.switchBlock(sender.isOn);
    }
}

- (void)updateSummaryLabelWithText:(NSString *)text; {
    self.label2.text = text;
}

@end
