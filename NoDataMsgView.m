//
//  NoDataMsgView.m
//  Yun
//
//  Created by my on 2017/3/31.
//  Copyright © 2017年 lq. All rights reserved.
//

#import "NoDataMsgView.h"
#import "UIImage+GIF.h"

static char nodataview;

@implementation NoDataMsgView

+ (void)noDataView:(UIView *)customView
           offsetX:(CGFloat)offsetX
           offsetY:(CGFloat)offsetY
             addTo:(UIView *)superView
             hiden:(hiddenOrShow)hidden
         tapAction:(tapAction)action {
    [NoDataMsgView noDataView:customView offsetX:offsetX offsetY:offsetY addTo:superView width:CGRectGetWidth(customView.bounds) height:CGRectGetHeight(customView.bounds) hiden:hidden tapAction:action];
}


+ (void)noDataView:(UIView *)customView
           offsetX:(CGFloat)offsetX
           offsetY:(CGFloat)offsetY
             addTo:(UIView *)superView
             width:(CGFloat)width
            height:(CGFloat)height
             hiden:(hiddenOrShow)hidden
         tapAction:(tapAction)action {
    UIView *view = objc_getAssociatedObject(superView, &nodataview);
    int isHidden = hidden();
    
    //1 hidden 0 show
    if (!view) {
        [customView chTapAction:^{
            if (action) {
                action();
            }
        }];
        [superView insertSubview:customView atIndex:0];
        [customView autoSetDimension:ALDimensionWidth toSize:width];
        [customView autoSetDimension:ALDimensionHeight toSize:height];
        [customView autoAlignAxis:ALAxisVertical toSameAxisOfView:superView withOffset:offsetX];
        [customView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:superView withOffset:offsetY];
        
        objc_setAssociatedObject(superView, &nodataview, customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        view.hidden = isHidden;
    }
}


+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
        maxHeight:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
    [NoDataMsgView noDataMsg:msg
                   withImage:image
                    maxWidth:0
                   maxHeight:height
                     offsetX:offsetX
                     offsetY:offsetY
                       addTo:superView
                       hiden:hidden tapAction:action];
}


+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
         maxWidth:(CGFloat)width
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
    
    [NoDataMsgView noDataMsg:msg
                   withImage:image
                    maxWidth:width
                   maxHeight:0
                     offsetX:offsetX
                     offsetY:offsetY
                       addTo:superView
                       hiden:hidden tapAction:action];
}


+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
         maxWidth:(CGFloat)width
        maxHeight:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
    [NoDataMsgView noDataMsg:msg
                   withImage:image
                  needChange:nil
                    maxWidth:width
                   maxHeight:height
                     offsetX:offsetX
                     offsetY:offsetY
                       addTo:superView
                       hiden:hidden
                   tapAction:action];
}


//文字图片是否需要改动
+ (void)noDataMsg:(NSString *)msg
        withImage:(UIImage *)image
       needChange:(void(^)(UILabel*,UIImageView*))needChange
         maxWidth:(CGFloat)width
        maxHeight:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
    NoDataMsgView *msgV = objc_getAssociatedObject(superView, &nodataview);
    int isHidden = hidden();
    
    if (!msgV) {
        msgV = [NoDataMsgView newAutoLayoutView];
        
        //得到图片的宽高
        CGFloat img_w = image.size.width;
        CGFloat img_h = image.size.height;
        
        
        //imageView宽高
        CGFloat img_v_w=0;
        CGFloat img_v_h=0;
        
        if (width>0) {
            img_v_w = width;
            img_v_h = width*img_h/img_w;
        } else if (height>0) {
            img_v_h = height;
            img_v_w = height*img_w/img_h;
        } else {
            
        }
        
        UIImageView *imageV = [UIImageView newAutoLayoutView];
        imageV.tag = 1992;
        [imageV setImage:image];
        [msgV addSubview:imageV];
        [imageV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:msgV];
        [imageV autoSetDimensionsToSize:CGSizeMake(img_v_w, img_v_h)];
        [imageV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:msgV];
        [imageV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:msgV];
        
        
        
        //处理label
        UILabel *msgLab = [UILabel newAutoLayoutView];
        msgLab.tag = 1993;
        msgLab.text = msg;
        msgLab.textColor = [UIColor grayColor];
        msgLab.textAlignment = NSTextAlignmentCenter;
        msgLab.font = [UIFont systemFontOfSize:12];
        [msgLab sizeToFit];
        [msgV addSubview:msgLab];
        [msgLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageV withOffset:5];
        [msgLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageV];
        [msgLab autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageV];
        [msgLab autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(msgLab.bounds)];
        
        
        [msgV chTapAction:^{
            if (action) {
                action();
            }
        }];
        [superView insertSubview:msgV atIndex:0];
        
        [msgV autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:msgLab withOffset:5];
        
        [msgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:superView withOffset:offsetY];
        [msgV autoAlignAxis:ALAxisVertical toSameAxisOfView:superView withOffset:offsetX];
        
        objc_setAssociatedObject(superView, &nodataview, msgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        if (needChange) {
            UIImageView *imgV = [msgV viewWithTag:1992];
            UILabel *label = [msgV viewWithTag:1993];
            needChange(label,imgV);
        }
    }
    
    msgV.hidden = isHidden;
}


+ (void)noDataMsg:(NSString *)msg
          withGif:(NSData *)gifData
            width:(CGFloat)width
           height:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
    NoDataMsgView *msgV = objc_getAssociatedObject(superView, &nodataview);
    int isHidden = hidden();
    
    if (!msgV) {
        msgV = [NoDataMsgView newAutoLayoutView];

        
        UIImageView *imageV = [UIImageView newAutoLayoutView];
        UIImage *image = [UIImage sd_animatedGIFWithData:gifData];
        imageV.image = image;
        [msgV addSubview:imageV];
        [imageV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:msgV];
        [imageV autoSetDimensionsToSize:CGSizeMake(width, height)];
        [imageV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:msgV];
        [imageV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:msgV];

        //处理label
        UILabel *msgLab = [UILabel newAutoLayoutView];
        msgLab.text = msg;
        msgLab.textColor = [UIColor grayColor];
        msgLab.textAlignment = NSTextAlignmentCenter;
        msgLab.font = [UIFont systemFontOfSize:12];
        [msgLab sizeToFit];
        [msgV addSubview:msgLab];
        [msgLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageV withOffset:5];
        [msgLab autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageV];
        [msgLab autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageV];
        [msgLab autoSetDimension:ALDimensionHeight toSize:CGRectGetHeight(msgLab.bounds)];
        
        
        [msgV chTapAction:^{
            if (action) {
                action();
            }
        }];
        [superView insertSubview:msgV atIndex:0];
        
        [msgV autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:msgLab withOffset:5];
        
        [msgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:superView withOffset:offsetY];
        [msgV autoAlignAxis:ALAxisVertical toSameAxisOfView:superView withOffset:offsetX];
        
        objc_setAssociatedObject(superView, &nodataview, msgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    msgV.hidden = isHidden;
}


+ (void)noDataMsg:(NSString *)msg
      withGifName:(NSString *)name
            width:(CGFloat)width
           height:(CGFloat)height
          offsetX:(CGFloat)offsetX
          offsetY:(CGFloat)offsetY
            addTo:(UIView *)superView
            hiden:(hiddenOrShow)hidden
        tapAction:(tapAction)action {
            NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
    [NoDataMsgView noDataMsg:msg
                     withGif:data
                       width:width
                      height:height
                     offsetX:offsetX
                     offsetY:offsetY
                       addTo:superView
                       hiden:hidden
                   tapAction:action];
}

@end
