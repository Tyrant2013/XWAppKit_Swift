import Foundation
import CoreImage

public class CIFourfoldTranslatedTile: ImageFilter {
    public init() {
        super.init(name: "CIFourfoldTranslatedTile")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIFourfoldTranslatedTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputAcuteAngle(_ inputAcuteAngle: Double) -> CIFourfoldTranslatedTile {
        filter.setValue(inputAcuteAngle, forKey:"inputAcuteAngle")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIFourfoldTranslatedTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIFourfoldTranslatedTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIFourfoldTranslatedTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
