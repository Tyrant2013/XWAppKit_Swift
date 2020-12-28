import Foundation
import CoreImage

public class CITriangleKaleidoscope: ImageFilter {
    init() {
        super.init(name: "CITriangleKaleidoscope")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CITriangleKaleidoscope {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputSize(_ inputSize: Double) -> CITriangleKaleidoscope {
        filter.setValue(inputSize, forKey:"inputSize")
        return self
    }
    public func inputPoint(_ inputPoint: CIVector?) -> CITriangleKaleidoscope {
        filter.setValue(inputPoint, forKey:"inputPoint")
        return self
    }
    public func inputRotation(_ inputRotation: Double) -> CITriangleKaleidoscope {
        filter.setValue(inputRotation, forKey:"inputRotation")
        return self
    }
    public func inputDecay(_ inputDecay: Double) -> CITriangleKaleidoscope {
        filter.setValue(inputDecay, forKey:"inputDecay")
        return self
    }
}
