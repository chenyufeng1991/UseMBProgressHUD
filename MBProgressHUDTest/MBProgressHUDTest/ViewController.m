//
//  ViewController.m
//  MBProgressHUDTest
//
//  Created by chenyufeng on 15/12/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

}

#pragma mark - 别人封装后的MBProgressHUD使用
- (IBAction)buttonPressed:(id)sender {

  //在一开始进行网络请求的时候，弹出MBProgressHUD；
  [MBProgressHUD showMessage:@"正在加载。。。"];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer             = [AFHTTPResponseSerializer serializer];
  //这里改成POST，就可以进行POST请求；
  //把要传递的参数直接放到URL中；而不是放到字典中；
  [manager GET:@"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx/getMobileCodeInfo?mobileCode=18888888888&userId="
    parameters:nil
       success:^(AFHTTPRequestOperation *operation,id responseObject){
         NSString *string                       = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"成功: %@", string);

         //网络请求成功，隐藏上述的“正在加载”的MBProgressHUD；
         [MBProgressHUD hideHUD];
         //同时弹出“加载成功”的提示；
         [MBProgressHUD showSuccess:@"加载成功"];

       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"失败: %@", error);

         //网络请求失败，隐藏上述的“正在加载”的MBProgressHUD；
         [MBProgressHUD hideHUD];
         //同时弹出“加载失败”的提示；
         [MBProgressHUD showError:@"加载失败"];

       }];

}


#pragma mark - 原生MBProgressHUD的使用

- (IBAction)sourceButtonPressed:(id)sender {


  //原生；
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
  hud.labelText = @"正在加载";

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer             = [AFHTTPResponseSerializer serializer];
  //这里改成POST，就可以进行POST请求；
  //把要传递的参数直接放到URL中；而不是放到字典中；
  [manager GET:@"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx/getMobileCodeInfo?mobileCode=18888888888&userId="
    parameters:nil
       success:^(AFHTTPRequestOperation *operation,id responseObject){
         NSString *string                       = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"成功: %@", string);


         hud.removeFromSuperViewOnHide = true;
         [hud hide:true afterDelay:0];

         //如果加载成功，则显示提示；
         MBProgressHUD *successHUD = [MBProgressHUD showHUDAddedTo:self.view animated:true];
         successHUD.labelText = @"加载成功";
         successHUD.mode = MBProgressHUDModeCustomView;
         successHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
         successHUD.removeFromSuperViewOnHide = true;
         [successHUD hide:true afterDelay:1];
       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"失败: %@", error);

         hud.removeFromSuperViewOnHide = true;
         [hud hide:true afterDelay:0];

         //如果加载成功，则显示提示；
         MBProgressHUD *failHUD = [MBProgressHUD showHUDAddedTo:self.view animated:true];
         failHUD.labelText = @"加载失败";
         failHUD.mode = MBProgressHUDModeCustomView;
         failHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
         failHUD.removeFromSuperViewOnHide = true;
         [failHUD hide:true afterDelay:1];
         
         
       }];
  
}

@end
