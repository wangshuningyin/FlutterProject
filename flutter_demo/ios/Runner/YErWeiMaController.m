//
//  YErWeiMaController.m
//  Anyo
//
//  Created by LELE on 16/12/27.
//  Copyright © 2016年 rect. All rights reserved.
//

#import "YErWeiMaController.h"
#import <AVFoundation/AVFoundation.h>
#import "MidView.h"
#import "YOpenBtn.h"
#import "COInputView.h"
#import "UIImage+colorImage.h"
#import "UIView+Extension.h"

#define kTimeDuration 3
#define kLblBodyTitleFont  [UIFont boldSystemFontOfSize:35]
#define kYLColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kYLColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

typedef enum{
    YErWeiMaControllerScanType_Scan,
    YErWeiMaControllerScanType_Input
}YErWeiMaControllerScanType;
@interface YErWeiMaController ()<AVCaptureMetadataOutputObjectsDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_scanLine;
    UIImageView *_scanBox;
    NSTimer *_scanTimer;

}

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;
//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property(nonatomic,weak)UIImageView* inputImg;
@property(nonatomic,copy) NSString* scanResult;// 扫描结果
@property(nonatomic,weak) UIView* bgView; // 底部的背景色
@property(nonatomic,weak) UILabel* promptLabel; // 提示文字
@property(nonatomic,weak) UIButton* backButton;
@property(nonatomic,weak) UIView* midView;
@property(nonatomic,weak) UILabel* helpLbl;
@property(nonatomic,weak) UIView* inputView;
@property(nonatomic,weak) UITextField* textF;
@property(nonatomic,weak) UIButton* inputBtn;
@property(nonatomic,weak) UILabel* statuLbl;
@property(nonatomic,assign) BOOL isMoveScanLine;
@property(nonatomic,assign)YErWeiMaControllerScanType scanType;
@property(nonatomic,weak)UIButton* helpBtn;
@property(nonatomic,weak)YOpenBtn* openBtn;
@property(nonatomic,weak)UIView* inputTopView;
@property(nonatomic,weak)UITableView* resultTabView;
@property(nonatomic,weak)UILabel* resultLbl;
@property(nonatomic,copy)NSString* searchText;
@property(nonatomic,copy)NSString* previousKey;
@property(nonatomic,strong)NSArray* allSearchNearDeviceNumbers; // 所有的搜索结果

@property(nonatomic,assign)BOOL isOpenLocalAuth;  // 是否打开用户权限
@property(nonatomic,assign)BOOL isGetUserLocationSuccess; // 获取用户位置是否成功
@property(nonatomic,strong)NSMutableArray* searchNearDeviceNumbers;

/*!
 *  网络状态
 */
@property(nonatomic,copy)NSString* netWorkStatus;
@property(nonatomic,strong)NSMutableDictionary* scanParams;
@property(nonatomic,assign)BOOL nearChargeNumCellClickEnable;
@property(nonatomic,strong)UIButton* leftBackItem;

@property(nonatomic,strong)UILabel *networkErrorLbl;

@end

@implementation YErWeiMaController

-(UIButton *)leftBackItem{
    if(_leftBackItem == nil){
        _leftBackItem = [self buildLeftItem];
    }
    return _leftBackItem;
}

- (UIButton *)buildLeftItem{
    UIButton * leftBackItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 40)];
    [leftBackItem setImage:[UIImage imageNamed:@"left_back_white.png"] forState:UIControlStateNormal];
    leftBackItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBackItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    return leftBackItem;
}

//- (UILabel *)networkErrorLbl{
//    if (_networkErrorLbl == nil){
//        _networkErrorLbl = [[UILabel alloc] init];
//        ff
//    }
//    return _networkErrorLbl;
//}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSMutableArray *)searchNearDeviceNumbers
{
    if (_searchNearDeviceNumbers == nil) {
        _searchNearDeviceNumbers = [NSMutableArray array];
    }
    return _searchNearDeviceNumbers;
}

