//
//  MZButton.swift
//  Moodz UIViewSubclass
//
//  Created by Antonio Zaitoun on 20/02/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

@IBDesignable
open class AZSocialButton: UIButton{
    
    /// The image view which holds the icon.
    fileprivate var imageHolder: UIImageView!
    
    /// Start animation duration.
    open var beginAnimationDuration: Double = 0.2
    
    /// End animation duration.
    open var endAnimationDuration: Double = 0.25
    
    /// Animation Spring velocity.
    open var initialSpringVelocity: Float = 6.0
    
    /// Animation Spring Damping.
    open var usingSpringWithDamping: Float = 0.2
    
    /// A flag which indicates if the button is in the middle of an animation.
    internal (set) open var isAnimating = false
    
    /// Social Icon
    @IBInspectable
    open var image: UIImage?{
        didSet{
            imageHolder?.image = image
        }
    }
    
    /// Should interaction be animated.
    @IBInspectable
    open var animateInteraction: Bool = false
    
    /// Should highlight on interaction.
    @IBInspectable
    open var highlightOnTouch: Bool = true
    
    /// Animation Scale.
    open var animationScale: CGFloat = 0.95
    
    /// Corner radius.
    @IBInspectable
    open var cornerRadius: CGFloat = 2 {
        didSet{
            layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        }
    }
    
    ///Use given corner radius. if set to false will use the bounds.height / 2
    @IBInspectable
    open var useCornerRadius: Bool = false {
        didSet{
            layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        }
    }
    
    ///The primary color of the button.
    @IBInspectable
    open var color: UIColor = .white{
        didSet{
            layer.backgroundColor = color.cgColor
        }
    }
    
    /// Shadow Opacity of the button
    @IBInspectable
    open var shadowOpacity: Float = 0.2{
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    /// Shadow radius of the button.
    @IBInspectable
    open var shadowRadius: CGFloat = 1.0{
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    ///The function that is triggered once button is clicked (if set)
    open var onClickAction: ((AZSocialButton)->Void)?
    
    /// Padding between the image and the button.
    open var padding: CGFloat {
        return 7.0
    }
    
    /// The imageview.
    final override public var imageView: UIImageView?{
        return imageHolder
    }
    
    /// Init with frame.
    ///
    /// - Parameter frame: The frame of the button.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    /// Init with coder
    ///
    /// - Parameter coder: NIB Coder
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Setup function called from initializers.
    internal func setup(){
        addTarget(self, action: #selector(click), for: .touchUpInside)
        isExclusiveTouch = true
        imageHolder = UIImageView()
        imageHolder.contentMode = .scaleAspectFit
        addSubview(imageHolder)
        contentHorizontalAlignment = .left
        imageHolder.translatesAutoresizingMaskIntoConstraints = false
        imageHolder.leftAnchor.constraint(equalTo: leftAnchor, constant: padding * 2).isActive = true
        imageHolder.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageHolder.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        imageHolder.widthAnchor.constraint(equalTo: imageHolder.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    /// Called when adding the view.
    override open func didMoveToSuperview() {
        contentEdgeInsets = UIEdgeInsets(top: 0, left: frame.height * 0.4 + padding * 4, bottom: 0, right: 0)
        layer.backgroundColor = color.cgColor
        if !isAnimating {
            layer.cornerRadius = useCornerRadius ? cornerRadius : bounds.midY
        }
        imageHolder?.image = image
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    /// Selector function
    @objc func click(){
        onClickAction?(self)
    }
    
    open override var isHighlighted: Bool{
        set{
            if highlightOnTouch {
                self.alpha = newValue ? 0.5 : 1
            }
            super.isHighlighted = newValue
        }
        get{
            return super.isHighlighted
        }
    }
    
    
}

extension AZSocialButton{
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction{
            isAnimating = true
            UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap:UITouch = touches.first!
        let point = tap.location(in: self)
        if !self.bounds.contains(point){
            if self.animateInteraction{
                isAnimating = true
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = .identity
                }) { (complete) in
                    self.isAnimating = false
                }
            }
        }else{
            if self.animateInteraction{
                isAnimating = true
                UIView.animate(withDuration: self.beginAnimationDuration, animations: {
                    self.transform = CGAffineTransform(scaleX: self.animationScale, y: self.animationScale)
                }) { (complete) in
                    self.isAnimating = false
                }
            }
        }
        super.touchesMoved(touches, with: event)
        
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction{
            isAnimating = true
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                           initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesEnded(touches, with: event)
        
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.animateInteraction{
            isAnimating = true
            UIView.animate(withDuration: self.endAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(self.usingSpringWithDamping),
                           initialSpringVelocity: CGFloat(self.initialSpringVelocity),
                           options: .allowUserInteraction,
                           animations: {
                            self.transform = .identity
            }) { (complete) in
                self.isAnimating = false
            }
        }
        super.touchesCancelled(touches, with: event)
    }
}
