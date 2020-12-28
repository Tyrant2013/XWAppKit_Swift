import Foundation
import CoreImage

public class CIBarsSwipeTransition: ImageFilter {
    init() {
        super.init(name: "CIBarsSwipeTransition")
    }
    public func inputBarOffset(_ inputBarOffset: Double) -> CIBarsSwipeTransition {
        filter.setValue(inputBarOffset, forKey:"inputBarOffset")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIBarsSwipeTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CIBarsSwipeTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIBarsSwipeTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CIBarsSwipeTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIBarsSwipeTransition {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