-(NSMutableDictionary *)scanParams
{
    if (_scanParams == nil) {
        _scanParams = [NSMutableDictionary dictionary];
    }
    return _scanParams;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nearChargeNumCellClickEnable = YES;
    self.view.backgroundColor = kYLColor(55, 64, 84);
    self.scanType = YErWeiMaControllerScanType_Scan;
    [self setUpNav];
    [self buildErweimaUI];
}

-(void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBackItem];
}

#pragma mark -- 地图定位的代理方法

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
        if (phoneVersion.floatValue < 10.0) {
            //iOS10 以前使用
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        else {
            //iOS10 以后使用
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }
}

-(void)addKeyBoardNotification
{
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void) keyboardDidChangeFrameNotification:(NSNotification*) notification
{
    CGRect rect= [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue ];
    CGFloat offset=rect.origin.y - self.view.bounds.size.height + 44;
    if (offset > 0) offset = 0;
    self.view.transform=CGAffineTransformMakeTranslation(0, offset );
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (@available(iOS 15.0, *)) {
        self.navigationController.navigationBar.hidden = YES;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];


    if (_captureSession != nil) {
        [_captureSession startRunning];
        [_scanTimer fire];

        if (self.scanType == YErWeiMaControllerScanType_Input) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.textF becomeFirstResponder];
            });
        }
    }
    else
    {
        NSLog(@"初始化摄像头失败");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 }



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (@available(iOS 15.0, *)) {
        self.navigationController.navigationBar.hidden = NO;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        // distantFuture 关闭
        [_scanTimer setFireDate:[NSDate distantFuture]];
    if (_captureSession != nil) {
        [_captureSession stopRunning];
    }
    
    if (self.scanType == YErWeiMaControllerScanType_Input) {
        [self.textF resignFirstResponder];
    }
}


-(void)buildErweimaUI
{
    [self startScan];
    [self showFlag];
}

-(void)hid
{
    self.statuLbl.hidden = NO;
    [_captureSession  stopRunning];
    [_scanTimer setFireDate:[NSDate distantFuture]];
}

-(void)show
{
    self.statuLbl.hidden = YES;
    [_captureSession  startRunning];
    [_scanTimer setFireDate:[NSDate distantPast]];
}

-(void)showFlag
{

}

-(void)inputprivitePieClick
{

}

// 当前输入按钮的点击
-(void)inputBtnClick:(UIButton*)sender
{
    NSLog(@"图片识别点击");
}

-(void)startScan
{
    CGFloat scanBoxY = 167;
    CGFloat scanBoxX = 40;
    CGFloat scanBoxW = 200;
    CGFloat scanBoxH = 96;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"TerraConfig wants to visit your camera" message:@"TerraConfig wants to visit your camera to scan a QR Code and take a photo" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Set",nil];
        [alert show];
//        return;
        //无权限
    }else{
        NSLog(@"打开相机的访问权限");
        
        NSError *error;
          //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
          AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
          //2.用captureDevice创建输入流
          AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
          if (!input) {
              NSLog(@"%@", [error localizedDescription]);
              return ;
          }
          //3.创建媒体数据输出流
          AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
          
          //4.实例化捕捉会话
          _captureSession = [[AVCaptureSession alloc] init];
          [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
          //4.1.将输入流添加到会话
          if ([_captureSession canAddInput:input]) {
              [_captureSession addInput:input];
          }
          //4.2.将媒体输出流添加到会话中
          if([_captureSession canAddOutput:captureMetadataOutput]){
              [_captureSession addOutput:captureMetadataOutput];
          }
          
          //5.2.设置输出媒体数据类型为QRCode
          captureMetadataOutput.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeFace,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code];

          //5.创建串行队列，并加媒体输出流添加到队列当中
          dispatch_queue_t dispatchQueue;
          dispatchQueue = dispatch_queue_create("ErWeiMa", NULL);
          [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];

          //5.1.设置代理

          //6.实例化预览图层
          _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
          //7.设置预览图层填充方式
          [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
          //8.设置图层的frame
          [_videoPreviewLayer setFrame:self.view.bounds];
          //9.将图层添加到预览view的图层上
          [self.view.layer addSublayer:_videoPreviewLayer];
          //10.设置扫描范围
          captureMetadataOutput.rectOfInterest =  CGRectMake ( scanBoxY / 600 ,scanBoxX/ 320 , scanBoxH / 600 , scanBoxW / 320 );
    }

    
    // 10.3 提示文字
    UILabel* promptLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, scanBoxY + scanBoxH + 30, 320, 44)];
    promptLabel.yl_centerX = 330 * 0.5;
    promptLabel.numberOfLines = 0;
    promptLabel.text= @"Please put the barcode within frame to scan";
    promptLabel.font= [UIFont systemFontOfSize:14];
    promptLabel.textColor= kYLColorRGBA(255, 255, 255, 0.6);
    promptLabel.textAlignment=NSTextAlignmentCenter;
    
    // 设置背景色
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = kYLColorRGBA(0, 0, 0, 0.5);
    [self.view addSubview:bgView];
    bgView.hidden = YES;
    self.bgView = bgView;
    
    //10.1.扫描框
    MidView *midView = [[MidView alloc]initWithViewFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width) insertFrame:CGRectMake( scanBoxX,scanBoxY , scanBoxW, scanBoxH)];
    midView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:midView];
    self.midView = midView;
    
    
    //扫描框图案
    _scanBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"abb_scan_box.png"]];
    _scanBox.frame = CGRectMake( scanBoxX,scanBoxY, scanBoxW, scanBoxH);
    [self.view addSubview:_scanBox];
    
    
    //10.2.扫描线
