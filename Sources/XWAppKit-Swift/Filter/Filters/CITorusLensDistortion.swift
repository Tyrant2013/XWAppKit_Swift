import Foundation
import CoreImage

public class CITorusLensDistortion: ImageFilter {
    init() {
        super.init(name: "CITorusLensDistortion")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CITorusLensDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CITorusLensDistortion {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputRefraction(_ inputRefraction: Double) -> CITorusLensDistortion {
        filter.setValue(inputRefraction, forKey:"inputRefraction")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CITorusLensDistortion {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITorusLensDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
