import Foundation
import CoreImage

public class CIFourfoldRotatedTile: ImageFilter {
    init() {
        super.init(name: "CIFourfoldRotatedTile")
    }
    public func inputAngle(_ inputAngle: Double) -> CIFourfoldRotatedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIFourfoldRotatedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIFourfoldRotatedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIFourfoldRotatedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
