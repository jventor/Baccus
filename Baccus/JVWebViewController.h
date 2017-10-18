//
//  JVWebViewController.h
//  Empty Application
//
//  Created by Jaime Ventor on 14/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVWineModel.h"

@interface JVWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic)  JVWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (JVWineModel *) aModel;

@end
