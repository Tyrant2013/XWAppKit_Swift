import Foundation
import CoreImage

public class CIAreaHistogram: ImageFilter {
    public init() {
        super.init(name: "CIAreaHistogram")
    }
    public func inputScale(_ inputScale: Double) -> CIAreaHistogram {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIAreaHistogram {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIAreaHistogram {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputCount(_ inputCount: Double) -> CIAreaHistogram {
        filter.setValue(inputCount, forKey:"inputCount")
        return self
    }
}
