//
//  OpenCVWrapper.m
//  image_b
//
//  Created by Gustavo Rebolledo on 21-11-19.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#include "opencv2/imgcodecs.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include "math.h"

using namespace cv;

@implementation OpenCVWrapper
    + (NSString *)getVersionString {
        return [NSString stringWithFormat:@"OpenCV Version %s",  CV_VERSION];
    }

    + (NSNumber *) isImageBlurry: (NSString *) imagePath{
        
        //NSFileManager *fileManager = [NSFileManager defaultManager];

        //BOOL isFileExist = [fileManager fileExistsAtPath: imagePath];
        
        UIImage *image;
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imagePath]];
        
        image = [UIImage imageWithData: imageData];
        
        if (image == nil) {
            //image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            // do something.
            return @-1;
        }
        
        // converting UIImage to OpenCV format - Mat
        cv::Mat matImage = [self convertUIImageToCVMat:image];
        cv::Mat matImageGrey;
        // converting image's color space (RGB) to grayscale
        cv::cvtColor(matImage, matImageGrey, CV_8S);

        cv::Mat dst2 = [self convertUIImageToCVMat:image];
        cv::Mat laplacianImage;
        dst2.convertTo(laplacianImage, CV_8UC1);

        // applying Laplacian operator to the image
        cv::Laplacian(matImageGrey, laplacianImage, CV_8U);
        cv::Mat laplacianImage8bit;
        laplacianImage.convertTo(laplacianImage8bit, CV_8UC1);

        unsigned char *pixels = laplacianImage8bit.data;

        // 16777216 = 256*256*256
        int maxLap = -16777216;
        for (int i = 0; i < ( laplacianImage8bit.elemSize()*laplacianImage8bit.total()); i++) {
            if (pixels[i] > maxLap) {
                maxLap = pixels[i];
            }
        }
        // one of the main parameters here: threshold sets the sensitivity for the blur check
        // smaller number = less sensitive; default = 180
        int threshold = 100;

        // 0: Normal, 1: Borrosa
        if(maxLap <= threshold){
            return @1;
        }else{
            return @0;
        }
    }

    + (cv::Mat) convertUIImageToCVMat:(UIImage *)image {
        CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
        CGFloat cols = image.size.width;
        CGFloat rows = image.size.height;

        cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)

        CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                        cols,                       // Width of bitmap
                                                        rows,                       // Height of bitmap
                                                        8,                          // Bits per component
                                                        cvMat.step[0],              // Bytes per row
                                                        colorSpace,                 // Colorspace
                                                        kCGImageAlphaNoneSkipLast |
                                                        kCGBitmapByteOrderDefault); // Bitmap info flags

        CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
        CGContextRelease(contextRef);

        return cvMat;
    }
@end
 
