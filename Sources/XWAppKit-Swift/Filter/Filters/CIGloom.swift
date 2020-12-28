import Foundation
import CoreImage

public class CIGloom: ImageFilter {
    init() {
        super.init(name: "CIGloom")
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIGloom {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIGloom {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGloom {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
