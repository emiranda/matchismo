//
//  SetCard.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shade;
@property (nonatomic) NSUInteger count;

+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validShades;
+ (NSUInteger)maxCount;

@end
