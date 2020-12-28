import Foundation
import CoreImage

public class CIHatchedScreen: ImageFilter {
    init() {
        super.init(name: "CIHatchedScreen")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHatchedScreen {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIHatchedScreen {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIHatchedScreen {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIHatchedScreen {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CIHatchedScreen {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
}
