import Foundation
import CoreImage

public class CIColorCube: ImageFilter {
    public init() {
        super.init(name: "CIColorCube")
    }
    public func inputCubeData(_ inputCubeData: NSData?) -> CIColorCube {
        filter.setValue(inputCubeData, forKey:"inputCubeData")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorCube {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCubeDimension(_ inputCubeDimension: Double) -> CIColorCube {
        filter.setValue(inputCubeDimension, forKey:"inputCubeDimension")
        return self
    }
}