//    _scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanline"]];
//    _scanLine.frame = CGRectMake(0, 0, _scanBox.frame.size.width, autoScaleH(3));
//    [_scanBox addSubview:_scanLine];
//    _scanTimer= [NSTimer scheduledTimerWithTimeInterval:kTimeDuration target:self selector:@selector(moveScanLine) userInfo:nil repeats:YES];
    [self.view addSubview:promptLabel];
    
    // 添加电灯
    COButton* lightItem = [[COButton alloc] init];
    lightItem.yl_width = 60;
    lightItem.yl_height = 60;
    lightItem.yl_centerX = 320 * 0.5;
    lightItem.yl_y = promptLabel.yl_bottom + 50;
    [self.view addSubview:lightItem];
    lightItem.tag = 1;
    [lightItem setImage:[UIImage imageNamed:@"light_open.png"] forState:UIControlStateSelected];
    [lightItem setImage:[UIImage imageNamed:@"light_close.png"] forState:UIControlStateNormal];
    lightItem.actionBlock = ^(UIButton *sender) {
        [self itemAction:sender];
    };
    
    // 添加底部手动输入和扫码帮助
    UIView* itemView = [[UIView alloc] init];
    itemView.yl_bottom = 667 - 64 - 20;
    itemView.yl_width = 320;
    itemView.yl_height =40;
    [self.view addSubview:itemView];
//    [self buildItemView:itemView];

    // 添加无网络提示
    UILabel* networkLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _scanBox.yl_width, _scanBox.yl_height)];
    networkLbl.text = @"当前网络不可用";
    networkLbl.textAlignment = NSTextAlignmentCenter;
    networkLbl.font = [UIFont systemFontOfSize:16];
    networkLbl.textColor = [UIColor whiteColor];
    networkLbl.backgroundColor = kYLColorRGBA(0, 0, 0, 0.5);
    [_scanBox addSubview:networkLbl];
    networkLbl.hidden = YES;
    self.statuLbl = networkLbl;
    
    if (@available(iOS 15.0, *)) {
        UIButton *backItem = [self buildLeftItem];
        [self.view addSubview:backItem];
        backItem.yl_y = 20;
        backItem.yl_x = 20;
    }
}

