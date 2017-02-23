//
//  ViewController.m
//  MasonryDemo
//
//  Created by  czk on 17/2/21.
//  Copyright © 2017年 fanxc. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *btnArrs;
@property (nonatomic, strong) MASConstraint *animatableConstraint;

@property (nonatomic, strong) UIButton *greenBtn;
@property (nonatomic, strong) UIButton *purpleBtn;

@property (nonatomic, strong) UILabel *testLbl;
@property (nonatomic, assign) BOOL isTestLblTesting;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *alongAxisArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *greenBtn = UIButton.new;
    greenBtn.backgroundColor = UIColor.greenColor;
    greenBtn.layer.borderColor = UIColor.blackColor.CGColor;
    greenBtn.layer.borderWidth = 2.f;
    [greenBtn addTarget:self action:@selector(greenBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:greenBtn];
    self.greenBtn = greenBtn;
    
    
    UIButton *purpleBtn = UIButton.new;
    purpleBtn.backgroundColor = UIColor.purpleColor;
    purpleBtn.layer.borderColor = UIColor.blackColor.CGColor;
    purpleBtn.layer.borderWidth = 2.f;
    [self.view addSubview:purpleBtn];
    self.purpleBtn = purpleBtn;
    
    UILabel *testLbl = UILabel.new;
    testLbl.backgroundColor = UIColor.orangeColor;
    testLbl.layer.borderColor = UIColor.blackColor.CGColor;
    testLbl.layer.borderWidth = 2.f;
    testLbl.text = @"予观夫巴陵胜状，在洞庭一湖。衔远山，吞长江，浩浩汤汤，横无际涯；朝晖夕阴，气象万千。此则岳阳楼之大观也，前人之述备矣。然则北通巫峡，南极潇湘，迁客骚人，多会于此，览物之情，得无异乎?";
    testLbl.numberOfLines = 0;
    [self.view addSubview:testLbl];
    self.testLbl = testLbl;
    
    
    UIScrollView *scrollview = UIScrollView.new;
    scrollview.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:scrollview];
    self.scrollview = scrollview;
    
    UILabel *contentView = UILabel.new;
    contentView.backgroundColor = [UIColor yellowColor];
    contentView.text = @"请往上滑动！注意看纵向滑动条";
    contentView.textAlignment = NSTextAlignmentCenter;
    [self.scrollview addSubview:contentView];
    self.contentView = contentView;
}


// 9
- (void)greenBtnAction
{
    NSLog(@"%s",__func__);
    
    
    //    CGFloat padding = 100;
    //    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    //    self.animatableConstraint.insets = paddingInsets;
    //
    //    [UIView animateWithDuration:1.0 animations:^{
    //        [self.view layoutIfNeeded];
    //    }];
}

#pragma mark- updateViewConstraints
- (void)updateViewConstraints
{
    [self Constraint13_3];
    
    [super updateViewConstraints];
}


#pragma mark- some test
- (void)Constraint1
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(30, 30, 30, 30));
    }];

}

- (void)Constraint2
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self.view);
        
    }];
}

- (void)Constraint3
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.mas_equalTo(100);
    }];
}

- (void)Constraint4567
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    [self.purpleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    
    self.btnArrs = @[self.greenBtn, self.purpleBtn];
    
        // 4, pch中加了全局宏定义 #define MAS_SHORTHAND, 可以在调用masonry方法的时候不使用mas_前缀
    //    [self.btnArrs mas_updateConstraints:^(MASConstraintMaker *make) {
    [self.btnArrs updateConstraints:^(MASConstraintMaker *make) {
        
        // 5, ??????
        //        make.baseline.equalTo(self.view.mas_centerY).with.offset(-100);
        
        // 6，错误写法
        //        make.center.equalTo(self.view.center);
        
        // 7,下面四个写法等同
        // <1>
        //        make.center.mas_equalTo(self.view);
        
        // <2>
        //        make.center.equalTo(self.view);
        
        // <3>
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        
        // <4>
        //        make.centerX.mas_equalTo(self.view.mas_centerX);
        //        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];

}

- (void)Constraint8
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self.view);

    }];
    
    
     [self.purpleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
     
     // 8, multipliedBy
     //        make.width.equalTo(purpleBtn.mas_height).multipliedBy(3);// 宽高比1.0/3.0
     make.width.equalTo(self.purpleBtn.mas_height).dividedBy(3);// 宽高比3.0/1.0
     
     make.width.and.height.lessThanOrEqualTo(self.greenBtn);
     make.width.and.height.equalTo(self.greenBtn).with.priorityLow();
     make.center.equalTo(self.greenBtn);
     }];
}


/**
 9,  动态修改视图约束
 */
- (void)Constraint9
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat padding = 0;
        UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
        //        self.animatableConstraint = make.edges.equalTo(self.view).insets(paddingInsets).priorityLow();
        self.animatableConstraint = make.edges.equalTo(self.view).insets(paddingInsets);

    }];
}


/**
  10, debug
 */
- (void)Constraint10
{
    [self.greenBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        CGFloat padding = 0;
        UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
        make.edges.equalTo(self.view).insets(paddingInsets);
        make.width.equalTo(@200).key(@"greenBtn__ConstantConstraint");
    }];
}

/**
 11, preferredMaxLayoutWidth: 多行label的约束问题
 */
- (void)Constraint11
{
    self.isTestLblTesting = YES;
    
    [self.testLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 200));
//        make.center.mas_equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(300);
        make.height.equalTo(200);
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    
    if (self.isTestLblTesting) {
        self.testLbl.preferredMaxLayoutWidth = self.view.frame.size.width-100;
        [self.testLbl layoutIfNeeded];
    }
}

/**
 12, preferredMaxLayoutWidth: 多行label的约束问题
 */
- (void)Constraint12
{
    [self.scrollview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(self.scrollview);
        make.height.equalTo(1000);
    }];
}


- (void)Constraint13_1
{
    self.alongAxisArray = @[self.greenBtn, self.purpleBtn, self.testLbl, self.scrollview];
    
    [self.alongAxisArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
    [self.alongAxisArray makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.height.equalTo(@60);
    }];
}

- (void)Constraint13_2
{
    self.alongAxisArray = @[self.greenBtn, self.purpleBtn, self.testLbl, self.scrollview];
    
    [self.alongAxisArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:200 leadSpacing:5 tailSpacing:5];
    [self.alongAxisArray makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.width.equalTo(@60);
    }];
}


- (void)Constraint13_3
{
    self.alongAxisArray = @[self.greenBtn, self.purpleBtn, self.testLbl, self.scrollview];
    
    [self.alongAxisArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:200 leadSpacing:5 tailSpacing:5];
    [self.alongAxisArray makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.width.equalTo(@60);
    }];
}


- (void)Constraint13_4
{
    self.alongAxisArray = @[self.greenBtn, self.purpleBtn, self.testLbl, self.scrollview];
    
    [self.alongAxisArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
    [self.alongAxisArray makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.height.equalTo(@60);
    }];
}


@end
