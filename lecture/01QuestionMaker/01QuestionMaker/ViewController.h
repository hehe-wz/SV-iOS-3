//
//  ViewController.h
//  01QuestionMaker
//
//  Created by Zun Wang on 11/3/15.
//  Copyright © 2015 ZW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (nonatomic) NSNumber *num;

- (IBAction)userTapQuestionButton:(UIButton *)sender;
- (IBAction)userTapAnswerButton:(UIButton *)sender;

//[instance userTapQuestionButton:Null];
//
//// c++
//void method(Jindu arg1, Weidu arg2);
//
//method(30.0, 90.0);
//
//// objc
//- (void)methodWithjindu:(Jindu)arg1 withWeidu:(Weidu)arg2;
//
//[instance methodWithjindu:30.0 withWeidu:90.0];


@end

@interface ClassA : NSObject
//- (void)emptyMethod;
@property (nonatomic) NSNumber *numa;
@property (nonatomic) NSNumber *numb;
@property (getter=isRunning, nonatomic) BOOL running;
@end
