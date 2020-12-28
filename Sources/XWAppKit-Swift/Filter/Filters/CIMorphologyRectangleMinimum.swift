import Foundation
import CoreImage

public class CIMorphologyRectangleMinimum: ImageFilter {
    init() {
        super.init(name: "CIMorphologyRectangleMinimum")
    }
    public func inputWidth(_ inputWidth: Double) -> CIMorphologyRectangleMinimum {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputHeight(_ inputHeight: Double) -> CIMorphologyRectangleMinimum {
        filter.setValue(inputHeight, forKey:"inputHeight")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMorphologyRectangleMinimum {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