//-(void)buildItemView:(UIView*)itemView{
//    ABBUnderLineItem* helpItem = [[ABBUnderLineItem alloc] initWithTitle:FGGetStringWithKeyFromAutoTable(@"Scan Problem?") font:kTitleFont_15pt isUnderLine:NO action:^{
//        YLog(@"scan help");
//    }];
//    [itemView addSubview:helpItem];
//
//    ABBUnderLineItem* inputItem = [[ABBUnderLineItem alloc] initWithTitle:FGGetStringWithKeyFromAutoTable(@"Input SN manually") font:kTitleFont_15pt isUnderLine:YES action:^{
////        ABBInputController* inputVc = [[ABBInputController alloc] init];
////        [self.navigationController pushViewController:inputVc animated:NO];
//    }];
//    [itemView addSubview:inputItem];
//
//    inputItem.yl_bottom = itemView.yl_height;
//    inputItem.yl_centerX = itemView.yl_width * 0.5;
//    helpItem.yl_bottom = inputItem.yl_y;
//    helpItem.yl_centerX = inputItem.yl_centerX;
////    itemView.yl_width = helpItem.yl_width + inputItem.yl_width + autoScaleW(3);
//    itemView.yl_centerX = kScreenWidth * 0.5;
//}

-(void)addToolView{
    UIView* toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    toolView.backgroundColor = [UIColor redColor];
    toolView.yl_bottom = 667 - 100;
    [self.view addSubview:toolView];
    [self buildToolView:toolView];
}

-(void)buildToolView:(UIView*)toolView{
    CGFloat itemW = toolView.yl_width * 0.5;
    CGFloat itemH = toolView.yl_height;
    NSArray* titles = @[@"输入桩号",@"开启电筒"];
    NSArray* icons = @[@"charge_device_num.png",@"charge_elec_light.png"];
    NSArray* selectedIcons = @[@"charge_elec_light_selected.png",@"charge_elec_light_selected.png"];
    for (int i = 0; i < titles.count; i++) {
        YOpenBtn* item = [[YOpenBtn alloc] initWithFrame:CGRectMake(i * itemW, 0, itemW, itemH)];
        item.tag = i;
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:selectedIcons[i]] forState:UIControlStateSelected];
        [toolView addSubview:item];
        item.actionBlock = ^(UIButton *sender) {
            [self itemAction:sender];
        };
    }
}

-(void)itemAction:(UIButton*)sender{
    if(sender.tag == 0){
//        [self buildInputView];
//        ABBInputController* inputVc = [[ABBInputController alloc] init];
//        [self.navigationController pushViewController:inputVc animated:YES];
    } else {
        [self openBtnClick:sender];
    }
}

-(void)buildInputView{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    UIView* cover = [[UIView alloc] initWithFrame:window.bounds];
    cover.backgroundColor = kYLColorRGBA(0, 0, 0, 0.6);
    [window addSubview:cover];

    COInputView* inputView = [[COInputView alloc] init];
    inputView.yl_centerX = cover.yl_width * 0.5;
    [cover addSubview:inputView];
    inputView.yl_bottom = 0;
    [self showInputView:inputView];
    
    __weak COInputView* weakInputView = inputView;
    inputView.closeHandle = ^{
        [self hidInputView:weakInputView];
    };
    
    inputView.textChangedhandle = ^(UITextField *textF) {
        NSLog(@"%@",textF.text);
        if (textF.text.length == 6) {
//            [YMessageHUD showHUDWithIcon:nil msg:@"未能匹配充电桩"];
            [self hidInputView:weakInputView];
        }
    };
}

-(void)showInputView:(UIView*)inputView{
    // 暂停定时器
    [_scanTimer setFireDate:[NSDate distantFuture]];
    if (_captureSession != nil) {
        [_captureSession stopRunning];
    }

    [UIView animateWithDuration:0.5 animations:^{
        inputView.yl_y = 124;
        [inputView becomeFirstResponder];
    }];
}

-(void)hidInputView:(UIView*)inputView{
    [inputView resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        inputView.yl_y = 667;
    } completion:^(BOOL finished) {
        [inputView.superview removeFromSuperview];
    }];
    
    // 开启定时器
    [_scanTimer setFireDate:[NSDate distantPast]];
    if (_captureSession != nil) {
        [_captureSession startRunning];
    }
}


