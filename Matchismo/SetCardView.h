//
//  SetCardView.h
//  Matchismo
//
//  Created by Edgar Miranda on 6/5/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *shade;
@property (nonatomic) NSUInteger count;

@property (nonatomic) BOOL selected;

@end
