//
//  RBDrawView.h
//  RBDemoProj
//
//  Created by Mac on 2021/3/3.
//  Copyright © 2021 SummerTea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RBDrawType) {
    RBDrawTypeLine = 0,//画直线
    RBDrawTypeCurve = 1,//画圆
    RBDrawTypeArc = 2,//曲线
};

NS_ASSUME_NONNULL_BEGIN

//默认0,上一个画笔结束后立马执行这个
#define kRBDrawTimeOffsetKey @"kRBDrawTimeOffsetKey"
//动画执行时间
#define kRBDrawTimeDurationKey @"kRBDrawTimeDurationKey"
//动画类型RBDrawType
#define kRBDrawTypeKey @"kRBDrawTypeKey"
//画笔宽
#define kRBDrawLineWidthKey @"kRBDrawLineWidthKey"
//画笔颜色
#define kRBDrawColorKey @"kRBDrawColorKey"

//直线起点
#define kRBDrawLineFromPointKey @"kRBDrawLineFromPointKey"
//直线终点
#define kRBDrawLineToPointKey @"kRBDrawLineToPointKey"

//曲线终点
#define kRBDrawCurveToPointKey @"kRBDrawCurveToPointKey"
//曲线控制点1
#define kRBDrawCurveControlPoint1Key @"kRBDrawCurveControlPoint1Key"
//曲线控制点2
#define kRBDrawCurveControlPoint2Key @"kRBDrawCurveControlPoint2Key"

//圆中心
#define kRBDrawArcCenterKey @"kRBDrawArcCenterKey"
//圆半径
#define kRBDrawArcRadiusKey @"kRBDrawArcRadiusKey"
//圆起点角度
#define kRBDrawArcStartAngleKey @"kRBDrawArcStartAngleKey"
//圆终点角度
#define kRBDrawArcEndAngleKey @"kRBDrawArcEndAngleKey"
//圆方向
#define kRBDrawArcClockwiseKey @"kRBDrawArcClockwiseKey"

@interface RBDrawView : UIView

- (void)drawWithData: (NSArray *)data;

@end

NS_ASSUME_NONNULL_END
