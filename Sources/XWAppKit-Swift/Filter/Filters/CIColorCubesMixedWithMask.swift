import Foundation
import CoreImage

public class CIColorCubesMixedWithMask: ImageFilter {
    public init() {
        super.init(name: "CIColorCubesMixedWithMask")
    }
    public func inputCube0Data(_ inputCube0Data: NSData?) -> CIColorCubesMixedWithMask {
        filter.setValue(inputCube0Data, forKey:"inputCube0Data")
        return self
    }
    public func inputCubeDimension(_ inputCubeDimension: Double) -> CIColorCubesMixedWithMask {
        filter.setValue(inputCubeDimension, forKey:"inputCubeDimension")
        return self
    }
    public func inputColorSpace(_ inputColorSpace: NSObject?) -> CIColorCubesMixedWithMask {
        filter.setValue(inputColorSpace, forKey:"inputColorSpace")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorCubesMixedWithMask {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputMaskImage(_ inputMaskImage: CIImage?) -> CIColorCubesMixedWithMask {
        filter.setValue(inputMaskImage, forKey:"inputMaskImage")
        return self
    }
    public func inputCube1Data(_ inputCube1Data: NSData?) -> CIColorCubesMixedWithMask {
        filter.setValue(inputCube1Data, forKey:"inputCube1Data")
        return self
    }
}
