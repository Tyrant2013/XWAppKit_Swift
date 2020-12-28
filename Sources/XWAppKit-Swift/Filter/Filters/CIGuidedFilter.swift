import Foundation
import CoreImage

public class CIGuidedFilter: ImageFilter {
    public init() {
        super.init(name: "CIGuidedFilter")
    }
    public func inputRadius(_ inputRadius: Double) -> CIGuidedFilter {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputGuideImage(_ inputGuideImage: CIImage?) -> CIGuidedFilter {
        filter.setValue(inputGuideImage, forKey:"inputGuideImage")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGuidedFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputEpsilon(_ inputEpsilon: Double) -> CIGuidedFilter {
        filter.setValue(inputEpsilon, forKey:"inputEpsilon")
        return self
    }
}
