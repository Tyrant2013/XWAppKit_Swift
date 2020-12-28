import Foundation
import CoreImage

public class CICircleSplashDistortion: ImageFilter {
    init() {
        super.init(name: "CICircleSplashDistortion")
    }
    public func inputRadius(_ inputRadius: Double) -> CICircleSplashDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICircleSplashDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICircleSplashDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
