//
//  XMGPointView.h
//  encircleCat
//
//  Created by machao on 2021/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGPointView : UIView
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, assign) NSInteger x;
@property(nonatomic, assign) NSInteger y;
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) BOOL showImage;
/// 动画相关移动
- (void)moveToTop;
@end

NS_ASSUME_NONNULL_END
