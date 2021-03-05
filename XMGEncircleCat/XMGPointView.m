//
//  XMGPointView.m
//  encircleCat
//
//  Created by machao on 2021/2/25.
//

#import "XMGPointView.h"
#define kColorWithRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

@interface XMGPointView ()
@property(nonatomic, strong) UIView *pointView;
@end

@implementation XMGPointView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = kColorWithRGB(0xa5d0fe);
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
    self.clipsToBounds = YES;
    self.titleLabel = [UILabel new];
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:9];
    
    self.imageView.frame = self.bounds;
    [self addSubview:self.imageView];
    self.imageView.hidden = YES;
}

-(void)setShowImage:(BOOL)showImage{
    _showImage = showImage;
    self.imageView.hidden = NO;
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    if (_selected) {
        self.backgroundColor = kColorWithRGB(0x032453);
    }else{
        self.backgroundColor = kColorWithRGB(0xa5d0fe);
    }
}

- (void)moveToTop{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<5; i++) {
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"a%zd.png",i+1]]];
    }
    self.imageView.animationImages = array.copy;
    self.imageView.animationRepeatCount = 1;
    self.imageView.animationDuration = 0.5;
    [self.imageView startAnimating];
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"333.png"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
