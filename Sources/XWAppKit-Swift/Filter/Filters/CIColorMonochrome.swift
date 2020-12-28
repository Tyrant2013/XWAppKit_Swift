import Foundation
import CoreImage

public class CIColorMonochrome: ImageFilter {
    public init() {
        super.init(name: "CIColorMonochrome")
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIColorMonochrome {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorMonochrome {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIColorMonochrome {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
}
