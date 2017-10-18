//
//  JVWineViewController.h
//  Empty Application
//
//  Created by Jaime Ventor on 13/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVWineModel.h"
#import "JVWineryTableViewController.h"

@interface JVWineViewController : UIViewController <UISplitViewControllerDelegate, WineryTableViewControllerDelegate >

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingView;


@property (strong, nonatomic) JVWineModel *model;




- (id) initWithModel: (JVWineModel*) aModel;

- (IBAction)displayWeb:(id)sender;


@end
