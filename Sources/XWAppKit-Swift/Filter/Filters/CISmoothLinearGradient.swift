import Foundation
import CoreImage

public class CISmoothLinearGradient: ImageFilter {
    init() {
        super.init(name: "CISmoothLinearGradient")
    }
    public func inputColor1(_ inputColor1: CIColor?) -> CISmoothLinearGradient {
        filter.setValue(inputColor1, forKey:"inputColor1")
        return self
    }
    public func inputPoint1(_ inputPoint1: CIVector?) -> CISmoothLinearGradient {
        filter.setValue(inputPoint1, forKey:"inputPoint1")
        return self
    }
    public func inputColor0(_ inputColor0: CIColor?) -> CISmoothLinearGradient {
        filter.setValue(inputColor0, forKey:"inputColor0")
        return self
    }
    public func inputPoint0(_ inputPoint0: CIVector?) -> CISmoothLinearGradient {
        filter.setValue(inputPoint0, forKey:"inputPoint0")
        return self
    }
}
