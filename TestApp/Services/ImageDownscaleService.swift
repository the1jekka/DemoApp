import UIKit

struct ImageDownscaleService {
    
    static func createDownscaledImage(
        from data: Data,
        to targetWidth: CGFloat,
        scale: CGFloat
    ) -> UIImage? {
        return autoreleasepool {
            let imageSourceOptions = [kCGImageSourceShouldCache: false]
            guard let imageSource = CGImageSourceCreateWithData(
                data as CFData,
                imageSourceOptions as CFDictionary
            ),
            let imageProperties = CGImageSourceCopyPropertiesAtIndex(
                imageSource,
                0,
                nil
            ) as? Dictionary<CFString, Any>,
            let pixelWidth =  imageProperties[kCGImagePropertyPixelWidth] as? Int,
            let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as? Int else {
                return UIImage(data: data)
            }
            
            let targetHeigth = CGFloat(pixelHeight / pixelWidth) * targetWidth
            let maxDimensionInPixels = max(targetWidth, targetHeigth) * scale
            let downsampleOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: false,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
            ] as CFDictionary
            
            guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(
                    imageSource,
                    0,
                    downsampleOptions
            ) else {
                return nil
            }
            
            return UIImage(cgImage: downsampledImage)
        }
    }
}
