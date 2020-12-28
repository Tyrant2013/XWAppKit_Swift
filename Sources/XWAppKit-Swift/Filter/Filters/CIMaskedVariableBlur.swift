import Foundation
import CoreImage

public class CIMaskedVariableBlur: ImageFilter {
    init() {
        super.init(name: "CIMaskedVariableBlur")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMaskedVariableBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputMask(_ inputMask: CIImage?) -> CIMaskedVariableBlur {
        filter.setValue(inputMask, forKey:"inputMask")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIMaskedVariableBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
