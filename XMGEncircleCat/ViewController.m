//
//  ViewController.m
//  XMGEncircleCat
//
//  Created by machao on 2021/3/5.
//
#define row 11
#define col 11
#define pointWidth 28

#define ScreenWidth                        [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                       [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"

#import "XMGPointView.h"
#import "KSToastView.h"

@interface XMGPonit : NSObject

@property(nonatomic, assign) BOOL isWall;
@property(nonatomic, assign) BOOL isEdgSide;
@property(nonatomic, assign) NSInteger distance;
@property(nonatomic, assign) NSInteger x;
@property(nonatomic, assign) NSInteger y;
@property(nonatomic, assign) NSInteger routesCount;
@property(nonatomic, strong) NSArray<XMGPonit *> *neighbours;

@property(nonatomic, strong) NSArray *directions;
@end

NSInteger maxInt =  99;
NSInteger randomPointCount =  8;
@implementation XMGPonit

-(NSInteger)routesCount{
    if (_routesCount == -1) {
        if (self.isEdgSide) {
            _routesCount = 1;
        }else{
            NSInteger count = 0;
            for (XMGPonit *point in self.neighbours) {
                if (!point.isWall && point.distance < self.distance) {
                    count += point.routesCount;
                }
            }
            _routesCount = count;
        }
    }
    return _routesCount;
}


@end

@interface ViewController ()
@property(nonatomic, strong) UIView *subView;
@property(nonatomic, strong) XMGPointView *catView;
/// 点击的 view
@property(nonatomic, strong) NSMutableArray *pointClcikArray;
/// 全部的 view
@property(nonatomic, strong) NSMutableArray *pointViewArray;

@property(nonatomic, strong) NSMutableArray *lineArray;
/// 重置
@property(nonatomic, strong) UIButton *resetButton;

/// 容易按钮
@property(nonatomic, strong) UIButton *easyButton;
@property(nonatomic, strong) UIButton *normalButton;
@property(nonatomic, strong) UIButton *hardButton;

/// 点击的点
@property(nonatomic, strong) UILabel *clickPointLabel;

/// 距离边界最短值
@property(nonatomic, strong) NSMutableArray *edgsArray;

/// 是否完成
@property(nonatomic, assign) BOOL isFinish;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"围小猫";
    [self initBgSubView];
    self.isFinish = NO;
}

/// 重置
- (void)reset{
    for (XMGPointView *view in self.pointClcikArray) {
        view.selected = NO;
    }
    [self.pointClcikArray removeAllObjects];
    [self moveCatToViewWithCol:5 andRow:5];
    [self reloadWall];
    [self randomPoint];
    [self calcAllDistances];
    self.isFinish = NO;
}

/// 改变难度等级
- (void)changeLever:(UIButton *)sender{
    if (sender == self.easyButton) {
        self.easyButton.selected = YES;
        self.normalButton.selected = NO;
        self.hardButton.selected = NO;
        randomPointCount = 11;
    }else if (sender == self.normalButton){
        self.easyButton.selected = NO;
        self.normalButton.selected = YES;
        self.hardButton.selected = NO;
        randomPointCount = 8;
    }else{
        self.easyButton.selected = NO;
        self.normalButton.selected = NO;
        self.hardButton.selected = YES;
        randomPointCount = 5;
    }
    [self reset];
}


// 重置墙
- (void)reloadWall{
    for (NSInteger i = 0; i<col; i++) {
        for (NSInteger j = 0; j<row; j++) {
            XMGPonit *point = self.edgsArray[i][j];
            point.isWall = NO;
            point.routesCount = -1;
        }
    }
}

/// 产生随机点
- (void)randomPoint{
    NSInteger count = randomPointCount;
    for (NSInteger i = 0 ; i<count;) {
        NSInteger x = random()%col;
        NSInteger y = random()%row;
        if (![self.pointClcikArray containsObject:self.pointViewArray[x][y]] && (x != col/2 && y != row/2)) {
            [self changeNeighborPointWithX:x y:y];
            [self clickPointViewWithWithCol:x andRow:y view:nil];
            i++;
        }
    }
}

