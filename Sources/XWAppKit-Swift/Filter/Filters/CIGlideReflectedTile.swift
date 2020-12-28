import Foundation
import CoreImage

public class CIGlideReflectedTile: ImageFilter {
    public init() {
        super.init(name: "CIGlideReflectedTile")
    }
    public func inputWidth(_ inputWidth: Double) -> CIGlideReflectedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIGlideReflectedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGlideReflectedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIGlideReflectedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
