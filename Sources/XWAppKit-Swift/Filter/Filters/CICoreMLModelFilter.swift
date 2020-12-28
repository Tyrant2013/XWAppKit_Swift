import Foundation
import CoreImage
import CoreML

public class CICoreMLModelFilter: ImageFilter {
    init() {
        super.init(name: "CICoreMLModelFilter")
    }
    public func inputSoftmaxNormalization(_ inputSoftmaxNormalization: Double) -> CICoreMLModelFilter {
        filter.setValue(inputSoftmaxNormalization, forKey:"inputSoftmaxNormalization")
        return self
    }
    public func inputHeadIndex(_ inputHeadIndex: Double) -> CICoreMLModelFilter {
        filter.setValue(inputHeadIndex, forKey:"inputHeadIndex")
        return self
    }
    @available(iOS 11.0, *)
    public func inputModel(_ inputModel: MLModel?) -> CICoreMLModelFilter {
        filter.setValue(inputModel, forKey:"inputModel")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICoreMLModelFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