/// 初始化边长数组
- (void)initPoint{
    /// 初始化边长数组
    [self.edgsArray removeAllObjects];
    NSInteger litleX = 0;
    NSInteger litleY = 0;
    for (NSInteger i = 0; i<col; i++) {
        NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:col];
        for (NSInteger j = 0; j<row; j++) {
            XMGPonit *point = [XMGPonit new];
            point.x = i;
            point.y = j;
            litleX = MIN(i, col - i-1);
            litleY = MIN(j, row - j-1);
            if (litleX == 0 || litleY == 0) {
                point.isEdgSide = YES;
                point.distance = 0;
            }else{
                point.isEdgSide = NO;
                point.distance = MIN(litleX, litleY);
            }
            point.routesCount = -1;
            point.neighbours = nil;
            point.isWall = NO;
            
            [muArray addObject:point];
        }
        
        [self.edgsArray addObject:muArray];
    }
    
}

/// 初始化数据
- (void)initBgSubView{
    [self.view addSubview:self.subView];
    self.subView.frame = CGRectMake(0, 100, ScreenWidth, ScreenWidth);
    
    CGFloat height = pointWidth;
    CGFloat width = height;
    CGFloat margin = 5;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i<col; i++) {
        NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:col];
        
        for (NSInteger j = 0; j<row; j++) {
            x = (width +margin)*j+margin +(width + margin)/2.0*(i%2);
            y = (height+margin)*i +margin;
            XMGPointView *view = [[XMGPointView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//            view.titleLabel.text = [NSString stringWithFormat:@"%zd-%zd",i,j];
            [self.subView addSubview:view];
            view.x = i;
            view.y = j;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointViewClick:)];
            [view addGestureRecognizer:tap];
            [muArray addObject:view];
        }
        [self.pointViewArray addObject:muArray];
    }
    [self.subView addSubview:self.catView];
    // 初始小猫位置
    [self moveCatToViewWithCol:col/2 andRow:row/2];
    
    // 底部 UI
    CGFloat w = ScreenWidth / 3.0;
    CGFloat labelY = ScreenWidth +100;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, ScreenWidth, 40)];
    [self.view addSubview:label];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"难度等级";
    
    labelY += 50;
    
    [self.view addSubview:self.easyButton];
    self.easyButton.frame = CGRectMake(0, labelY, w, 50);
    
    [self.view addSubview:self.normalButton];
    self.normalButton.frame = CGRectMake(w, labelY, w, 50);
    
    [self.view addSubview:self.hardButton];
    self.hardButton.frame = CGRectMake(2*w, labelY, w, 50);
    
    labelY += 80;
    [self.view addSubview:self.resetButton];
    self.resetButton.frame = CGRectMake(10, labelY, 50, 50);
    
    [self.view addSubview:self.clickPointLabel];
    self.clickPointLabel.frame = CGRectMake(70, labelY, ScreenWidth - 70, 50);
    
    [self initPoint];
    [self randomPoint];
    [self calcAllDistances];
}

/// 重新计算
- (void)calcAllDistances{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<col; i++) {
        for (NSInteger j = 0; j<row; j++) {
            XMGPonit *point = self.edgsArray[i][j];
            if (!point.isWall && point.isEdgSide) {
                point.distance = 0;
                [array insertObject:point atIndex:0];
                point.routesCount = 1;
            }else{
                point.distance = maxInt;
                point.routesCount = -1;
            }
        }
    }
 
    while (array.count > 0) {
        XMGPonit *lastPoint = array.lastObject;
        
        NSArray *neighbours = [self caluAroundViewArrayWithCol:lastPoint.x andRow:lastPoint.y];
  
        for (XMGPonit *neighbour in neighbours) {
            if (!neighbour.isEdgSide && !neighbour.isWall) {
                if (neighbour.distance > lastPoint.distance +1) {
                    neighbour.distance = lastPoint.distance + 1;
                    if (![array containsObject:neighbour]) {
                        [array insertObject:neighbour atIndex:0];
                    }
                }
            }
        }
        [array removeLastObject];
    }
}

