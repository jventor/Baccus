//
//  JVWineryTableViewController.m
//  Empty Application
//
//  Created by Jaime Ventor on 17/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "JVWineryTableViewController.h"
#import "JVWineViewController.h"

@interface JVWineryTableViewController ()

@end

@implementation JVWineryTableViewController


-(id) initWithModel: (JVWineryModel *) aModel
              style: (UITableViewStyle) aStyle{
    if (self = [super initWithStyle:aStyle]){
        _model = aModel;
        self.title = @"Baccus";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5
                                                                              green:0
                                                                               blue:0.13
                                                                              alpha:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == RED_WINE_SECTION){
        return @"Red wines";
    } else if (section == WHITE_WINE_SECTION){
        return @"White wines";
    } else{
        return @"Other wines";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
//return the number of rows
    if (section == RED_WINE_SECTION){
        return self.model.redWineCount;
    } else if (section == WHITE_WINE_SECTION){
        return self.model.whiteWineCount;
    } else{
        return self.model.otherWineCount;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        //Tenemos que crearla a mano
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Averiguar de que modelo (vino) nos están hablando
    JVWineModel *wine = nil;
    if (indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:(int)indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:(int)indexPath.row];
    }
    else{
        wine = [self.model otherWineAtIndex:(int)indexPath.row];
    }
    //Sincronizar celda (vista) y modelo (vino)
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //Suponemos que estamos en un navigation controller
    //Averiguamo de que vino se trata
    JVWineModel *wine = nil;
    if (indexPath.section == RED_WINE_SECTION){
        wine = [self.model redWineAtIndex:(int)indexPath.row];
    }
    else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:(int)indexPath.row];
    }
    else{
        wine = [self.model otherWineAtIndex:(int)indexPath.row];
    }
    
    [self.delegate wineryTableViewController:self didSelectedWine:wine];
 
    //Notificacion
    NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                      object:self
                                                    userInfo: @{WINE_KEY: wine}];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
}
/*
#pragma mark - NSUserDefaults
- (NSDictionary *) setDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *defaultsWineCoords = @{SECTION_KEY: @(RED_WINE_SECTION), ROW_KEY: @0};
    
    [defaults setObject:defaultsWineCoords
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
    
    return defaultsWineCoords;
}
- (void) saveLastSelectedWineAtSection: (NSUInteger) section row: (NSUInteger) row{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@{SECTION_KEY: @(section),
                          ROW_KEY: @(row)}
                 forKey:LAST_WINE_KEY];
    [defaults synchronize];
    
}
- (JVWineModel *) lastSelectedWine{
    NSInteger *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    if (coords == nil){
        coords = [self setDefaults];
    }
    else{}
    
    indexPath = [NSIndexPath indexPathForRow: [[coords objectForKey: ROW_KEY]]
                                   inSection: [[coords objectForKey: SECTION_KEY] integerValue]];
    
    return [self wineForIndexPath: indexPath];
}
*/
@end
