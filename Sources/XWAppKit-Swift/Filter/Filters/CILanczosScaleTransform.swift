import Foundation
import CoreImage

public class CILanczosScaleTransform: ImageFilter {
    init() {
        super.init(name: "CILanczosScaleTransform")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILanczosScaleTransform {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAspectRatio(_ inputAspectRatio: Double) -> CILanczosScaleTransform {
        filter.setValue(inputAspectRatio, forKey:"inputAspectRatio")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CILanczosScaleTransform {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
}
