import Foundation
import CoreImage

public class CISpotColor: ImageFilter {
    public init() {
        super.init(name: "CISpotColor")
    }
    public func inputCenterColor1(_ inputCenterColor1: CIColor?) -> CISpotColor {
        filter.setValue(inputCenterColor1, forKey:"inputCenterColor1")
        return self
    }
    public func inputContrast2(_ inputContrast2: Double) -> CISpotColor {
        filter.setValue(inputContrast2, forKey:"inputContrast2")
        return self
    }
    public func inputCloseness3(_ inputCloseness3: Double) -> CISpotColor {
        filter.setValue(inputCloseness3, forKey:"inputCloseness3")
        return self
    }
    public func inputContrast3(_ inputContrast3: Double) -> CISpotColor {
        filter.setValue(inputContrast3, forKey:"inputContrast3")
        return self
    }
    public func inputContrast1(_ inputContrast1: Double) -> CISpotColor {
        filter.setValue(inputContrast1, forKey:"inputContrast1")
        return self
    }
    public func inputCloseness1(_ inputCloseness1: Double) -> CISpotColor {
        filter.setValue(inputCloseness1, forKey:"inputCloseness1")
        return self
    }
    public func inputReplacementColor1(_ inputReplacementColor1: CIColor?) -> CISpotColor {
        filter.setValue(inputReplacementColor1, forKey:"inputReplacementColor1")
        return self
    }
    public func inputReplacementColor3(_ inputReplacementColor3: CIColor?) -> CISpotColor {
        filter.setValue(inputReplacementColor3, forKey:"inputReplacementColor3")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISpotColor {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputCenterColor3(_ inputCenterColor3: CIColor?) -> CISpotColor {
        filter.setValue(inputCenterColor3, forKey:"inputCenterColor3")
        return self
    }
    public func inputCloseness2(_ inputCloseness2: Double) -> CISpotColor {
        filter.setValue(inputCloseness2, forKey:"inputCloseness2")
        return self
    }
    public func inputCenterColor2(_ inputCenterColor2: CIColor?) -> CISpotColor {
        filter.setValue(inputCenterColor2, forKey:"inputCenterColor2")
        return self
    }
    public func inputReplacementColor2(_ inputReplacementColor2: CIColor?) -> CISpotColor {
        filter.setValue(inputReplacementColor2, forKey:"inputReplacementColor2")
        return self
    }
}
