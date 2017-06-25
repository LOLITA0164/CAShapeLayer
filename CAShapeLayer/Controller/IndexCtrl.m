//
//  IndexCtrl.m
//  CAShapeLayer
//
//  Created by LOLITA on 17/6/25.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "IndexCtrl.h"
#import "WaveView.h"
#import "WaveTestView.h"
#import "LoadingCircleView.h"

@interface IndexCtrl ()
{
    NSTimer *timer;
    CGFloat progress;
}

@property(strong,nonatomic)WaveView *loadingView;

@property(strong,nonatomic)WaveTestView *waveView;

@property(strong,nonatomic)LoadingCircleView *cicleView;

@end

@implementation IndexCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


-(void)initUI{
    
    
    
    self.waveView = [[WaveTestView alloc] initWithFrame:CGRectMake(120, 100, kScreenWidth-120*2, 80)];
    self.waveView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.waveView];
    
    
    
    
    
    _loadingView = [WaveView loadingView];
    [self.view addSubview:_loadingView];
    _loadingView.center = self.view.center;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_loadingView startLoading];
    });
    
    
    
    
    
    
    self.cicleView = [[LoadingCircleView alloc] initWithFrame:CGRectMake(0, _loadingView.bottom +120, 50, 50)];
    self.cicleView.centerX = self.view.centerX;
    self.cicleView.fillColor = RandColor;
    [self.view addSubview:self.cicleView];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progress) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate date]];
    
}

-(void)progress{
    progress += 0.01;
    self.cicleView.progress = progress;
    if (progress>1) {
        [timer invalidate];
        timer = nil;
        [self.cicleView removeFromSuperview];
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
