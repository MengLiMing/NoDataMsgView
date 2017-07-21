//
//  NoDataMsgView.h
//  Yun
//
//  Created by my on 2017/3/31.
//  Copyright © 2017年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"
@class NoDataMsgView;

typedef void (^tapAction)();
typedef BOOL (^hiddenOrShow)();

@interface NoDataMsgView : UIView


///自定义缺省view，请使用
+ (void)noDataView:(UIView *)customView
           offsetX:(CGFloat)offsetX
            offsetY:(CGFloat)offsetY
             addTo:(UIView *)superView
             hiden:(hiddenOrShow)hidden
         tapAction:(tapAction)action;

///自定义缺省view，设置宽高
+ (void)noDataView:(UIView *)customView
           offsetX:(CGFloat)offsetX
           offsetY:(CGFloat)offsetY
             addTo:(UIView *)superView
             width:(CGFloat)width
            height:(CGFloat)height
             hiden:(hiddenOrShow)hidden
         tapAction:(tapAction)action;

///设置最大高度：不设置则为屏幕宽或者高 offsetX，offsetY，相对于中心点的偏移
+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
        maxHeight:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action;

///设置最大宽度
+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
         maxWidth:(CGFloat)width
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action;

///文字图片是否需要改动
+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
       needChange:(void(^)(UILabel*,UIImageView*))needChange
         maxWidth:(CGFloat)width
        maxHeight:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action;


///GIF
+ (void)noDataMsg:(NSString *)msg
          withGif:(NSData *)gifData
            width:(CGFloat)width
           height:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action;

+ (void)noDataMsg:(NSString *)msg
      withGifName:(NSString *)name
            width:(CGFloat)width
           height:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action;

@end
