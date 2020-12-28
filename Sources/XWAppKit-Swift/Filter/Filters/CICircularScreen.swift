import Foundation
import CoreImage

public class CICircularScreen: ImageFilter {
    public init() {
        super.init(name: "CICircularScreen")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICircularScreen {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CICircularScreen {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CICircularScreen {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICircularScreen {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
