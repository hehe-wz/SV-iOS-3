//
//  ViewController.h
//  techbowA1objC
//
//  Created by ZhangZehua on 11/12/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *targetLabel;
@property (nonatomic, weak) IBOutlet UISlider *slider;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

- (IBAction) startOver:(UIButton *)sender;
- (IBAction)sliderMoved:(UISlider *)sender;

@end
