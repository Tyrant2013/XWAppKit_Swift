import Foundation
import CoreImage

public class CITwelvefoldReflectedTile: ImageFilter {
    public init() {
        super.init(name: "CITwelvefoldReflectedTile")
    }
    public func inputAngle(_ inputAngle: Double) -> CITwelvefoldReflectedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITwelvefoldReflectedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CITwelvefoldReflectedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CITwelvefoldReflectedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
