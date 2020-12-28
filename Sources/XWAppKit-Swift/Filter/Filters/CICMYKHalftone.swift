import Foundation
import CoreImage

public class CICMYKHalftone: ImageFilter {
    init() {
        super.init(name: "CICMYKHalftone")
    }
    public func inputSharpness(_ inputSharpness: Double) -> CICMYKHalftone {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    public func inputGCR(_ inputGCR: Double) -> CICMYKHalftone {
        filter.setValue(inputGCR, forKey:"inputGCR")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICMYKHalftone {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICMYKHalftone {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CICMYKHalftone {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputUCR(_ inputUCR: Double) -> CICMYKHalftone {
        filter.setValue(inputUCR, forKey:"inputUCR")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CICMYKHalftone {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
