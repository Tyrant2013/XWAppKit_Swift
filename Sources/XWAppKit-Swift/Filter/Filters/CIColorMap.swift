import Foundation
import CoreImage

public class CIColorMap: ImageFilter {
    init() {
        super.init(name: "CIColorMap")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorMap {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputGradientImage(_ inputGradientImage: CIImage?) -> CIColorMap {
        filter.setValue(inputGradientImage, forKey:"inputGradientImage")
        return self
    }
}
