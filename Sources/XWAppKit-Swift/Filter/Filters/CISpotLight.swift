import Foundation
import CoreImage

public class CISpotLight: ImageFilter {
    public init() {
        super.init(name: "CISpotLight")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISpotLight {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputLightPosition(_ inputLightPosition: CIVector?) -> CISpotLight {
        filter.setValue(inputLightPosition, forKey:"inputLightPosition")
        return self
    }
    public func inputLightPointsAt(_ inputLightPointsAt: CIVector?) -> CISpotLight {
        filter.setValue(inputLightPointsAt, forKey:"inputLightPointsAt")
        return self
    }
    public func inputBrightness(_ inputBrightness: Double) -> CISpotLight {
        filter.setValue(inputBrightness, forKey:"inputBrightness")
        return self
    }
    public func inputConcentration(_ inputConcentration: Double) -> CISpotLight {
        filter.setValue(inputConcentration, forKey:"inputConcentration")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CISpotLight {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
}
