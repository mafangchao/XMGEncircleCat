//
//  RBDrawView.m
//  RBDemoProj
//
//  Created by Mac on 2021/3/3.
//  Copyright © 2021 SummerTea. All rights reserved.
//

#import "RBDrawView.h"

@interface RBDrawView()

@end

@implementation RBDrawView

- (void)drawWithData:(NSArray *)data
{
    CGFloat time = 0;
    for (NSInteger i = 0; i < data.count; i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data[i]];
        
        NSNumber *typeNumber = dic[kRBDrawTypeKey];
        NSNumber *fromPointNumber = dic[kRBDrawLineFromPointKey];
        if (typeNumber.integerValue == RBDrawTypeLine || typeNumber.integerValue == RBDrawTypeCurve)
        {
            if (!fromPointNumber && i)
            {
                NSDictionary *lastDic = data[i-1];
                NSNumber *typeNumber = lastDic[kRBDrawTypeKey];
                if (typeNumber.integerValue == RBDrawTypeLine)
                {
                    dic[kRBDrawLineFromPointKey] = lastDic[kRBDrawLineToPointKey];
                }
                else if (typeNumber.integerValue == RBDrawTypeCurve)
                {
                    dic[kRBDrawLineFromPointKey] = lastDic[kRBDrawCurveToPointKey];
                }
                else if (typeNumber.integerValue == RBDrawTypeArc)
                {
                    NSNumber *arcCenterNumber = lastDic[kRBDrawArcCenterKey];
                    CGPoint centerPoint = arcCenterNumber.CGPointValue;
                    NSNumber *arcRadiusNumber = lastDic[kRBDrawArcRadiusKey];
                    NSNumber *arcEndAngleNumber = lastDic[kRBDrawArcEndAngleKey];
                    CGFloat angle = arcEndAngleNumber.floatValue;
                    //修正角度
                    if (angle < 0)
                    {
                        angle += M_PI*2;
                    }
                    while (angle > M_PI*2)
                    {
                        angle -= M_PI*2;
                    }
                    //四个象限
                    CGFloat x = 0;
                    CGFloat y = 0;
                    if (angle == M_PI*2)
                    {
                        x = centerPoint.x + arcRadiusNumber.floatValue;
                        y = centerPoint.y;
                    }
                    else if(angle >= M_PI*3/2)
                    {
                        angle -= M_PI*3/2;
                        x = centerPoint.x + arcRadiusNumber.floatValue*sin(angle);
                        y = centerPoint.y - arcRadiusNumber.floatValue*cos(angle);
                    }
                    else if(angle >= M_PI)
                    {
                        angle -= M_PI;
                        x = centerPoint.x - arcRadiusNumber.floatValue*cos(angle);
                        y = centerPoint.y - arcRadiusNumber.floatValue*sin(angle);
                    }
                    else if(angle >= M_PI/2)
                    {
                        angle -= M_PI/2;
                        x = centerPoint.x - arcRadiusNumber.floatValue*sin(angle);
                        y = centerPoint.y + arcRadiusNumber.floatValue*cos(angle);
                    }
                    else if(angle >= 0)
                    {
                        x = centerPoint.x + arcRadiusNumber.floatValue*cos(angle);
                        y = centerPoint.y + arcRadiusNumber.floatValue*sin(angle);
                    }
                    dic[kRBDrawLineFromPointKey] = @(CGPointMake(x, y));
                }
            }
        }
        
        __weak typeof(self) weak_self = self;
        NSNumber *timeOffsetNumber = dic[kRBDrawTimeOffsetKey];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time + timeOffsetNumber.floatValue) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_self addLayerWithDic: dic];
        });
        NSNumber *timeDurationNumber = dic[kRBDrawTimeDurationKey];
        time += timeDurationNumber.floatValue + timeOffsetNumber.floatValue;
    }
}

- (void)addLayerWithDic: (NSDictionary *)dic
{
    CAShapeLayer *layer = CAShapeLayer.new;
    [self.layer addSublayer:layer];
    layer.frame = self.bounds;
    
    NSNumber *lineWidthNumber = dic[kRBDrawLineWidthKey];
    layer.lineWidth = lineWidthNumber.floatValue? lineWidthNumber.floatValue: 1;
    UIColor *drawColor = dic[kRBDrawColorKey];
    layer.strokeColor = drawColor? drawColor.CGColor: UIColor.blackColor.CGColor;
    layer.fillColor = UIColor.clearColor.CGColor;
    
    NSNumber *timeDurationNumber = dic[kRBDrawTimeDurationKey];
    NSNumber *typeNumber = dic[kRBDrawTypeKey];
    
    UIBezierPath *path = UIBezierPath.bezierPath;
    
    switch (typeNumber.integerValue)
    {
        case RBDrawTypeLine:
        {
            NSNumber *fromPointNumber = dic[kRBDrawLineFromPointKey];
            NSNumber *toPointNumber = dic[kRBDrawLineToPointKey];
            if (fromPointNumber)
            {
                [path moveToPoint:fromPointNumber.CGPointValue];
            }
            if (toPointNumber)
            {
                [path addLineToPoint:toPointNumber.CGPointValue];
            }
        }
            break;
        case RBDrawTypeCurve:
        {
            NSNumber *fromPointNumber = dic[kRBDrawLineFromPointKey];
            if (fromPointNumber)
            {
                [path moveToPoint:fromPointNumber.CGPointValue];
            }
            NSNumber *curveToNumber = dic[kRBDrawCurveToPointKey];
            NSNumber *cp1 = dic[kRBDrawCurveControlPoint1Key];
            NSNumber *cp2 = dic[kRBDrawCurveControlPoint2Key];
            if (cp2)
            {
                [path addCurveToPoint:curveToNumber.CGPointValue controlPoint1:cp1.CGPointValue controlPoint2:cp2.CGPointValue];
            }
            else
            {
                [path addQuadCurveToPoint:curveToNumber.CGPointValue controlPoint:cp1.CGPointValue];
            }
        }
            break;
        case RBDrawTypeArc:
        {
            NSNumber *arcCenterNumber = dic[kRBDrawArcCenterKey];
            NSNumber *arcRadiusNumber = dic[kRBDrawArcRadiusKey];
            NSNumber *arcStartAngleNumber = dic[kRBDrawArcStartAngleKey];
            NSNumber *arcEndAngleNumber = dic[kRBDrawArcEndAngleKey];
            NSNumber *arcClosewiseNumber = dic[kRBDrawArcClockwiseKey];
            [path addArcWithCenter:arcCenterNumber.CGPointValue radius:arcRadiusNumber.floatValue startAngle:arcStartAngleNumber.floatValue endAngle:arcEndAngleNumber.floatValue clockwise:arcClosewiseNumber.intValue];
        }
            break;
        default:
            break;
    }
    
    layer.path = path.CGPath;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = timeDurationNumber.floatValue;
    [layer addAnimation:animation forKey:@""];
}

@end
