//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Edgar Miranda on 6/3/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
