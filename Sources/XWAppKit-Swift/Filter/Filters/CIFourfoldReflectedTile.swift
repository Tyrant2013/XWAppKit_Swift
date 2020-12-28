import Foundation
import CoreImage

public class CIFourfoldReflectedTile: ImageFilter {
    init() {
        super.init(name: "CIFourfoldReflectedTile")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIFourfoldReflectedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIFourfoldReflectedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIFourfoldReflectedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputAcuteAngle(_ inputAcuteAngle: Double) -> CIFourfoldReflectedTile {
        filter.setValue(inputAcuteAngle, forKey:"inputAcuteAngle")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIFourfoldReflectedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
