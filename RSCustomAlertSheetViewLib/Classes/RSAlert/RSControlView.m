//
//  RSContentView.m
//  RSCustomAlertView
//
//  Created by WhatsXie on 2017/11/15.
//  Copyright © 2017年 R.S. All rights reserved.
//

#import "RSControlView.h"
#import <math.h>

static const CGFloat RSControlViewWidth = 280.0f;
static const CGFloat RSControlViewButtonHeight = 45.0f;
static const CGFloat RSControlViewCornerRadius = 10.0f;
static const CGFloat RSControlViewVerticalSpacing = 15.0f;
static const CGFloat RSControlViewHorizontalSpacing = 15.0f;

@interface RSControlView(){
    CGFloat screenWidth;
    CGFloat screenHeight;
    UIColor *_lineColor;
}
@end

@implementation RSControlView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        screenWidth = [[UIScreen mainScreen] bounds].size.width;
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
        _lineColor = [UIColor colorWithRed:131/255.0 green:146/255.0 blue:165/255.0 alpha:0.5];
    }
    return self;
}

- (void)setupContent:(NSString*)content confirmButton:(RSButton*)confirmButton cancleButton:(RSButton*)cancleButton {
    
    content=content?:@"";
    CGFloat textHeight = [self contentHeight:content];
    
    ///add contentLabel
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText = [[NSAttributedString alloc]initWithString:content
                                                                 attributes:@{NSFontAttributeName: self.contentFont,
                                                                              NSForegroundColorAttributeName:self.contentTextColor,
                                                                              NSParagraphStyleAttributeName:[self paragraphStyle]}];
    contentLabel.textAlignment = self.contentTextAlignment;
    
    [self addView:contentLabel
             left:RSControlViewVerticalSpacing
              top:RSControlViewHorizontalSpacing
            width:RSControlViewWidth-RSControlViewVerticalSpacing*2
           height:textHeight];
    
    if (confirmButton) {
        
        ///add horizontalLineView
        UIView *horizontalLineView = [UIView new];
        [horizontalLineView setBackgroundColor:_lineColor];
        [self addView:horizontalLineView
                 left:0
                  top:textHeight+RSControlViewHorizontalSpacing*2
                width:RSControlViewWidth
               height:0.5];
        
        if (cancleButton) {
            
            ///add cancleButton
            [self addView:cancleButton
                     left:0
                      top:textHeight+RSControlViewHorizontalSpacing*2+0.5
                    width:RSControlViewWidth/2
                   height:RSControlViewButtonHeight];
            
            ///add confirmButton
            [self addView:confirmButton
                     left:RSControlViewWidth/2
                      top:textHeight+RSControlViewHorizontalSpacing*2+0.5
                    width:RSControlViewWidth/2
                   height:RSControlViewButtonHeight];
            
            ///add verticalLineView
            UIView *verticalLineView = [UIView new];
            [verticalLineView setBackgroundColor:_lineColor];
            [self addView:verticalLineView
                     left:RSControlViewWidth/2-0.25
                      top:textHeight+RSControlViewHorizontalSpacing*2+0.5
                    width:0.5
                   height:RSControlViewButtonHeight];
        }else{
            
            ///add  confirmButton
            [self addView:confirmButton
                     left:0
                      top:textHeight+RSControlViewHorizontalSpacing*2+0.5
                    width:RSControlViewWidth
                   height:RSControlViewButtonHeight];
        }
        [self setupViewSize:self width:RSControlViewWidth height:textHeight+RSControlViewHorizontalSpacing*2+RSControlViewButtonHeight+0.5];
    }else{
        [self setupViewSize:self width:RSControlViewWidth height:textHeight+RSControlViewHorizontalSpacing*2];
    }
    
    self.layer.cornerRadius = RSControlViewCornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setupImage:(UIImage*)image content:(NSString*)content confirmButton:(RSButton*)confirmButton cancleButton:(RSButton*)cancleButton {
    if (!image) {
        [self setupContent:content confirmButton:confirmButton cancleButton:cancleButton];
        return;
    }
    content=content?:@"";
    CGFloat imgH = image.size.height;
    CGFloat imgW = image.size.width;
    CGFloat textHeight = [self contentHeight:content];
    
    ///add  imageView
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeCenter;
    [imageView setImage:image];
    [self addView:imageView
             left:(RSControlViewWidth-imgW)/2
              top:RSControlViewHorizontalSpacing
            width:imgW
           height:imgH];
    
    ///add contentLabel
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText = [[NSAttributedString alloc]initWithString:content
                                                                 attributes:@{NSFontAttributeName: self.contentFont,
                                                                              NSForegroundColorAttributeName:self.contentTextColor,
                                                                              NSParagraphStyleAttributeName:[self paragraphStyle]}];
    contentLabel.textAlignment = self.contentTextAlignment;
    [self addView:contentLabel
             left:RSControlViewVerticalSpacing
              top:RSControlViewHorizontalSpacing*2+imgH
            width:RSControlViewWidth-RSControlViewVerticalSpacing*2
           height:textHeight];
    
    if (confirmButton) {
        ///add horizontalLineView
        UIView *horizontalLineView = [UIView new];
        [horizontalLineView setBackgroundColor:_lineColor];
        [self addView:horizontalLineView
                 left:0
                  top:textHeight+RSControlViewHorizontalSpacing*3+imgH
                width:RSControlViewWidth
               height:0.5];
        
        if (cancleButton) {
            ///add cancleButton
            [self addView:cancleButton
                     left:0
                      top:imgH+textHeight+RSControlViewHorizontalSpacing*3+0.5
                    width:RSControlViewWidth/2
                   height:RSControlViewButtonHeight];
            ///add confirmButton
            [self addView:confirmButton
                     left:RSControlViewWidth/2
                      top:imgH+textHeight+RSControlViewHorizontalSpacing*3+0.5
                    width:RSControlViewWidth/2
                   height:RSControlViewButtonHeight];
            ///add verticalLineView
            UIView *verticalLineView = [UIView new];
            [verticalLineView setBackgroundColor:_lineColor];
            [self addView:verticalLineView
                     left:RSControlViewWidth/2-0.25
                      top:imgH+textHeight+RSControlViewHorizontalSpacing*3+0.5
                    width:0.5
                   height:RSControlViewButtonHeight];
        }else{
            ///add confirmButton
            [self addView:confirmButton
                     left:0
                      top:imgH+textHeight+RSControlViewHorizontalSpacing*3+0.5
                    width:RSControlViewWidth
                   height:RSControlViewButtonHeight];
        }
        
        [self setupViewSize:self width:RSControlViewWidth height:textHeight+imgH+RSControlViewHorizontalSpacing*3+RSControlViewButtonHeight+0.5];
    }else{
        [self setupViewSize:self width:RSControlViewWidth height:imgH+textHeight+RSControlViewHorizontalSpacing*3];
    }
    self.layer.cornerRadius = RSControlViewCornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setupCustomView:(UIView*)view confirmButton:(RSButton*)confirmButton cancleButton:(RSButton*)cancleButton {
    CGSize customViewSize = view.frame.size;
    [self addView:view left:0 top:0 width:customViewSize.width height:customViewSize.height];
    if (confirmButton) {
        ///add horizontalLineView
        UIView *horizontalLineView = [UIView new];
        [horizontalLineView setBackgroundColor:_lineColor];
        [self addView:horizontalLineView
                 left:0
                  top:customViewSize.height
                width:customViewSize.width
               height:0.5];
        
        if (cancleButton) {
            ///add cancleButton
            [self addView:cancleButton
                     left:0
                      top:customViewSize.height+0.5
                    width:customViewSize.width/2
                   height:RSControlViewButtonHeight];
            ///add confirmButton
            [self addView:confirmButton
                     left:customViewSize.width/2
                      top:customViewSize.height+0.5
                    width:customViewSize.width/2
                   height:RSControlViewButtonHeight];
            ///add verticalLineView
            UIView *verticalLineView = [UIView new];
            [verticalLineView setBackgroundColor:_lineColor];
            [self addView:verticalLineView
                     left:customViewSize.width/2-0.25
                      top:customViewSize.height+0.5
                    width:0.5
                   height:RSControlViewButtonHeight];
        }else{
            ///add confirmButton
            [self addView:confirmButton
                     left:0
                      top:customViewSize.height+0.5
                    width:customViewSize.width
                   height:RSControlViewButtonHeight];
        }
        
        [self setupViewSize:self width:customViewSize.width height:customViewSize.height+RSControlViewButtonHeight+0.5];
    }else{
        [self setupViewSize:self width:customViewSize.width height:customViewSize.height];
    }
    self.layer.cornerRadius = RSControlViewCornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)addView:(UIView*)view left:(CGFloat)left top:(CGFloat)Top width:(CGFloat)width height:(CGFloat)height {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:left];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:Top];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.0
                                                                        constant:width];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.0
                                                                         constant:height];
    [self addConstraint:leftConstraint];
    [self addConstraint:topConstraint];
    [view addConstraint:widthConstraint];
    [view addConstraint:heightConstraint];
}

- (void)setupViewSize:(UIView*)view width:(CGFloat)width height:(CGFloat)height {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.0
                                                                        constant:width];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.0
                                                                         constant:height];
    [view addConstraint:widthConstraint];
    [view addConstraint:heightConstraint];
}


- (CGFloat)contentHeight:(NSString*)content {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:self.lineSpace];
    
    CGFloat contentHeight =[content boundingRectWithSize:CGSizeMake(RSControlViewWidth-20, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName: self.contentFont,NSParagraphStyleAttributeName:paragraphStyle}
                                                 context:nil].size.height;
    
    CGFloat $h = fmodf(contentHeight, (NSInteger)contentHeight);
    contentHeight -= $h;
    contentHeight += $h==0.f?:1.0f;
    
    return contentHeight;
}

- (NSMutableParagraphStyle*)paragraphStyle {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:self.lineSpace];
    
    return paragraphStyle;
}

@end
