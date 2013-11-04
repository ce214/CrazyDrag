//
//  CrazyDragViewController.h
//  CrazyDrag
//
//  Created by cdz on 13-11-4.
//  Copyright (c) 2013年 ichenxiaodao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrazyDragViewController : UIViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;


@end
