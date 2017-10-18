//
//  JVWineModel.m
//  Empty Application
//
//  Created by Jaime Ventor on 13/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "JVWineModel.h"

@implementation JVWineModel

@synthesize photo = _photo;

#pragma mark - Properties

- (UIImage *) photo{
    if (_photo == nil){
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL: self.photoURL]];
    }
    return _photo;
}

#pragma mark - Class methods
+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating:(int) aRating
             photoURL: (NSURL *) aPhotoURL{
    
    return [[self alloc] initWithName: aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                                photoURL :aPhotoURL];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin{
    
    return [[self alloc] initWithName: aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin];
}


#pragma mark - Init

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating:(int) aRating
             photoURL: (NSURL *) aPhotoURL{

    if (self = [super init]){
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    }
    
    return  self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin:(NSString *) anOrigin{
    
    if (self = [super init]){
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = nil;
        _wineCompanyWeb = nil;
        _notes = nil;
        _rating = NO_RATING;
        _photoURL = nil;
    }
    
    return  self;
}

- (NSString *) description{
    return [NSString stringWithFormat:@"Name: %@\nCompany name: %@\nType: %@\nOrigin: %@\nGrapes: %@\nWine Company web: %@\n@Notes: %@\nRating: %d\n", self.name, self.wineCompanyName, self.type, self.origin, self.grapes, self.wineCompanyWeb, self.notes, self.rating];
}

-(id) initWithDictionary: (NSDictionary *) aDict{
    
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"company"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray: [aDict objectForKey:@"grapes"]]
              // wineCompanyWeb:[aDict objectForKey:@"company_web"]
               wineCompanyWeb:[NSURL URLWithString:[aDict objectForKey:@"company_web"]]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
    
}

-(NSArray *) extractGrapesFromJSONArray: (NSArray *) JSONArray{
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dict in JSONArray){
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    return grapes;
}


-(NSDictionary *) proxyForJSON{
    return @{@"name":self.name,
             @"company":self.wineCompanyName,
             @"type":self.type,
             @"origin":self.origin,
             @"grapes":self.grapes,
             @"company_web":self.wineCompanyWeb,
             @"notes":self.notes,
             @"rating": @(self.rating),
             @"picture": [self.photoURL path]};
}

-(NSArray *) packGrapesIntoJSONArray{
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes){
        [jsonArray addObject:@{@"grape" : grape}];
    }
    return jsonArray;
}

@end
