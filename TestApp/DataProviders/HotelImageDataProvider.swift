import UIKit

protocol HotelImageDataProvider {
    func image(
        with name: String,
        targetWidth: CGFloat,
        scale: CGFloat,
        completion: @escaping (UIImage?) -> Void
    )
}

final class DefaultHotelImageDataProvider: HotelImageDataProvider {
    typealias Dependencies = HasAPIService
    
    private let dependencies: Dependencies
    private let cache = NSCache<NSString, UIImage>()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func image(
        with name: String,
        targetWidth: CGFloat,
        scale: CGFloat,
        completion: @escaping (UIImage?) -> Void
    ) {
        if let image = self.cache.object(forKey: NSString(string: name)) {
            completion(image)
        } else {
            self.dependencies.apiService.fetchHotelImage(
                imageName: name
            ) { [weak self] in
                switch $0 {
                case .failure:
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                case let .success(imageData):
                    let image = ImageDownscaleService.createDownscaledImage(
                        from: imageData,
                        to: targetWidth,
                        scale: scale
                    )?.imageWithoutBorder()
                    
                    if let image = image {
                        self?.cache.setObject(image, forKey: NSString(string: name))
                    }
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}

private extension UIImage {
    
    func imageWithoutBorder() -> UIImage? {
        guard let cgimage = self.cgImage else { return nil }
        
        let contextImage = UIImage(cgImage: cgimage)
        let contextSize = contextImage.size
        
        let rect = CGRect(
            x: 1,
            y: 1,
            width: contextSize.width - 2,
            height: contextSize.height - 2
        )
        
        guard let imageRef: CGImage = cgimage.cropping(to: rect) else { return nil }
        
        return UIImage(
            cgImage: imageRef,
            scale: contextImage.scale,
            orientation: contextImage.imageOrientation
        )
    }
}
