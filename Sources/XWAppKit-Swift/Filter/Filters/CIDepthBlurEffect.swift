import Foundation
import CoreImage
import AVFoundation

public class CIDepthBlurEffect: ImageFilter {
    init() {
        super.init(name: "CIDepthBlurEffect")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDepthBlurEffect {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputFocusRect(_ inputFocusRect: CIVector?) -> CIDepthBlurEffect {
        filter.setValue(inputFocusRect, forKey:"inputFocusRect")
        return self
    }
    public func inputAperture(_ inputAperture: Double) -> CIDepthBlurEffect {
        filter.setValue(inputAperture, forKey:"inputAperture")
        return self
    }
    public func inputRightEyePositions(_ inputRightEyePositions: CIVector?) -> CIDepthBlurEffect {
        filter.setValue(inputRightEyePositions, forKey:"inputRightEyePositions")
        return self
    }
    public func inputHairImage(_ inputHairImage: CIImage?) -> CIDepthBlurEffect {
        filter.setValue(inputHairImage, forKey:"inputHairImage")
        return self
    }
    public func inputNosePositions(_ inputNosePositions: CIVector?) -> CIDepthBlurEffect {
        filter.setValue(inputNosePositions, forKey:"inputNosePositions")
        return self
    }
    public func inputChinPositions(_ inputChinPositions: CIVector?) -> CIDepthBlurEffect {
        filter.setValue(inputChinPositions, forKey:"inputChinPositions")
        return self
    }
    public func inputMatteImage(_ inputMatteImage: CIImage?) -> CIDepthBlurEffect {
        filter.setValue(inputMatteImage, forKey:"inputMatteImage")
        return self
    }
    public func inputShape(_ inputShape: NSString?) -> CIDepthBlurEffect {
        filter.setValue(inputShape, forKey:"inputShape")
        return self
    }
    public func inputAuxDataMetadata(_ inputAuxDataMetadata: CGImageMetadata?) -> CIDepthBlurEffect {
        filter.setValue(inputAuxDataMetadata, forKey:"inputAuxDataMetadata")
        return self
    }
    public func inputDisparityImage(_ inputDisparityImage: CIImage?) -> CIDepthBlurEffect {
        filter.setValue(inputDisparityImage, forKey:"inputDisparityImage")
        return self
    }
    public func inputLeftEyePositions(_ inputLeftEyePositions: CIVector?) -> CIDepthBlurEffect {
        filter.setValue(inputLeftEyePositions, forKey:"inputLeftEyePositions")
        return self
    }
    public func inputLumaNoiseScale(_ inputLumaNoiseScale: Double) -> CIDepthBlurEffect {
        filter.setValue(inputLumaNoiseScale, forKey:"inputLumaNoiseScale")
        return self
    }
    public func inputScaleFactor(_ inputScaleFactor: Double) -> CIDepthBlurEffect {
        filter.setValue(inputScaleFactor, forKey:"inputScaleFactor")
        return self
    }
    @available(iOS 11.0, *)
    public func inputCalibrationData(_ inputCalibrationData: AVCameraCalibrationData?) -> CIDepthBlurEffect {
        filter.setValue(inputCalibrationData, forKey:"inputCalibrationData")
        return self
    }
}
