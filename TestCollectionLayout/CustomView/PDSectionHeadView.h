//
//  PDSectionHeadView.h
//  PinkDiary
//
//  Created by aKerdi on 2018/1/31.
//

#import <UIKit/UIKit.h>

@interface PDSectionHeadView : UIView

@property (nonatomic, copy) void(^SectionHeadViewBlock)(PDSectionHeadView *headView);

@end
