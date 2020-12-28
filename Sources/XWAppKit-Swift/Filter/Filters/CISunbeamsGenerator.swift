import Foundation
import CoreImage

public class CISunbeamsGenerator: ImageFilter {
    init() {
        super.init(name: "CISunbeamsGenerator")
    }
    public func inputSunRadius(_ inputSunRadius: Double) -> CISunbeamsGenerator {
        filter.setValue(inputSunRadius, forKey:"inputSunRadius")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CISunbeamsGenerator {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputStriationStrength(_ inputStriationStrength: Double) -> CISunbeamsGenerator {
        filter.setValue(inputStriationStrength, forKey:"inputStriationStrength")
        return self
    }
    public func inputStriationContrast(_ inputStriationContrast: Double) -> CISunbeamsGenerator {
        filter.setValue(inputStriationContrast, forKey:"inputStriationContrast")
        return self
    }
    public func inputMaxStriationRadius(_ inputMaxStriationRadius: Double) -> CISunbeamsGenerator {
        filter.setValue(inputMaxStriationRadius, forKey:"inputMaxStriationRadius")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CISunbeamsGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CISunbeamsGenerator {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
}
