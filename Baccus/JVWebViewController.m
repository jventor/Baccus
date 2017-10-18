//
//  JVWebViewController.m
//  Empty Application
//
//  Created by Jaime Ventor on 14/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "JVWebViewController.h"
#import "JVWineryTableViewController.h"



@implementation JVWebViewController

-(id) initWithModel: (JVWineModel *) aModel{
    if (self = [super initWithNibName:nil
                               bundle:nil]){
        _model = aModel;
        
                self.title = @"Web";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
    
    //alta de notificación
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Baja de notificación
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) wineDidChange: (NSNotification *) notification{
    NSDictionary *dict = [notification userInfo];
    JVWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    // Actualizar el modelo
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
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

- (void) displayURL: (NSURL *) aURL{
    
    self.browser.delegate = self;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];

}

#pragma mark - UIWebViewDelegate

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}


@end
