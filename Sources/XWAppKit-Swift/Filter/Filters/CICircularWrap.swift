import Foundation
import CoreImage

public class CICircularWrap: ImageFilter {
    init() {
        super.init(name: "CICircularWrap")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICircularWrap {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICircularWrap {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CICircularWrap {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CICircularWrap {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
