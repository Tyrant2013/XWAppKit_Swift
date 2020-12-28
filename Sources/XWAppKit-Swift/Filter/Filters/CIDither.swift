import Foundation
import CoreImage

public class CIDither: ImageFilter {
    public init() {
        super.init(name: "CIDither")
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIDither {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDither {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
