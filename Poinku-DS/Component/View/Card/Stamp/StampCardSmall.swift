//
//  StampCardSmall.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 06/03/25.
//

import UIKit

class StampCardSmall: UICollectionViewCell {
    
    @IBOutlet var stampCard: UIView!
    @IBOutlet var ivStampCard: UIImageView!
    @IBOutlet var vQuantity: UIView!
    @IBOutlet var ivQuantity: UIImageView!
    @IBOutlet var lblQuantity: UILabel!
    @IBOutlet var lblStampCard: UILabel!
    @IBOutlet var vStamp: UIView!
    @IBOutlet var lblStamp: UILabel!
    @IBOutlet var btnExchange: UIButton!
    
    var id: String = ""
    var title: String = ""
    var imageURL: String = ""
    var quantity: Int = 3
    var stampCount: Int = 0
    var price: Int = 0
    var isNew: Bool = false
    var isHotProduct: Bool = false
    var isDiscount: Bool = false
    var discountImp: Int = 0
    var size: Size = .stampPage
    
    enum Size {
        case fullSize
        case rewardWidget
        case stampPage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStampCard()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStampCard()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampCard() {
        if let nib = Bundle.main.loadNibNamed("StampCardSmall", owner: self, options: nil),
           let card = nib.first as? UIView {
            stampCard = card
            stampCard.frame = contentView.bounds
            stampCard.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(stampCard)
            
            setupUI()
        } else {
            print("Failed to load StampCardSmall XIB")
        }
    }
    
    private func setupUI() {
        UIStampCard()
        UIQuantity()
        UIStamp()
//        UIRibbonHotProduct()
//        UIRibbonNew()
    }
    
    private func UIStampCard() {
        stampCard.layer.cornerRadius = 8
        stampCard.layer.masksToBounds = true
        
        stampCard.backgroundColor = .white
        stampCard.layer.borderWidth = 1
        stampCard.layer.borderColor = UIColor.Blue.blue30.cgColor
        
        lblStampCard.textColor = UIColor.Grey.grey70
        lblStampCard.font = Font.Body.B3.Small.font
        
        btnExchange.titleLabel?.text = "Tukar Stamp"
        btnExchange.backgroundColor = UIColor.Blue.blue30
        btnExchange.layer.cornerRadius = 4
        btnExchange.titleLabel?.textColor = .white
        btnExchange.titleLabel?.font = Font.Button.Small.font
        
        lblStampCard.text = "Diskon Rp2.000 Lifebuoy Red Fresh"
        ivStampCard.image = UIImage(named: "product-image")
    }
    
    private func UIQuantity() {
        vQuantity.layer.cornerRadius = 8
        vQuantity.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        vQuantity.clipsToBounds = true
        
        ivQuantity.image = if quantity < 10 && quantity > 0 {
            UIImage(named: "exclamation")
        } else {
            UIImage(named: "product-empty")
        }
        ivQuantity.image = ivQuantity.image?.withRenderingMode(.alwaysTemplate)
        
        ivQuantity.tintColor = if quantity < 10 && quantity > 0 {
            UIColor.Support.warningStrong
        } else {
            UIColor.Support.errorStrong
        }
        
        vQuantity.backgroundColor = if quantity < 10 && quantity > 0 {
            UIColor.Support.warningWeak
        } else {
            UIColor.Support.errorWeak
        }
        
        lblQuantity.textColor = if quantity < 10 && quantity > 0 {
            UIColor.Support.warningStrong
        } else {
            UIColor.Support.errorStrong
        }
        
        lblQuantity.text = if quantity < 10 && quantity > 0 {
            "Kuota Mau Habis"
        } else {
            "Kuota Habis"
        }
        lblQuantity.font = Font.B4.Small.font
    }
    
    private func UIStamp() {
        vStamp.backgroundColor = UIColor.Support.highlightWeak
        vStamp.layer.cornerRadius = 8
        vStamp.layer.borderWidth = 1
        vStamp.layer.borderColor = UIColor.Support.warningStrong.cgColor
        
        lblStamp.textColor = UIColor.Support.warningStrong
        lblStamp.font = Font.B4.Small.font
        lblStamp.text = "24 Stamp"
    }
    
    private func UIRibbonHotProduct() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "Hot Product!"
        ribbonView.triangleColor = UIColor.Red.red50
        ribbonView.containerStartColor = UIColor.Red.red20
        ribbonView.containerEndColor = UIColor.Red.red50
        ribbonView.textColor = .white
        ribbonView.gravity = .start

        ribbonView.anchorToView(
            rootParent: stampCard,
            targetView: stampCard
        )
    }
    
    private func UIRibbonNew() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "Baru!"
        ribbonView.triangleColor = UIColor.Orange.orange30
        ribbonView.containerStartColor = UIColor.Yellow.yellow30
        ribbonView.containerEndColor = UIColor.Orange.orange30
        ribbonView.textColor = .white
        ribbonView.gravity = .end

        ribbonView.anchorToView(
            rootParent: stampCard,
            targetView: vQuantity,
            verticalAlignment: .top,
            offsetX: 21
        )
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        let widthConstraint = stampCard.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = stampCard.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }
    
}
