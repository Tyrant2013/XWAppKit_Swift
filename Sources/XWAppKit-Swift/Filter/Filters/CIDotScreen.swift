import Foundation
import CoreImage

public class CIDotScreen: ImageFilter {
    init() {
        super.init(name: "CIDotScreen")
    }
    public func inputWidth(_ inputWidth: Double) -> CIDotScreen {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIDotScreen {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CIDotScreen {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDotScreen {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIDotScreen {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
