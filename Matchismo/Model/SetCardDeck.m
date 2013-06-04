//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    
    if(self){
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shade in [SetCard validShades]) {
                    for (NSInteger count = 1; count <= [SetCard maxCount]; count++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        card.count = count;
                        
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
}
    return self;
}

@end
