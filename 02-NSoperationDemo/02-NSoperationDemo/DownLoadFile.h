//
//  DownLoadFile.h
//  02-NSoperationDemo
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^BlockImage)(UIImage *image);

@interface DownLoadFile : NSOperation

@property(nonatomic,strong)BlockImage block;

-(instancetype)initWithDownUrl:(NSString *)url;



@end
