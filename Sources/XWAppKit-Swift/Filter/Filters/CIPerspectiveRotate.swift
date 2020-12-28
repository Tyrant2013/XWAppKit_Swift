import Foundation
import CoreImage

public class CIPerspectiveRotate: ImageFilter {
    init() {
        super.init(name: "CIPerspectiveRotate")
    }
    public func inputPitch(_ inputPitch: Double) -> CIPerspectiveRotate {
        filter.setValue(inputPitch, forKey:"inputPitch")
        return self
    }
    public func inputYaw(_ inputYaw: Double) -> CIPerspectiveRotate {
        filter.setValue(inputYaw, forKey:"inputYaw")
        return self
    }
    public func inputFocalLength(_ inputFocalLength: Double) -> CIPerspectiveRotate {
        filter.setValue(inputFocalLength, forKey:"inputFocalLength")
        return self
    }
    public func inputRoll(_ inputRoll: Double) -> CIPerspectiveRotate {
        filter.setValue(inputRoll, forKey:"inputRoll")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIPerspectiveRotate {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
