import Foundation
import CoreImage

public class CISampleNearest: ImageFilter {
    public init() {
        super.init(name: "CISampleNearest")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISampleNearest {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