/// 修改一个点为墙
- (void)changeNeighborPointWithX:(NSInteger)x y:(NSInteger)y{
    XMGPonit *view = self.edgsArray[x][y];
    view.isWall = YES;
    view.distance = maxInt;
}

// 移动小猫到某一点
- (void)moveCatToViewWithCol:(NSInteger )c andRow:(NSInteger)r{
    CGFloat height = pointWidth;
    CGFloat width = height;
    CGFloat margin = 5;
    CGFloat x = (width +margin)*r+margin +(width + margin)/2.0*(c%2);
    CGFloat y = (height+margin)*c +margin;
//    [self.catView moveToTop];
    [UIView animateWithDuration:0.5 animations:^{
        self.catView.frame = CGRectMake(x, y, width, height);
        
    }];
    // 可以自己做一些小猫动画
#pragma mark - todo
    self.catView.x = c;
    self.catView.y = r;
}

/// 点击了某个视图
- (void)pointViewClick:(UITapGestureRecognizer *)tap{
    XMGPointView *view = (XMGPointView *)tap.view;
    
    NSInteger x = self.catView.x;
    NSInteger y = self.catView.y;
    if (self.isFinish) {
        [self reset];
        return;
    }
    /// 做必要的判断
    if (view.x == x && view.y == y) {
        [KSToastView ks_showToast:@"不能点击小猫所在位置！"];
        return;
    }
    // 获取小猫所在的点
    XMGPonit *catPoint = self.edgsArray[x][y];
    /// 选中点击的视图
    [self clickPointViewWithWithCol:0 andRow:0 view:view];
    
    XMGPonit *currentPoint = self.edgsArray[view.x][view.y];
    if (currentPoint.isWall) {
        [KSToastView ks_showToast:@"点击的位置已经存在墙了！"];
        return;
    }
    self.clickPointLabel.text = [NSString stringWithFormat:@"点击的点为：(%zd,%zd)",view.x,view.y];
    /// 修改这个点为墙
    [self changeNeighborPointWithX:view.x y:view.y];
    // 重新计算
    [self calcAllDistances];
    /// 小猫附近的点
    NSArray *catArray = catPoint.neighbours;
    NSInteger maxRoutesCount = 0;
    XMGPonit *nextPoint = nil;
    for (XMGPonit *point in catArray) {
        if (!point.isWall && point.distance < catPoint.distance) {
            if (point.routesCount > maxRoutesCount) {
                maxRoutesCount = point.routesCount;
                nextPoint = point;
            }
        }
    }
    
    if (nextPoint) {
        if (nextPoint.isEdgSide) {
            self.isFinish = YES;
            [KSToastView ks_showToast:@"哈哈，小猫成功跑出去了😀！"];
        }
        [self moveCatToViewWithCol:nextPoint.x andRow:nextPoint.y];
    }else{
        self.isFinish = YES;
        [KSToastView ks_showToast:@"😓小猫已经无路可走！"];
    }

}

