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

@property (nonatomic, strong) UITextField *goodsPrice;

@property (nonatomic, strong) UIView *photoBackgroundView;

@property (nonatomic, strong) PYPhotosView *publishPhotosView;

@property (nonatomic, strong) NSMutableArray *imagesM;

@property (nonatomic, strong) UIView *Bgview;

@property (nonatomic, strong) UINavigationBar *myBar;

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
    //创建搜索框
    /*
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
    searchBar.placeholder = @"搜索商品";
    
    searchBar.showsCancelButton = YES;
    
    searchBar.tintColor = [UIColor clearColor];
    */
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    //设置title
    navItem.titleView = titleLabel;
    
    
    //创建左侧按钮
    UIBarButtonItem *leftButton =[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    [leftButton setTintColor:[UIColor whiteColor]];
    [navItem setLeftBarButtonItem:leftButton];
    
    [navBar pushNavigationItem:navItem animated:NO];
    self.myBar = navBar;
    [self.view addSubview:self.myBar];
    

    
    
    //商品标题 图片 详情的背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, self.view.bounds.size.height-74)];
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
    _photoBackgroundView.frame = CGRectMake(20, 265, bgView.bounds.size.width, bgView.bounds.size.width);
    
    [bgView addSubview:_photoBackgroundView];
    
    //创建 一个发布图片时的photosView
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.py_x = 0;
    publishPhotosView.py_y = 0;
    publishPhotosView.photoWidth = 100;
    publishPhotosView.photoHeight = 100;
    publishPhotosView.photoMargin = 25;
    publishPhotosView.photosMaxCol = 3;
    publishPhotosView.imagesMaxCountWhenWillCompose = 3;
    publishPhotosView.images = self.imagesM;
    publishPhotosView.delegate = self;
    [_photoBackgroundView addSubview:publishPhotosView];
    self.publishPhotosView = publishPhotosView;
    
    //价格输入框背景
   // UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 100)];
    // bgView2.backgroundColor = [UIColor whiteColor];
    

    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(20, 390, bgView.bounds.size.width-40, 1)];
    lineView3.backgroundColor = myGraycolor;
    [bgView addSubview:lineView3];
    
    self.goodsPrice = [[UITextField alloc] initWithFrame: CGRectMake(20, 410, bgView.bounds.size.width-20, 30)];
    self.goodsPrice.placeholder = @"请输入商品价格";
    self.goodsPrice.font = [UIFont systemFontOfSize:15];
    self.goodsPrice.keyboardType = UIKeyboardTypeNumberPad;
    self.goodsPrice.tag = 1;
    self.goodsPrice.delegate = self;
    [bgView addSubview:self.goodsPrice];
    
    //中间的灰色区域
    UIView *bgview3 = [[UIView alloc] initWithFrame:CGRectMake(0, 455, bgView.bounds.size.width, 75)];
    bgview3.backgroundColor = myGraycolor;
    [bgView addSubview:bgview3];
    
    //确认下单按钮
    UIView *createView = [[UIView alloc] initWithFrame:CGRectMake(0,bgView.bounds.size.height-70, self.view.bounds.size.width, 60)];
    createView.backgroundColor = [UIColor whiteColor];
    
    UIButton *createBtn = [[UIButton alloc] initWithFrame:CGRectMake(75/2, 10, 300, 40)];
    createBtn.layer.cornerRadius =5;
    [createBtn setTitle:@"确认发布" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    createBtn.backgroundColor = [UIColor colorWithRed:59/255.0 green:89/255.0 blue:87/255.0 alpha:1];
    [createBtn addTarget:self action:@selector(createOrder) forControlEvents:UIControlEventTouchUpInside];
    [createView addSubview:createBtn];
    [bgView addSubview:createView];
    
  //  [self.view addSubview:bgView2];
    self.Bgview = bgView;
    [self.view addSubview:self.Bgview];
    
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
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id =[userdefaults objectForKey:@"id"];
    NSString *goodsName = [self.goodsName text];
    NSString *goodsInfo = [self.goodsInfo text];
    NSString *goodsPrice = [self.goodsPrice text];
    
    NSDictionary *dit = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"userId",goodsName,@"name",goodsInfo,"info",goodsPrice,"price",@"1",@"status", nil];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    
    
   
    [manager POST:@"http://119.23.230.116/xianyu/upLoadGoods"parameters:dit constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"有在上传吗");
        NSLog(@"打印照片数组%@",self.imagesM);
        for (int i = 0; i < self.imagesM.count; i++) {
            
            UIImage *image = self.imagesM[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@%d.jpg", dateString,i];
            NSLog(@"%@",fileName);
            
            /*此方法参数
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:imageData name:@"upload" fileName:fileName mimeType:@"image/jpeg"]; //  /jpg/png
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [SVProgressHUD showWithStatus:@"发布中..."];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        [SVProgressHUD showSuccessWithStatus:@"发布成功！"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [SVProgressHUD dismiss];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{   //开始编辑时，整体上移

    if ([textField isEqual:self.goodsPrice])
    {
        [self moveView:-216];
        
    }
    if ([textField isEqual:self.goodsInfo]) {
        [self moveView:-20];
    }
    if ([textField isEqual:self.goodsName]) {
        [self moveView:-20];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{     //结束编辑时，整体下移
   
    if ([textField isEqual:self.goodsPrice])
    {
        [self moveView:216];
    }
    if ([textField isEqual:self.goodsInfo]) {
        [self moveView:20];
    }
    if ([textField isEqual:self.goodsName]) {
        [self moveView:20];
    }
}
-(void)moveView:(float)move{
    NSTimeInterval animationDuration = 0.5f;
    CGRect frame = self.Bgview.frame;
    frame.origin.y +=move;//view的X轴上移
   
  //  self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [self.view addSubview:self.myBar];
    self.Bgview.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
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
