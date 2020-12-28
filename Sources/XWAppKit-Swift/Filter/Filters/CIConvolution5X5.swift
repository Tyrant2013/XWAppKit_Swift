import Foundation
import CoreImage

public class CIConvolution5X5: ImageFilter {
    public init() {
        super.init(name: "CIConvolution5X5")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIConvolution5X5 {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBias(_ inputBias: Double) -> CIConvolution5X5 {
        filter.setValue(inputBias, forKey:"inputBias")
        return self
    }
    public func inputWeights(_ inputWeights: CIVector?) -> CIConvolution5X5 {
        filter.setValue(inputWeights, forKey:"inputWeights")
        return self
    }
}