-(void)buildInputView:(UIView*)inputView
{
    UIView* inputTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 + 20, 320, 160)];
    inputTopView.backgroundColor = [UIColor clearColor];
    [inputView addSubview:inputTopView];
    [self buildInputTopView:inputTopView];
    self.inputTopView = inputTopView;
    
    UITableView* resultTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, inputTopView.yl_bottom, 320, inputView.yl_height - inputTopView.yl_height - 50 - 20) style:UITableViewStyleGrouped];
    resultTabView.delegate = self;
    resultTabView.dataSource = self;
    if (@available(iOS 15.0, *)) {
        resultTabView.sectionHeaderTopPadding = 0;
    }
    resultTabView.backgroundColor = kYLColorRGBA(52, 58, 72,1.0);
    resultTabView.separatorColor = kYLColorRGBA(62, 69, 83,1.0);
    resultTabView.rowHeight = 46;
    [inputView addSubview:resultTabView];
    self.resultTabView = resultTabView;
}

-(void)buildInputTopView:(UIView*)inputTopView
{
    CGFloat leftMargin = 20;
    UILabel* titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, inputTopView.yl_width - 40, 20)];
    titleLbl.text = @"请您输入桩号后六位";//@"";
    titleLbl.font = [UIFont systemFontOfSize:18];
    titleLbl.textColor = kYLColorRGBA(255, 255, 255, 0.8);
    titleLbl.backgroundColor = [UIColor clearColor];
    [inputTopView addSubview:titleLbl];
    
    UILabel* desTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(titleLbl.yl_left, titleLbl.yl_bottom + 5, titleLbl.yl_width, 25)];
    desTitleLbl.text = @"如有尾号相同的桩号，请您校对前面的桩号";
    desTitleLbl.textColor = kYLColorRGBA(255, 255, 255, 0.5);
    desTitleLbl.numberOfLines = 0;
    desTitleLbl.backgroundColor = [UIColor clearColor];
    desTitleLbl.font = [UIFont systemFontOfSize:10];
    [inputTopView addSubview:desTitleLbl];
    
    UILabel* resultLbl = [[UILabel alloc] initWithFrame:CGRectMake(titleLbl.yl_left, 100, titleLbl.yl_width, 11)];
    resultLbl.text = @"匹配结果";//@"";
    resultLbl.font = [UIFont systemFontOfSize:10];
    resultLbl.hidden = YES;
    resultLbl.textColor = [UIColor whiteColor];
    [inputTopView addSubview:resultLbl];
    self.resultLbl = resultLbl;
}

-(void)TXViewClick
{
//    [self.inputTradeView.TF becomeFirstResponder];
}


#pragma mark ---- UITabViewDelegate, UITabViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.resultLbl.hidden = !self.searchNearDeviceNumbers.count;
    return self.searchNearDeviceNumbers.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifire = @"identifire";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = kYLColorRGBA(255, 255, 255, 0.9);
//    YSearchDeviceModel* model = self.searchNearDeviceNumbers[indexPath.row];
    cell.textLabel.text = @"111";//model.deviceNum;
    self.searchText = self.searchText == nil ? @"" : self.searchText;
    if (self.searchText.length > 0) {
        cell.textLabel.attributedText = [self getAttributedStringWithStr:cell.textLabel.text  keyStr:self.searchText];
    }
    return cell;
}

-(NSAttributedString*)getAttributedStringWithStr:(NSString*)str keyStr:(NSString*)keyStr
{
    NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] init];
    NSString* str1 = [str substringToIndex:str.length - 6];
    NSString* str2 = [str substringFromIndex:str.length - 6];
    
    NSMutableAttributedString* attStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSMutableAttributedString* attStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
    
    if ([str2 containsString:keyStr]) {
        NSRange range = [str2 rangeOfString:keyStr];
        [attStr2 addAttributes:@{NSForegroundColorAttributeName : kYLColor(59, 187, 124)} range:range];
    }
    
    [attStr appendAttributedString:attStr1];
    [attStr appendAttributedString:attStr2];
    return attStr;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    if(self.nearChargeNumCellClickEnable){
        self.nearChargeNumCellClickEnable = NO;
    }
}

