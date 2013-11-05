//
//  CrazyDragViewController.m
//  CrazyDrag
//
//  Created by cdz on 13-11-4.
//  Copyright (c) 2013年 ichenxiaodao. All rights reserved.
//

//${PRODUCT_NAME}
#import "CrazyDragViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface CrazyDragViewController ()
{
    int currentValue; //当前数值
    int targetValue; //目标数值
    int score; //总分数
    int round; //总回合数
}
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)showAlert:(id)sender; //打靶按钮
- (IBAction)sliderMoved:(id)sender; //移动滑块
- (IBAction)startOver:(id)sender; //重新开始按钮
- (IBAction)showInfo:(id)sender; //帮助信息按钮

@end


@implementation CrazyDragViewController

@synthesize slider, targetLabel, scoreLabel, roundLabel, audioPlayer;

- (void)playBackbroundMusic
{
    NSString *musicPath = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer == nil)
    {
        NSString *errorInfo = [NSString stringWithFormat:[error description]];
        NSLog(@"the error is :%@", errorInfo);
    }
    else
    {
        [audioPlayer play];
    }
}
/*
 更新显示标签
 */
- (void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

/*
 开始新回合
 */
- (void)startNewRound
{
    round += 1;
	targetValue = 1 + (arc4random() % 100);  //arc4random() 随机生成一个0到40亿之间的整数
    currentValue = 50;
    self.slider.value = currentValue; //每轮开始的时候，滑块都在中间位置
}

/*
 主界面启动之后
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     节点图片和按钮类似，因此有一个正常状态，还有一个高亮状态。
     同时滑动条对于节点两边的滑动背景也采用不同的图片。左边是绿色的，右边是灰色的
     */
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    
    [self startNewRound];
    [self updateLabels];
    [self playBackbroundMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
}

/*
 重新开始
 */
- (IBAction)startOver:(id)sender
{
    //添加过渡效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;// 淡入淡出
    transition.duration = 1;//持续1秒
    transition.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];


    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

/*
 帮助信息按钮
 */
- (IBAction)showInfo:(id)sender
{
    AboutViewController * controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStylePartialCurl;//设置新视图控制器转换模式，也就是动画效果。
    [self presentViewController:controller animated:YES completion:nil];
}

/*
 UIModalTransitionStyleCoverVertical 从下往上却换界面
 UIModalTransitionStyleFlipHorizontal 横向翻页效果
 UIModalTransitionStyleCrossDissolve 交叉溶解的却换效果
 UIModalTransitionStylePartialCurl 卷曲的却换效果
 */


- (IBAction)showAlert:(id)sender {
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    score += points;
    NSString *title;
    if(difference == 0)
    {
        title = @"你太NB了，奖励100分！";
        score += 100;
    }
    else if(difference < 5)
    {
        if (difference == 1)
        {
            score += 50;
            title = @"太棒了，差一点！奖励50分！";
        }
        else
        {
             title = @"太棒了，相差不大！";
        }
    }
    else if(difference < 10)
    {
        title = @"好吧，勉强可以";
    }
    else
    {
        title = @"太差了，会不会玩啊！";
    }
    NSString * message = [NSString stringWithFormat:@"你的得分是：%d" ,points];
    [[[UIAlertView alloc] initWithTitle:message message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ] show];
}

/*
 对话框消失之后
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

/*
 移动滑块
 */
- (IBAction)sliderMoved:(UISlider *)sender {
    currentValue = (int)lroundf(sender.value); //lroundf把一个低矮小数点的数值四舍五入到最接近的整数，返回类型是long
}


@end
