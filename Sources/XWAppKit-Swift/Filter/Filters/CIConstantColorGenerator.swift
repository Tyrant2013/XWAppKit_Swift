import Foundation
import CoreImage

public class CIConstantColorGenerator: ImageFilter {
    init() {
        super.init(name: "CIConstantColorGenerator")
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIConstantColorGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
}
