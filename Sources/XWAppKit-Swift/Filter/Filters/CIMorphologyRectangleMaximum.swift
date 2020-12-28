import Foundation
import CoreImage

public class CIMorphologyRectangleMaximum: ImageFilter {
    init() {
        super.init(name: "CIMorphologyRectangleMaximum")
    }
    public func inputHeight(_ inputHeight: Double) -> CIMorphologyRectangleMaximum {
        filter.setValue(inputHeight, forKey:"inputHeight")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMorphologyRectangleMaximum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIMorphologyRectangleMaximum {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
