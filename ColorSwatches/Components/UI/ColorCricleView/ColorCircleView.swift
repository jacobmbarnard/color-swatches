import UIKit


// Custom view for the color circle with gradient border
class ColorCircleView: UIView {
    private var color: UIColor = .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    func setColor(fromHex hex: String) {
        color = UIColor(hex: hex) ?? .black
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: 2, dy: 2))
        color.setFill()
        circlePath.fill()
        
        // Border with gradient
        let borderPath = UIBezierPath(ovalIn: rect.insetBy(dx: 1, dy: 1))
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                  colors: [UIColor.white.cgColor, UIColor(white: 0.95, alpha: 1.0).cgColor] as CFArray,
                                  locations: [0.0, 1.0])!
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.addPath(borderPath.cgPath)
        context.clip()
        context.drawLinearGradient(gradient, start: CGPoint(x: rect.midX, y: rect.minY), end: CGPoint(x: rect.midX, y: rect.maxY), options: [])
        context.restoreGState()
        
        // Redraw the inner circle to overdraw the gradient inside the border, preserving the color
        color.setFill()
        circlePath.fill()
        
        // Thin solid border outline
        UIColor.lightGray.setStroke()
        borderPath.lineWidth = 1
        borderPath.stroke()
    }
}
