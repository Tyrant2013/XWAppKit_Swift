import Foundation
import CoreImage

public class CIBloom: ImageFilter {
    init() {
        super.init(name: "CIBloom")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBloom {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIBloom {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIBloom {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
}
