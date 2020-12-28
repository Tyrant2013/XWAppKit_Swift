import Foundation
import CoreImage

public class CISixfoldRotatedTile: ImageFilter {
    public init() {
        super.init(name: "CISixfoldRotatedTile")
    }
    public func inputAngle(_ inputAngle: Double) -> CISixfoldRotatedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CISixfoldRotatedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISixfoldRotatedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CISixfoldRotatedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
