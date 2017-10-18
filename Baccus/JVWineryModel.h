//
//  JVWineryModel.h
//  Empty Application
//
//  Created by Jaime Ventor on 17/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVWineModel.h"

#define RED_WINE_KEY    @"Tinto"
#define WHITE_WINE_KEY  @"Blanco"
#define OTHER_WINE_KEY  @"Rosado"

@interface JVWineryModel : NSObject

@property (readonly, nonatomic) NSUInteger redWineCount;
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger otherWineCount;

- (JVWineModel *) redWineAtIndex:   (NSUInteger) index;
- (JVWineModel *) whiteWineAtIndex: (NSUInteger) index;
- (JVWineModel *) otherWineAtIndex: (NSUInteger) index;


@end
