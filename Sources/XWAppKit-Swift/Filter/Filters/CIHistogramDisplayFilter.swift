import Foundation
import CoreImage

public class CIHistogramDisplayFilter: ImageFilter {
    init() {
        super.init(name: "CIHistogramDisplayFilter")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIHistogramDisplayFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputLowLimit(_ inputLowLimit: Double) -> CIHistogramDisplayFilter {
        filter.setValue(inputLowLimit, forKey:"inputLowLimit")
        return self
    }
    public func inputHighLimit(_ inputHighLimit: Double) -> CIHistogramDisplayFilter {
        filter.setValue(inputHighLimit, forKey:"inputHighLimit")
        return self
    }
    public func inputHeight(_ inputHeight: Double) -> CIHistogramDisplayFilter {
        filter.setValue(inputHeight, forKey:"inputHeight")
        return self
    }
}
