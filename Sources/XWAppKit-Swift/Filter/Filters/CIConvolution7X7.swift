import Foundation
import CoreImage

public class CIConvolution7X7: ImageFilter {
    public init() {
        super.init(name: "CIConvolution7X7")
    }
    public func inputWeights(_ inputWeights: CIVector?) -> CIConvolution7X7 {
        filter.setValue(inputWeights, forKey:"inputWeights")
        return self
    }
    public func inputBias(_ inputBias: Double) -> CIConvolution7X7 {
        filter.setValue(inputBias, forKey:"inputBias")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIConvolution7X7 {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
