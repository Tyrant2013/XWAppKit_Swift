import Foundation
import CoreImage

public class CISepiaTone: ImageFilter {
    init() {
        super.init(name: "CISepiaTone")
    }
    public func inputIntensity(_ inputIntensity: Double) -> CISepiaTone {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISepiaTone {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
