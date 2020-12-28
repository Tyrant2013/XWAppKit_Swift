import Foundation
import CoreImage
import AVFoundation

public class CICameraCalibrationLensCorrection: ImageFilter {
    init() {
        super.init(name: "CICameraCalibrationLensCorrection")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICameraCalibrationLensCorrection {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputUseInverseLookUpTable(_ inputUseInverseLookUpTable: Double) -> CICameraCalibrationLensCorrection {
        filter.setValue(inputUseInverseLookUpTable, forKey:"inputUseInverseLookUpTable")
        return self
    }
    @available(iOS 11.0, *)
    public func inputAVCameraCalibrationData(_ inputAVCameraCalibrationData: AVCameraCalibrationData?) -> CICameraCalibrationLensCorrection {
        filter.setValue(inputAVCameraCalibrationData, forKey:"inputAVCameraCalibrationData")
        return self
    }
}
