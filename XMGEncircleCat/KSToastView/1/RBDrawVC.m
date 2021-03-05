//
//  RBDrawVC.m
//  RBDemoProj
//
//  Created by Mac on 2021/3/3.
//  Copyright © 2021 SummerTea. All rights reserved.
//

#import "RBDrawVC.h"
#import "RBDrawView.h"

@interface RBDrawVC ()

@end

@implementation RBDrawVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Private

- (void)setup
{
    self.view.backgroundColor = UIColor.whiteColor;
    
    RBDrawView *view = RBDrawView.new;
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width;
    [self.view addSubview:view];
    view.frame = CGRectMake(0, self.view.bounds.size.height/2 - height/2, width, height);
    [view drawWithData:({
        NSMutableArray *arrayM = NSMutableArray.array;
        
        //G
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @.5;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:86/255.0 green:132/255.0 blue:236/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(60, 78));
            dicM[kRBDrawArcRadiusKey] = @35;
            dicM[kRBDrawArcStartAngleKey] = @(-M_PI*0.25);
            dicM[kRBDrawArcEndAngleKey] = @(-M_PI*0.03);
            dicM[kRBDrawArcClockwiseKey] = @0;
            dicM;
        })];
        
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @0.2;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeLine);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:86/255.0 green:132/255.0 blue:236/255.0 alpha:1];
            dicM[kRBDrawLineFromPointKey] = @(CGPointMake(99, 78));
            dicM[kRBDrawLineToPointKey] = @(CGPointMake(64, 78));
            dicM;
        })];
        
        //o
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @.5;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:213/255.0 green:82/255.0 blue:63/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(131, 93));
            dicM[kRBDrawArcRadiusKey] = @22;
            dicM[kRBDrawArcStartAngleKey] = @(-M_PI*0.3);
            dicM[kRBDrawArcEndAngleKey] = @(M_PI*1.7);
            dicM[kRBDrawArcClockwiseKey] = @1;
            dicM;
        })];
        
        //o
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @-0.5;
            dicM[kRBDrawTimeDurationKey] = @.5;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:240/255.0 green:190/255.0 blue:64/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(193, 93));
            dicM[kRBDrawArcRadiusKey] = @22;
            dicM[kRBDrawArcStartAngleKey] = @(-M_PI*0.3);
            dicM[kRBDrawArcEndAngleKey] = @(M_PI*1.7);
            dicM[kRBDrawArcClockwiseKey] = @1;
            dicM;
        })];
            
        //g
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @.5;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:86/255.0 green:132/255.0 blue:236/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(250, 93));
            dicM[kRBDrawArcRadiusKey] = @20;
            dicM[kRBDrawArcStartAngleKey] = @(-M_PI*0.05);
            dicM[kRBDrawArcEndAngleKey] = @(M_PI*0.05);
            dicM[kRBDrawArcClockwiseKey] = @0;
            dicM;
        })];
        
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @.2;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:86/255.0 green:132/255.0 blue:236/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(250, 122));
            dicM[kRBDrawArcRadiusKey] = @20;
            dicM[kRBDrawArcStartAngleKey] = @(M_PI*0.9);
            dicM[kRBDrawArcEndAngleKey] = @(0);
            dicM[kRBDrawArcClockwiseKey] = @0;
            dicM;
        })];
        
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @0.2;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeLine);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:86/255.0 green:132/255.0 blue:236/255.0 alpha:1];
            dicM[kRBDrawLineFromPointKey] = @(CGPointMake(270, 122));
            dicM[kRBDrawLineToPointKey] = @(CGPointMake(270, 68));
            dicM;
        })];

        //l
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @0.4;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeLine);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:92/255.0 green:165/255.0 blue:92/255.0 alpha:1];
            dicM[kRBDrawLineFromPointKey] = @(CGPointMake(288, 37));
            dicM[kRBDrawLineToPointKey] = @(CGPointMake(288, 115));
            dicM;
        })];

        //e
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @.5;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeArc);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:213/255.0 green:82/255.0 blue:63/255.0 alpha:1];
            dicM[kRBDrawArcCenterKey] = @(CGPointMake(327, 93));
            dicM[kRBDrawArcRadiusKey] = @22;
            dicM[kRBDrawArcStartAngleKey] = @(M_PI*0.18);
            dicM[kRBDrawArcEndAngleKey] = @(M_PI*1.90);
            dicM[kRBDrawArcClockwiseKey] = @1;
            dicM;
        })];
        
        [arrayM addObject:({
            NSMutableDictionary *dicM = NSMutableDictionary.dictionary;
            dicM[kRBDrawTimeOffsetKey] = @0.0;
            dicM[kRBDrawTimeDurationKey] = @0.2;
            dicM[kRBDrawTypeKey] = @(RBDrawTypeLine);
            dicM[kRBDrawLineWidthKey] = @10;
            dicM[kRBDrawColorKey] = [UIColor colorWithRed:213/255.0 green:82/255.0 blue:63/255.0 alpha:1];
            dicM[kRBDrawLineFromPointKey] = @(CGPointMake(349, 81));
            //@(CGPointMake(345, 83));
            dicM[kRBDrawLineToPointKey] = @(CGPointMake(311, 99));
            dicM;
        })];
        
        arrayM;
    })];
}

#pragma mark - Network

#pragma mark - Event

#pragma mark - Setter

#pragma mark - Getter

@end
