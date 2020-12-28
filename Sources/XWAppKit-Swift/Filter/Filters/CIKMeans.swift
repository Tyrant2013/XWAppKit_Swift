import Foundation
import CoreImage

public class CIKMeans: ImageFilter {
    public init() {
        super.init(name: "CIKMeans")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIKMeans {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputPerceptual(_ inputPerceptual: Double) -> CIKMeans {
        filter.setValue(inputPerceptual, forKey:"inputPerceptual")
        return self
    }
    public func inputCount(_ inputCount: Double) -> CIKMeans {
        filter.setValue(inputCount, forKey:"inputCount")
        return self
    }
    public func inputMeans(_ inputMeans: CIImage?) -> CIKMeans {
        filter.setValue(inputMeans, forKey:"inputMeans")
        return self
    }
    public func inputPasses(_ inputPasses: Double) -> CIKMeans {
        filter.setValue(inputPasses, forKey:"inputPasses")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIKMeans {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
