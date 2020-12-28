import Foundation
import CoreImage

public class CISwipeTransition: ImageFilter {
    init() {
        super.init(name: "CISwipeTransition")
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CISwipeTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputOpacity(_ inputOpacity: Double) -> CISwipeTransition {
        filter.setValue(inputOpacity, forKey:"inputOpacity")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CISwipeTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CISwipeTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CISwipeTransition {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CISwipeTransition {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CISwipeTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CISwipeTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
}
