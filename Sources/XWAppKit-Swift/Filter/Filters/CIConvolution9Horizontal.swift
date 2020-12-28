import Foundation
import CoreImage

public class CIConvolution9Horizontal: ImageFilter {
    init() {
        super.init(name: "CIConvolution9Horizontal")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIConvolution9Horizontal {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBias(_ inputBias: Double) -> CIConvolution9Horizontal {
        filter.setValue(inputBias, forKey:"inputBias")
        return self
    }
    public func inputWeights(_ inputWeights: CIVector?) -> CIConvolution9Horizontal {
        filter.setValue(inputWeights, forKey:"inputWeights")
        return self
    }
}
