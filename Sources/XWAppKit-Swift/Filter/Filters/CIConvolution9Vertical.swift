import Foundation
import CoreImage

public class CIConvolution9Vertical: ImageFilter {
    public init() {
        super.init(name: "CIConvolution9Vertical")
    }
    public func inputWeights(_ inputWeights: CIVector?) -> CIConvolution9Vertical {
        filter.setValue(inputWeights, forKey:"inputWeights")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIConvolution9Vertical {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBias(_ inputBias: Double) -> CIConvolution9Vertical {
        filter.setValue(inputBias, forKey:"inputBias")
        return self
    }
}
