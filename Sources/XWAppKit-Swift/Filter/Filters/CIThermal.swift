import Foundation
import CoreImage

public class CIThermal: ImageFilter {
    public init() {
        super.init(name: "CIThermal")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIThermal {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
