import Foundation
import CoreImage

public class CIConvolution3X3: ImageFilter {
    public init() {
        super.init(name: "CIConvolution3X3")
    }
    public func inputBias(_ inputBias: Double) -> CIConvolution3X3 {
        filter.setValue(inputBias, forKey:"inputBias")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIConvolution3X3 {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputWeights(_ inputWeights: CIVector?) -> CIConvolution3X3 {
        filter.setValue(inputWeights, forKey:"inputWeights")
        return self
    }
}
