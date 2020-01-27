//
//  OpenCVWrapper.h
//  image_b
//
//  Created by Gustavo Rebolledo on 21-11-19.
//

#import <opencv2/opencv.hpp>
#import <Foundation/Foundation.h>

#include <string>
#include <vector>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject
    + (NSString *) getVersionString;

    + (NSNumber *) isImageBlurry: (NSString *) imagePath;
@end

NS_ASSUME_NONNULL_END
