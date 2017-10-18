//
//  JVWineryModel.m
//  Empty Application
//
//  Created by Jaime Ventor on 17/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "JVWineryModel.h"

@interface JVWineryModel()
@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation JVWineryModel

#pragma mark - Properties
- (NSUInteger) redWineCount{
    return (NSUInteger)[self.redWines count];
}

- (NSUInteger) whiteWineCount {
    return (NSUInteger)[self.whiteWines count];
}

- (NSUInteger) otherWineCount {
    return (NSUInteger)[self.otherWines count];
}

#pragma mark- Init
- (id) init{
    if (self = [super init]){
        NSURL *url = [NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSError *error;
        
        if (data != nil){
            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:&error];
            if (JSONObjects != nil){
                for (NSDictionary *dict in JSONObjects){
                    JVWineModel *wine = [[JVWineModel alloc] initWithDictionary:dict];
                    
                    if ([wine.type isEqualToString:RED_WINE_KEY]){
                        if (!self.redWines){self.redWines = [NSMutableArray arrayWithObject:wine];}
                        else {[self.redWines addObject: wine];}
                    }
                    else if ([wine.type isEqualToString:WHITE_WINE_KEY]){
                            if (!self.whiteWines){ self.whiteWines = [NSMutableArray arrayWithObject:wine];}
                            else { [self.whiteWines addObject:wine];}
                    }
                    else {
                        if (!self.otherWines){self.otherWines = [NSMutableArray arrayWithObject:wine];}
                        else {[self.otherWines addObject:wine];}
                    }
                }
            }
        else{NSLog(@"Error al parsear JSON: %@", error.localizedDescription);}
    }
    else{NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);}
    }
    return self;
}


- (JVWineModel *) redWineAtIndex: (NSUInteger) index{
    return [self.redWines objectAtIndex:index];
}
- (JVWineModel *) whiteWineAtIndex: (NSUInteger) index{
    return [self.whiteWines objectAtIndex:index];
}
- (JVWineModel *) otherWineAtIndex: (NSUInteger) index{
    return [self.otherWines objectAtIndex:index];
}

@end
