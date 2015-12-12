//
//  ViewController.m
//  MBProgressHUDTest
//
//  Created by chenyufeng on 15/12/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];



}


- (IBAction)buttonPressed:(id)sender {

  [MBProgressHUD showMessage:@"正在加载。。。"];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];


  //这里改成POST，就可以进行POST请求；
  //把要传递的参数直接放到URL中；而不是放到字典中；
  [manager GET:@"http://webservice.webxml.com.cn/WebServices/MobileCodeWS.asmx/getMobileCodeInfo?mobileCode=18888888888&userId="
    parameters:nil
       success:^(AFHTTPRequestOperation *operation,id responseObject){
         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"成功: %@", string);
         [MBProgressHUD hideHUD];
         [MBProgressHUD showSuccess:@"加载成功"];
       }
       failure:^(AFHTTPRequestOperation *operation,NSError *error){
         NSLog(@"失败: %@", error);

         [MBProgressHUD hideHUD];
         [MBProgressHUD showError:@"加载失败"];
       }];

}


@end
