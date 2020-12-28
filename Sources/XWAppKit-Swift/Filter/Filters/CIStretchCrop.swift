import Foundation
import CoreImage

public class CIStretchCrop: ImageFilter {
    init() {
        super.init(name: "CIStretchCrop")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIStretchCrop {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCropAmount(_ inputCropAmount: Double) -> CIStretchCrop {
        filter.setValue(inputCropAmount, forKey:"inputCropAmount")
        return self
    }
    public func inputCenterStretchAmount(_ inputCenterStretchAmount: Double) -> CIStretchCrop {
        filter.setValue(inputCenterStretchAmount, forKey:"inputCenterStretchAmount")
        return self
    }
    public func inputSize(_ inputSize: CIVector?) -> CIStretchCrop {
        filter.setValue(inputSize, forKey:"inputSize")
        return self
    }
}
