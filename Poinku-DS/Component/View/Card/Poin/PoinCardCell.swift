//
//  CouponCardCell.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 10/02/25.
//

import UIKit

class PoinCardCell: UICollectionViewCell {
    
    @IBOutlet var poinCard: UIView!
    @IBOutlet var ivPoinCard: UIImageView!
    @IBOutlet var vCoupon: UIView!
    @IBOutlet var lblCoupon: UILabel!
    @IBOutlet var ivCoupon: UIImageView!
    @IBOutlet var lblPoinCard: UILabel!
    @IBOutlet var vPoin: UIView!
    @IBOutlet var lblPoin: UILabel!
    @IBOutlet var btnExchange: UIButton!
    @IBOutlet var vIKupon: UIView!
    @IBOutlet var ivIKupon: UIImageView!
    @IBOutlet var lblIKupon: UILabel!
    
    var id: String = ""
    var title: String = ""
    var imageURL: String = ""
    var coupon: Int = 9
    var stampCount: Int = 0
    var price: Int = 0
    var isNew: Bool = false
    var isHotProduct: Bool = false
    var isDiscount: Bool = false
    var discountImp: Int = 0
    var size: Size = .fullSize
    
    enum Size {
        case fullSize
        case rewardWidget
        case stampPage
    }
    
    struct Product {
        let id: String
        let title: String
        let imageURL: String
        let coupon: Int
        let stampCount: Int
        let price: Int
        let isNew: Bool
        let isHotProduct: Bool
        let isDiscount: Bool
        let discountImp: Int
        let Size: Size
    }
    
    func configure(with product: Product) {
        id = product.id
        title = product.title
        imageURL = product.imageURL
        coupon = product.coupon
        stampCount = product.stampCount
        price = product.price
        isNew = product.isNew
        isHotProduct = product.isHotProduct
        isDiscount = product.isDiscount
        discountImp = product.discountImp
        size = product.Size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPoinCard()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPoinCard()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupPoinCard() {
        if let nib = Bundle.main.loadNibNamed("PoinCard", owner: self, options: nil),
           let card = nib.first as? UIView {
            poinCard = card
            poinCard.frame = contentView.bounds
            poinCard.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(poinCard)
            
            setupUI()
        } else {
            print("Failed to load PoinCard XIB")
        }
    }
    
    private func setupUI() {
        UIPoinCard()
        UICoupon()
        UIikupon()
        UIPoin()
        UIRibbonHotProduct()
    }
    
    private func UIPoinCard() {
        poinCard.layer.cornerRadius = 8
        poinCard.layer.masksToBounds = true
        
        poinCard.backgroundColor = .white
        poinCard.layer.shadowColor = UIColor.black.cgColor
        poinCard.layer.shadowOpacity = 0.15
        poinCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        poinCard.layer.shadowRadius = 3.0
        poinCard.layer.masksToBounds = false
        
        lblPoinCard.textColor = UIColor.Grey.grey70
        lblPoinCard.font = Font.Body.B3.Small.font
        
        btnExchange.titleLabel?.text = "Tukar Poin"
        btnExchange.backgroundColor = UIColor.Blue.blue30
        btnExchange.layer.cornerRadius = 4
        btnExchange.titleLabel?.textColor = .white
        btnExchange.titleLabel?.font = Font.Button.Small.font
        
        lblPoinCard.text = "Diskon Rp5.000 1 Pcs Kellogg’s Frosted Flakes 300gr"
        ivPoinCard.image = UIImage(named: "product-image")
    }
    
    private func UICoupon() {
        ivCoupon.image = if coupon < 10 && coupon > 0 {
            UIImage(named: "exclamation")
        } else {
            UIImage(named: "product-empty")
        }
        ivCoupon.image = ivCoupon.image?.withRenderingMode(.alwaysTemplate)
        
        ivCoupon.tintColor = if coupon < 10 && coupon > 0 {
            UIColor.Support.warningStrong
        } else {
            UIColor.Support.errorStrong
        }
        
        vCoupon.backgroundColor = if coupon < 10 && coupon > 0 {
            UIColor.Support.warningWeak
        } else {
            UIColor.Support.errorWeak
        }
        
        lblCoupon.textColor = if coupon < 10 && coupon > 0 {
            UIColor.Support.warningStrong
        } else {
            UIColor.Support.errorStrong
        }
        
        lblCoupon.text = if coupon < 10 && coupon > 0 {
            "Kupon Mau Habis"
        } else {
            "Kupon Habis"
        }
        lblCoupon.font = Font.B4.Small.font
    }
    
    private func UIikupon() {
        ivIKupon.image = UIImage(named: "store-01")
        ivIKupon.image = ivIKupon.image?.withRenderingMode(.alwaysTemplate)
        ivIKupon.tintColor = UIColor.Support.primaryHighlightStrong
        
        vIKupon.backgroundColor = UIColor.Support.primaryHighlightWeak
        vIKupon.layer.cornerRadius = 8
        vIKupon.layer.borderWidth = 1
        vIKupon.layer.borderColor = UIColor.Support.primaryHighlightStrong.cgColor
        
        lblIKupon.textColor = UIColor.Support.primaryHighlightStrong
        lblIKupon.font = Font.B4.Small.font
        lblIKupon.text = "i-Kupon"
    }
    
    private func UIPoin() {
        vPoin.backgroundColor = UIColor.Support.highlightWeak
        vPoin.layer.cornerRadius = 8
        vPoin.layer.borderWidth = 1
        vPoin.layer.borderColor = UIColor.Support.warningStrong.cgColor
        
        lblPoin.textColor = UIColor.Support.warningStrong
        lblPoin.font = Font.B4.Small.font
        lblPoin.text = "5.500 Poin"
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
            rootParent: poinCard,
            targetView: poinCard
        )
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        let widthConstraint = poinCard.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = poinCard.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }
}
