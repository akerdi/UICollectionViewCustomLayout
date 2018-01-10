//
//  RSPlayPauseButton.h
//  TestCollectionLayout
//
//  Created by aKerdi on 2018/1/10.
//  Copyright © 2018年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>

//https://gist.github.com/raphaelschaad/9734463

typedef NS_ENUM(NSUInteger, RSPlayPauseButtonAnimationStyle) {
    RSPlayPauseButtonAnimationStyleSplit,
    RSPlayPauseButtonAnimationStyleSplitAndRotate
};

@interface RSPlayPauseButton : UIControl

@property (nonatomic, assign, getter=isPaused) BOOL paused;
- (void)setPaused:(BOOL)paused animated:(BOOL)animated;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) RSPlayPauseButtonAnimationStyle animationStyle;// Default is `RSPlayPauseButtonAnimationStyleSplitAndRotate`

@end
