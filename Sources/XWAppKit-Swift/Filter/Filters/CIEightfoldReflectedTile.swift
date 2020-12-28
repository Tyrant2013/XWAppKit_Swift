import Foundation
import CoreImage

public class CIEightfoldReflectedTile: ImageFilter {
    public init() {
        super.init(name: "CIEightfoldReflectedTile")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIEightfoldReflectedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIEightfoldReflectedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIEightfoldReflectedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIEightfoldReflectedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
