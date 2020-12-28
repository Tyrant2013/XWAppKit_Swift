import Foundation
import CoreImage

public class CISixfoldReflectedTile: ImageFilter {
    public init() {
        super.init(name: "CISixfoldReflectedTile")
    }
    public func inputWidth(_ inputWidth: Double) -> CISixfoldReflectedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CISixfoldReflectedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISixfoldReflectedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CISixfoldReflectedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
