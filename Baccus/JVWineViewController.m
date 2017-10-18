//
//  JVWineViewController.m
//  Empty Application
//
//  Created by Jaime Ventor on 13/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "JVWineViewController.h"
#import "JVWebViewController.h"

@implementation JVWineViewController

- (id) initWithModel: (JVWineModel*) aModel{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]){
        _model = aModel;
        
        self.title = aModel.name;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self syncModelWithView];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:1];
    //self.navigationController.navigationBar.translucent = NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions
- (IBAction)displayWeb:(id)sender{
    //NSLog(@"Go to %@", self.model.wineCompanyWeb);
    
    //Crear un webvc y hacr push
    JVWebViewController *webVC = [[JVWebViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:webVC
                                         animated:YES];
}

#pragma mark - Utils
- (void) syncModelWithView{
    self.nameLabel.text = self.model.name;
    self.wineCompanyLabel.text = self.model.wineCompanyName;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    self.photoView.image = self.model.photo;
    self.typeLabel.text = self.model.type;
    self.grapesLabel.text = [self arrayToString: self.model.grapes];
    
    [self displayRating: self.model.rating];
    
    [self.notesLabel setNumberOfLines:0];
}

- (NSString *) arrayToString: (NSArray *) anArray{
    NSString *repr = nil;
    if ([anArray count] == 1){
        repr = [@"100% " stringByAppendingString:[anArray lastObject]];
        
    }
    else{
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    return repr;
}


- (void) displayRating: (int) aRating{
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"copa"];
    for (int i = 0; i < aRating; i++){
        [[self.ratingView objectAtIndex:i] setImage:glass];
    }
}

- (void) clearRatings{
    for (UIImageView *imView in self.ratingView){
        imView.image = nil;
    }
}

#pragma mark - UISplitViewControllerDelegate

- (void) splitViewController:(UISplitViewController *)svc
     willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
    }
}

#pragma mark - WineryTableViewControlerDelegate
-(void)wineryTableViewController:(JVWineryTableViewController *)wineryVC didSelectedWine:(JVWineModel *)aWine{
    self.model = aWine;
    self.title = aWine.name;
    [self syncModelWithView];
}




@end
