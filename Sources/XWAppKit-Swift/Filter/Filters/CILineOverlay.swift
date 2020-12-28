import Foundation
import CoreImage

public class CILineOverlay: ImageFilter {
    init() {
        super.init(name: "CILineOverlay")
    }
    public func inputNRNoiseLevel(_ inputNRNoiseLevel: Double) -> CILineOverlay {
        filter.setValue(inputNRNoiseLevel, forKey:"inputNRNoiseLevel")
        return self
    }
    public func inputNRSharpness(_ inputNRSharpness: Double) -> CILineOverlay {
        filter.setValue(inputNRSharpness, forKey:"inputNRSharpness")
        return self
    }
    public func inputEdgeIntensity(_ inputEdgeIntensity: Double) -> CILineOverlay {
        filter.setValue(inputEdgeIntensity, forKey:"inputEdgeIntensity")
        return self
    }
    public func inputContrast(_ inputContrast: Double) -> CILineOverlay {
        filter.setValue(inputContrast, forKey:"inputContrast")
        return self
    }
    public func inputThreshold(_ inputThreshold: Double) -> CILineOverlay {
        filter.setValue(inputThreshold, forKey:"inputThreshold")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CILineOverlay {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
