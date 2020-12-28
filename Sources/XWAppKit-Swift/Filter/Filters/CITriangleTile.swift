import Foundation
import CoreImage

public class CITriangleTile: ImageFilter {
    init() {
        super.init(name: "CITriangleTile")
    }
    public func inputWidth(_ inputWidth: Double) -> CITriangleTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CITriangleTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CITriangleTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITriangleTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
