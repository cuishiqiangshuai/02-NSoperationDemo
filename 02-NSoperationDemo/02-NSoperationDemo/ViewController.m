//
//  ViewController.m
//  02-NSoperationDemo
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadFile.h"

#define KURL @"http://www2.ppdesk.com/file/20100120/desk/2009/06/15/pincel3D_4_09_1024.jpg"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
//队列属性
@property(nonatomic,strong)NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化队列
    _operationQueue=[[NSOperationQueue alloc] init];

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dosomething{
   //1.nsurl
    NSURL *url=[NSURL URLWithString:KURL];
   //2.url====>Nsdata
    NSData *data=[NSData dataWithContentsOfURL:url];
   //3.NSdata======>uiimage
    UIImage *image=[UIImage imageWithData:data];
   //4.刷新UI/通过主线程刷新UI
    if ([NSThread currentThread].isMainThread) {
        _tempImageView.image=image;
    }else{
      __weak UIImageView *imageView=_tempImageView;
       dispatch_async(dispatch_get_main_queue(), ^{
           imageView.image=image;
       });
    }
}


- (IBAction)downLoadAction:(id)sender {
    
#if 0
   //1初始化任务
    NSInvocationOperation *opreation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(dosomething) object:nil];
    //2.将任务添加到队列
    [_operationQueue addOperation:opreation];
 
    //初始化任务
    __weak ViewController *vc=self;
    NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
       //在这里处理任务
        [vc dosomething];
    }];
    //添加到队列进行处理
    [_operationQueue addOperation:operation];
  #endif
    
 //1.初始化下载任务
    DownLoadFile *downFile=[[DownLoadFile alloc] initWithDownUrl:KURL];
 //2.监听下载回调
__weak UIImageView *imageView=_tempImageView;
    downFile.block=^(UIImage *image){
        if([NSThread currentThread].isMainThread){

        }else{

            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image=image;
            });
        }
    };
  //3.下载任务丢到队列里边
    [_operationQueue addOperation:downFile];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
