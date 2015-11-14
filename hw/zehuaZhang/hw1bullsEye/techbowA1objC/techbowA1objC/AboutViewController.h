//
//  AboutViewController.h
//  techbowA1objC
//
//  Created by ZhangZehua on 11/12/15.
//  Copyright © 2015 ZhangZehua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIWebView *webView;

- (IBAction)close:(UIButton *)sender;
@end
