import Foundation
import CoreImage

public class CILightTunnel: ImageFilter {
    init() {
        super.init(name: "CILightTunnel")
    }
    public func inputRotation(_ inputRotation: Double) -> CILightTunnel {
        filter.setValue(inputRotation, forKey:"inputRotation")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILightTunnel {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CILightTunnel {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CILightTunnel {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
