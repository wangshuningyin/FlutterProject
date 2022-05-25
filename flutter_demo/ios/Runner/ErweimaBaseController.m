

//
//  ErweimaBaseController.m
//  CarOwner
//
//  Created by LELE on 2019/9/11.
//  Copyright © 2019 rect. All rights reserved.
//

#import "ErweimaBaseController.h"
#import "UIView+Extension.h"
@interface ErweimaBaseController ()

@end

@implementation ErweimaBaseController
-(COButton *)backItem{
    if(_backItem == nil){
        _backItem = [[COButton alloc] init];
        _backItem.yl_size = CGSizeMake(50, 50);
        _backItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_backItem setImage:[UIImage imageNamed:@"left_back_white.png"] forState:UIControlStateNormal];
        __weak ErweimaBaseController* weakSelf = self;
        _backItem.actionBlock = ^(UIButton *sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _backItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self buildUI];
}

-(void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
}

-(void)buildUI{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
