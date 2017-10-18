//
//  JVWineryTableViewController.h
//  Empty Application
//
//  Created by Jaime Ventor on 17/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVWineryModel.h"

#define NUMBER_OF_SECTIONS 3

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

@class JVWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>

- (void) wineryTableViewController: (JVWineryTableViewController *) wineryVC didSelectedWine: (JVWineModel *) aWine;

@end

@interface JVWineryTableViewController : UITableViewController

@property (strong, nonatomic) JVWineryModel *model;
@property (weak,nonatomic) id<WineryTableViewControllerDelegate> delegate;

-(id) initWithModel: (JVWineryModel *) aModel
              style: (UITableViewStyle) aStyle;



@end


