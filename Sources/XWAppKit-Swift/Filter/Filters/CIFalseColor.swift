import Foundation
import CoreImage

public class CIFalseColor: ImageFilter {
    public init() {
        super.init(name: "CIFalseColor")
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CIFalseColor {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CIFalseColor {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIFalseColor {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
