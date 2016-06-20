//
//  DownLoadFile.m
//  02-NSoperationDemo
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "DownLoadFile.h"

@interface DownLoadFile ()
@property(nonatomic,strong)NSURL *Kurl;

@end

@implementation DownLoadFile
-(instancetype)initWithDownUrl:(NSString *)url{
    if (self=[super init]) {
        _Kurl=[NSURL URLWithString:url];
        
        
        
    }
    return self;
}


- (void)main{
//该方法会调用一次,在该对象丢到队列里的时候调用
    NSLog(@"=====%s",__func__);
    [self downLoadImage];
}
//下载图片
-(void)downLoadImage{
  //1.进行网络请求
    NSData *data=[NSData dataWithContentsOfURL:_Kurl];
  //2.data====>uiimage
    UIImage *image=[UIImage imageWithData:data];
  //3.回调到页面
    self.block(image);
    
}




@end
