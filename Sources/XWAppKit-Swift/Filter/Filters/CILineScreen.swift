import Foundation
import CoreImage

public class CILineScreen: ImageFilter {
    init() {
        super.init(name: "CILineScreen")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CILineScreen {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputSharpness(_ inputSharpness: Double) -> CILineScreen {
        filter.setValue(inputSharpness, forKey:"inputSharpness")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CILineScreen {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILineScreen {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CILineScreen {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
