//
//  AddGoodsViewController.m
//  Secondary_Market
//
//  Created by Maktub on 25/5/18.
//  Copyright © 2018年 sagezhong. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "PYPhotoBrowser.h"
#import "PYPhotosView.h"
#import "PYPhotosPreviewController.h"
#import "TZImagePickerController.h"


#define myGraycolor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]

@interface AddGoodsViewController ()<UITextFieldDelegate,PYPhotosViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UITextField *goodsName;

@property (nonatomic, strong) UITextField *goodsInfo;

@property (nonatomic, strong) UIView *photoBackgroundView;

@property (nonatomic, strong) PYPhotosView *publishPhotosView;

@property (nonatomic, strong) NSMutableArray *imagesM;

@end

@implementation AddGoodsViewController

//图片懒加载

- (NSMutableArray *)imagesM{
    if (_imagesM == nil) {
        _imagesM = [NSMutableArray array];
    }
    if (_imagesM.count > 3) {
        [_imagesM removeObjectAtIndex:0];
    }
    return _imagesM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navBar.barTintColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    //自定义导航栏的title，用UILabel实现
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"发布商品";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    //自定义导航栏组件
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    //设置title
    navItem.titleView = titleLabel;
    
    
    //创建左侧按钮
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [navItem setLeftBarButtonItem:leftButton];
    
    [navBar pushNavigationItem:navItem animated:NO];
    [self.view addSubview:navBar];
    
    //确认下单按钮
    UIView *createView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-60, self.view.bounds.size.width, 60)];
    createView.backgroundColor = [UIColor whiteColor];
    
    UIButton *createBtn = [[UIButton alloc] initWithFrame:CGRectMake(75/2, 10, 300, 40)];
    createBtn.layer.cornerRadius =5;
    [createBtn setTitle:@"确认发布" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    createBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    [createBtn addTarget:self action:@selector(createOrder) forControlEvents:UIControlEventTouchUpInside];
    [createView addSubview:createBtn];
    [self.view addSubview:createView];
    
    
    //商品标题 图片 详情的背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, self.view.bounds.size.width, 380)];
    bgView.backgroundColor = [UIColor whiteColor];
    // 商品标题
    self.goodsName = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width-20, 30)];
    self.goodsName.placeholder = @"请输入商品的标题";
    self.goodsName.font = [UIFont systemFontOfSize:15];
    self.goodsName.returnKeyType = UIReturnKeyDone;
    self.goodsName.delegate = self;
    
    [bgView addSubview:self.goodsName];
    //灰线条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 35, bgView.bounds.size.width-40, 1)];
    lineView.backgroundColor = myGraycolor;
    [bgView addSubview:lineView];
    
    //商品详情
    self.goodsInfo = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, bgView.bounds.size.width-40, 100)];
    self.goodsInfo.placeholder = @"请输入商品详情";
    self.goodsInfo.font = [UIFont systemFontOfSize:15];
    self.goodsInfo.returnKeyType = UIReturnKeyDone;
    self.goodsInfo.delegate = self;
    self.goodsInfo.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [bgView addSubview:self.goodsInfo];
    
    //灰线条
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 230, bgView.bounds.size.width-40, 1)];
    lineView2.backgroundColor = myGraycolor;
    [bgView addSubview:lineView2];
    //图片
    _photoBackgroundView = [[UIView alloc] init];
    _photoBackgroundView.frame = CGRectMake(15, 265, bgView.bounds.size.width, bgView.bounds.size.width);
    
    [bgView addSubview:_photoBackgroundView];
    
    //创建 一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.py_x = 0;
    publishPhotosView.py_y = 0;
    publishPhotosView.photoWidth = 110;
    publishPhotosView.photoHeight = 110;
    publishPhotosView.photoMargin = 20;
    publishPhotosView.photosMaxCol = 3;
    publishPhotosView.imagesMaxCountWhenWillCompose = 3;
    publishPhotosView.images = self.imagesM;
    publishPhotosView.delegate = self;
    [_photoBackgroundView addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    
    
    
    
    [self.view addSubview:bgView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)click {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确认下单
- (void)createOrder {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 //   textField = self.goodsTitle;
    [self.goodsInfo resignFirstResponder];
    [self.goodsName resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - PYPhotosViewDelegate

- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (int i = 0; i < photos.count; i++) {
            [self.imagesM addObject:photos[i]];
        }
        //刷新
        
        [photosView reloadDataWithImages:self.imagesM];
    }];
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr
{
    
}


@end
