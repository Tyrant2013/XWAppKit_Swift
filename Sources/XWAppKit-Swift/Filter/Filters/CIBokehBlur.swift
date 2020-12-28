import Foundation
import CoreImage

public class CIBokehBlur: ImageFilter {
    public init() {
        super.init(name: "CIBokehBlur")
    }
    public func inputRingAmount(_ inputRingAmount: Double) -> CIBokehBlur {
        filter.setValue(inputRingAmount, forKey:"inputRingAmount")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIBokehBlur {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputRingSize(_ inputRingSize: Double) -> CIBokehBlur {
        filter.setValue(inputRingSize, forKey:"inputRingSize")
        return self
    }
    public func inputSoftness(_ inputSoftness: Double) -> CIBokehBlur {
        filter.setValue(inputSoftness, forKey:"inputSoftness")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBokehBlur {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