// 给定一个点计算附近的点
- (NSArray *)caluAroundViewArrayWithCol:(NSInteger )c andRow:(NSInteger)r{
    NSMutableArray *array = [NSMutableArray array];
    if (c%2 ) {
        /// 当前排
        if (r-1 >= 0) {
            [array addObject:self.edgsArray[c][r-1]];
        }
        if (r+1 < row) {
            [array addObject:self.edgsArray[c][r+1]];
        }
        
        /// 上一排
        if (c-1 >=0) {
            [array addObject:self.edgsArray[c-1][r]];
        }
        if (c-1>=0 && r+1 < row) {
            [array addObject:self.edgsArray[c-1][r+1]];
        }
        
        /// 下一排
        if (c+1<col) {
            [array addObject:self.edgsArray[c+1][r]];
            if (r+1<row) {
                [array addObject:self.edgsArray[c+1][r+1]];
            }
            
        }

    }else{
        /// 当前排
        if (r-1 >= 0) {
            [array addObject:self.edgsArray[c][r-1]];
        }
        if (r+1 < row) {
            [array addObject:self.edgsArray[c][r+1]];
        }
        /// 上一排
        if (c-1 >=0) {
            if (r-1 >= 0) {
                [array addObject:self.edgsArray[c-1][r-1]];
            }
            [array addObject:self.edgsArray[c-1][r]];
        }
        /// 下一排
        if (c+1<col) {
            if (r-1 >= 0) {
                [array addObject:self.edgsArray[c+1][r-1]];
            }
            [array addObject:self.edgsArray[c+1][r]];
        }
    }
    

    XMGPonit *point = self.edgsArray[c][r];
    if (point.neighbours == nil) {
        point.neighbours = array;
    }
    return array.copy;
}

// 选中点击的视图
- (void)clickPointViewWithWithCol:(NSInteger )c andRow:(NSInteger)r view:(XMGPointView *)clickView{
    if (clickView) {
        if ([self.pointClcikArray containsObject:clickView]) {
            [KSToastView ks_showToast:@"点击的位置已经是墙了！"];
            return;
        }else{
            [self.pointClcikArray addObject:clickView];
        }
        clickView.selected = YES;
        return;
    }
    NSArray *array = self.pointViewArray[c];
    XMGPointView *view = array[r];
    if ([self.pointClcikArray containsObject:view]) {
        return;
    }else{
        [self.pointClcikArray addObject:view];
    }
    view.selected = YES;
}


#pragma mark --- lazy
/// 初始化
-(UIView *)subView{
    if (!_subView) {
        _subView = [UIView new];
        _subView.backgroundColor = [UIColor whiteColor];
    }
    return _subView;
}

-(XMGPointView *)catView{
    if (!_catView) {
        _catView = [[XMGPointView alloc] initWithFrame:CGRectMake(0, 0, pointWidth, pointWidth)];
        _catView.showImage = YES;
    }
    return _catView;
}

-(NSMutableArray *)pointClcikArray{
    if (!_pointClcikArray) {
        _pointClcikArray = [NSMutableArray array];
    }
    return _pointClcikArray;
}

-(NSMutableArray *)pointViewArray{
    if (!_pointViewArray) {
        _pointViewArray = [NSMutableArray array];
    }
    return _pointViewArray;
}

-(NSMutableArray *)lineArray{
    if (!_lineArray) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

-(NSMutableArray *)edgsArray{
    if (!_edgsArray) {
        _edgsArray = [NSMutableArray array];
    }
    return _edgsArray;
}

-(UIButton *)resetButton{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

-(UILabel *)clickPointLabel{
    if (!_clickPointLabel) {
        _clickPointLabel = [[UILabel alloc] init];
        _clickPointLabel.textColor = [UIColor blackColor];
        _clickPointLabel.font = [UIFont systemFontOfSize:15.0];
        _clickPointLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _clickPointLabel;
}


-(UIButton *)easyButton{
    if (!_easyButton) {
        _easyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_easyButton setTitle:@"简单" forState:UIControlStateNormal];
        [_easyButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_easyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_easyButton addTarget:self action:@selector(changeLever:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _easyButton;
}

-(UIButton *)normalButton{
    if (!_normalButton) {
        _normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_normalButton setTitle:@"一般" forState:UIControlStateNormal];
        [_normalButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_normalButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _normalButton.selected = YES;
        [_normalButton addTarget:self action:@selector(changeLever:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalButton;
}

-(UIButton *)hardButton{
    if (!_hardButton) {
        _hardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hardButton setTitle:@"困难" forState:UIControlStateNormal];
        [_hardButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_hardButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_hardButton addTarget:self action:@selector(changeLever:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hardButton;
}

@end
