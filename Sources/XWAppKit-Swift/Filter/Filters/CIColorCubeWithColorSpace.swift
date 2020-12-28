import Foundation
import CoreImage

public class CIColorCubeWithColorSpace: ImageFilter {
    public init() {
        super.init(name: "CIColorCubeWithColorSpace")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorCubeWithColorSpace {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCubeData(_ inputCubeData: NSData?) -> CIColorCubeWithColorSpace {
        filter.setValue(inputCubeData, forKey:"inputCubeData")
        return self
    }
    public func inputColorSpace(_ inputColorSpace: NSObject?) -> CIColorCubeWithColorSpace {
        filter.setValue(inputColorSpace, forKey:"inputColorSpace")
        return self
    }
    public func inputCubeDimension(_ inputCubeDimension: Double) -> CIColorCubeWithColorSpace {
        filter.setValue(inputCubeDimension, forKey:"inputCubeDimension")
        return self
    }
}
