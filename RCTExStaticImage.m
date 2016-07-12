//
//  RCTExStaticImageView.m
//  RCTExImage
//
//  Created by 郭栋 on 15/7/8.
//  Copyright (c) 2015年 guodong. All rights reserved.
//

#import "RCTExStaticImage.h"

@implementation RCTExStaticImage

- (void)_updateImage
{
    UIImage *image = self.image;
    if (!image) {
        return;
    }
    
    // Apply rendering mode
    if (_renderingMode != image.renderingMode) {
        image = [image imageWithRenderingMode:_renderingMode];
    }
    
    // Applying capInsets of 0 will switch the "resizingMode" of the image to "tile" which is undesired
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, _capInsets)) {
        image = [image resizableImageWithCapInsets:_capInsets resizingMode:UIImageResizingModeStretch];
    }
    
    // Apply trilinear filtering to smooth out mis-sized images
    self.layer.minificationFilter = kCAFilterTrilinear;
    self.layer.magnificationFilter = kCAFilterTrilinear;
    
    super.image = image;
}

- (void)setImage:(UIImage *)image
{
    if (image != super.image) {
        super.image = image;
        [self _updateImage];
    }
}

- (void)setCapInsets:(UIEdgeInsets)capInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_capInsets, capInsets)) {
        _capInsets = capInsets;
        [self _updateImage];
    }
}

- (void)setRenderingMode:(UIImageRenderingMode)renderingMode
{
    if (_renderingMode != renderingMode) {
        _renderingMode = renderingMode;
        [self _updateImage];
    }
}

@end
