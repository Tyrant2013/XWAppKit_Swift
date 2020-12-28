import Foundation
import CoreImage

public class CIEdgePreserveUpsampleFilter: ImageFilter {
    public init() {
        super.init(name: "CIEdgePreserveUpsampleFilter")
    }
    public func inputSpatialSigma(_ inputSpatialSigma: Double) -> CIEdgePreserveUpsampleFilter {
        filter.setValue(inputSpatialSigma, forKey:"inputSpatialSigma")
        return self
    }
    public func inputLumaSigma(_ inputLumaSigma: Double) -> CIEdgePreserveUpsampleFilter {
        filter.setValue(inputLumaSigma, forKey:"inputLumaSigma")
        return self
    }
    public func inputSmallImage(_ inputSmallImage: CIImage?) -> CIEdgePreserveUpsampleFilter {
        filter.setValue(inputSmallImage, forKey:"inputSmallImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIEdgePreserveUpsampleFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
