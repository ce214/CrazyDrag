//
//  CrazyDragViewController.m
//  CrazyDrag
//
//  Created by cdz on 13-11-4.
//  Copyright (c) 2013年 ichenxiaodao. All rights reserved.
//

#import "CrazyDragViewController.h"
#import "AboutViewController.h"

@interface CrazyDragViewController (){
    
    int currentValue;
    int targetValue;
    int score;
    int round;
}

- (IBAction)showAlert:(id)sender;
- (IBAction)sliderMoved:(id)sender;
- (IBAction)startOver:(id)sender;
- (IBAction)showInfo:(id)sender;

@end

@implementation CrazyDragViewController

@synthesize slider, targetLabel, scoreLabel, roundLabel;

- (void)updateLabels{
    
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", round];
}

- (void)startNewRound{
    
    round += 1;
	targetValue = 1 + (arc4random() % 100);
    currentValue = 50;
    self.slider.value = currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewRound];
    [self updateLabels];
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

- (IBAction)startOver:(id)sender {
    [self startNewGame];
    [self updateLabels];
}

- (IBAction)showInfo:(id)sender {
    AboutViewController * controller = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//设置新视图控制器转换模式，也就是动画效果。
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)showAlert:(id)sender {
    int difference = abs(currentValue - targetValue);
    int points = 100 - difference;
    score += points;
    NSString *title;
    if(difference == 0){
        title = @"土豪你太NB了！";
        score += 100;
    }else if(difference < 5){
        if (difference == 1) {
            score += 50;
        }
        title = @"土豪太棒了，差一点！";
    }else if(difference < 10){
        title = @"好吧，勉强算个土豪";
    }else{
        title = @"不是土豪少来袭！";
    }
    NSString * message = [NSString stringWithFormat:@"恭喜高富帅，你的得分是：%d" ,points];
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"朕已知晓，爱卿辛苦了" otherButtonTitles:nil, nil ] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self startNewRound];
    [self updateLabels];
}
- (IBAction)sliderMoved:(UISlider *)sender {
    currentValue = (int)lroundf(sender.value);
}


@end
