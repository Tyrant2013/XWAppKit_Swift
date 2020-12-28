import Foundation
import CoreImage

public class CIMix: ImageFilter {
    public init() {
        super.init(name: "CIMix")
    }
    public func inputBackgroundImage(_ inputBackgroundImage: CIImage?) -> CIMix {
        filter.setValue(inputBackgroundImage, forKey:"inputBackgroundImage")
        return self
    }
    public func inputAmount(_ inputAmount: Double) -> CIMix {
        filter.setValue(inputAmount, forKey:"inputAmount")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIMix {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