#pragma mark -- TXTradePasswordViewDelegate

-(NSMutableArray*)filterDeviceModelWithKey:(NSString*)key
{
    NSMutableArray* arrM = [NSMutableArray array];
    NSArray* targetArr = self.searchNearDeviceNumbers;
    if (self.previousKey) {
        if (self.previousKey.length > key.length) {
            targetArr = self.allSearchNearDeviceNumbers;
        }
    }
    self.previousKey = key;
    return arrM;
}

-(void)openBtnClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    [self turnTorchOn:sender.selected];
}

-(void)turnTorchOn: (bool) on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }else{
            NSLog(@"初始化失败");
        }
    }else{
        NSLog(@"没有闪光设备");
    }
}

-(void)ErweiMaHelpBtnClick{}
#pragma mark -- 获取电桩的信息，判断此桩是否在服务器上
-(void)getDeviceInfoWith:(NSString*)scanResult
{

}

-(void)operationScan
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_scanTimer setFireDate:[NSDate distantPast]];
        [_captureSession startRunning];
    });
}

-(void)stopScan
{
    [_scanTimer setFireDate:[NSDate distantFuture]];
    [_captureSession stopRunning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        NSLog(@"%@",textField.text);
        if (textField.text.length < 1){

        }else{
            [self getDeviceInfoWith:textField.text];
        }
    }
    return YES;
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        //判断回传的数据类型
        AVMetadataObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]){
            AVMetadataMachineReadableCodeObject *metadataReadableCodeObject = (AVMetadataMachineReadableCodeObject *)metadataObject;
            NSString *stringValue = metadataReadableCodeObject.stringValue ;
            NSLog(@"---%@",stringValue);
            self.scanResult=stringValue;
            [self stopScan];
            [self requestDeviceInfoWithDeviceNumber:self.scanResult];
        }
    }
}

/**
 * 获取扫码的设备信息
 */
- (void)requestDeviceInfoWithDeviceNumber:(NSString *)deviceNumber{
//    if ([ABBNetworkTool shareNetworkTool].networkType == ABBNetworkTypeUnavailable) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [NBMessageHUD showHUDWithMsg:FGGetStringWithKeyFromAutoTable(ABBNetWorkDisconnected) showInView:self.view];
//        });
        [self operationScan];
//        return;
//    }
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"deviceNumber"] = deviceNumber;
//    [YInstallRequest loadDeviceInfoWithParams:params success:^(NSArray<ABBBindDeviceModel *> *deviceList) {
//        ABBBindDeviceModel *deviceModel = (ABBBindDeviceModel *)deviceList.firstObject;
//        NBPackageLoadController *packageLoadVc = [[NBPackageLoadController alloc] init];
//        packageLoadVc.deviceNumber = deviceModel.deviceNumber;
//        packageLoadVc.packageCode = deviceModel.hardwareModel;
//        [self.navigationController pushViewController:packageLoadVc animated:YES];
//    } failure:^(NSError *error) {
//        [self operationScan];
//        [NBMessageHUD showHUDWithMsg:error.domain showInView:self.view];
//    }];
}

-(void)filterScanResultWithScanResult:(NSString*)scanResult
{
    [_captureSession stopRunning];
    [_scanTimer setFireDate:[NSDate distantFuture]];
    self.scanParams[@"scan_content"] = scanResult;
}

-(void)moveScanLine
{
    __block CGRect frame = _scanLine.frame;
    if (frame.origin.y == 0) {
        [UIView animateWithDuration:kTimeDuration animations:^{
            frame.origin.y = _scanBox.frame.size.height - frame.size.height;
            _scanLine.frame = frame;
        }];
    } else if (frame.origin.y == _scanBox.frame.size.height - frame.size.height)
    {
        if (self.isMoveScanLine) {
            [UIView animateWithDuration:kTimeDuration animations:^{
                frame.origin.y = 0;
                _scanLine.frame = frame;
            }];
        }else{
            self.isMoveScanLine = YES;
        }
    }
}
@end
