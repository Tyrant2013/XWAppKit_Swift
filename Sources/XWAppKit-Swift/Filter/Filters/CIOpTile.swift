import Foundation
import CoreImage

public class CIOpTile: ImageFilter {
    public init() {
        super.init(name: "CIOpTile")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIOpTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIOpTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIOpTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIOpTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputScale(_ inputScale: Double) -> CIOpTile {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
}
