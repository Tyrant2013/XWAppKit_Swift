import Foundation
import CoreImage

public class CICopyMachineTransition: ImageFilter {
    public init() {
        super.init(name: "CICopyMachineTransition")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICopyMachineTransition {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CICopyMachineTransition {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputTargetImage(_ inputTargetImage: CIImage?) -> CICopyMachineTransition {
        filter.setValue(inputTargetImage, forKey:"inputTargetImage")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CICopyMachineTransition {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CICopyMachineTransition {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
    public func inputOpacity(_ inputOpacity: Double) -> CICopyMachineTransition {
        filter.setValue(inputOpacity, forKey:"inputOpacity")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CICopyMachineTransition {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CICopyMachineTransition {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
}
