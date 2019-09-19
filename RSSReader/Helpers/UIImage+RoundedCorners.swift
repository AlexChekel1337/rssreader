import UIKit

fileprivate let sourceImageSize: CGFloat = 30.0

extension UIImage {
    
    func roundedImage() -> UIImage? {
        let imgSize = CGSize(width: sourceImageSize, height: sourceImageSize)
        let imgOpaque = false
        let imgScale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(imgSize, imgOpaque, imgScale)
        
        let drawingRect = CGRect(x: 0, y: 0, width: imgSize.width, height: imgSize.height)
        
        UIBezierPath(roundedRect: drawingRect, cornerRadius: 4).addClip()
        self.draw(in: drawingRect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    
}
