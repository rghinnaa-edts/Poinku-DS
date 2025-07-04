//
//  PoinLoyaltyPageViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 18/03/25.
//

import UIKit

class PoinLoyaltyPageViewController: UIViewController {
    
    @IBOutlet var viewToolbar: UIView!
    @IBOutlet var searchBar: SearchBar!
    @IBOutlet var viewNavBar: UIStackView!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnHelp: UIButton!
    
    @IBOutlet var viewChip: UIView!
    @IBOutlet var chipShort: UIView!
    @IBOutlet var chipDivider: UIView!
    @IBOutlet var collectionChip: UICollectionView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var viewPoinTop: UIView!
    @IBOutlet var ivPoinTop: UIImageView!
    @IBOutlet var lblTitleTop: UILabel!
    @IBOutlet var lblPoinTop: UILabel!
    
    @IBOutlet var viewPoin: UIView!
    @IBOutlet var ivPoin: UIImageView!
    @IBOutlet var lblTitlePoin: UILabel!
    @IBOutlet var lblPoin: UILabel!
    
    @IBOutlet var lblSection: UILabel!
    @IBOutlet var collectionViewProduct: UICollectionView!
    
    var short: [ShortChip] = []
    private var viewPoinTopConstraints: [NSLayoutConstraint] = []
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var originalSearchBarAnchorPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        setupUI()
        
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupToolbar()
        setupChip()
        setupCollectionChip()
        loadChipShort()
        setupViewPoinTop()
        setupViewPoin()
        setupCollectionProduct()
        
        lblSection.text = "Tukar Poin Loyalti ke Kupon-kupon Ini"
        lblSection.textColor = UIColor.Grey.grey70
        lblSection.font = Font.H3.font
    }
    
    private func setupToolbar() {
        lblTitle.text = "Tukarkan Poin Loyalty"
        lblTitle.font = Font.H1.font
        
        btnBack.setTitle("", for: .normal)
        btnSearch.setTitle("", for: .normal)
        btnHelp.setTitle("", for: .normal)
        
        if let searchImage = btnSearch.image(for: .normal) {
            let resizedSearchImage = resizeImage(image: searchImage, targetSize: CGSize(width: 24, height: 24))
            btnSearch.setImage(resizedSearchImage, for: .normal)
        }
        
        if let helpImage = btnHelp.image(for: .normal) {
            let resizedHelpImage = resizeImage(image: helpImage, targetSize: CGSize(width: 24, height: 24))
            btnHelp.setImage(resizedHelpImage, for: .normal)
        }
    }
    
    
    private func setupChip() {
        viewChip.backgroundColor = .white
        viewChip.layer.shadowOpacity = 0.15
        viewChip.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        viewChip.layer.shadowRadius = 3.0
        
        chipShort.layer.borderWidth = 1
        chipShort.layer.borderColor = UIColor.blue30.cgColor
        chipShort.layer.cornerRadius = 12
        chipShort.backgroundColor = .primaryHighlightWeak
        
//        chipShort.text = "Urutkan"
//        chipShort.image = UIImage(named: "sort")
//        chipShort.isActive = true
//        chipShort.textColorActive = UIColor.Blue.blue30
//        chipShort.activeColor = UIColor.Support.primaryHighlightWeak
//        chipShort.borderActiveColor = UIColor.Blue.blue30.cgColor
        
        chipDivider.backgroundColor = UIColor.Grey.grey30
    }
    
    func setupCollectionChip() {
        let shortFlowLayout = UICollectionViewFlowLayout()
        shortFlowLayout.scrollDirection = .horizontal
        shortFlowLayout.minimumLineSpacing = 8
        shortFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16)
        shortFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionChip.collectionViewLayout = shortFlowLayout
        collectionChip.backgroundColor = .clear
        collectionChip.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionChip.showsHorizontalScrollIndicator = false
        collectionChip.alwaysBounceHorizontal = true
        collectionChip.decelerationRate = .normal
        collectionChip.register(ChipCollectionViewCell.self, forCellWithReuseIdentifier: "ChipCollectionViewCell")
        
        collectionChip.delegate = self
        collectionChip.dataSource = self
    }
    
    func setupViewPoinTop() {
        viewPoinTopConstraints = viewPoinTop.constraints
        
        NSLayoutConstraint.deactivate(viewPoinTopConstraints)
        viewPoinTop.isHidden = true
        
        viewPoinTop.backgroundColor = .white
        viewPoinTop.layer.shadowOpacity = 0.15
        viewPoinTop.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        viewPoinTop.layer.shadowRadius = 3.0
        
        ivPoinTop.image = UIImage(named: "poin-loyalty")
        
        lblTitleTop.text = "Kamu punya:"
        lblTitleTop.textColor = UIColor.Grey.grey50
        lblTitleTop.font = Font.Body.B3.Small.font
        
        lblPoinTop.text = "2480 Poin Loyalty"
        lblPoinTop.textColor = UIColor.Grey.grey70
        lblPoinTop.font = Font.Body.B3.Medium.font
    }
    
    func setupViewPoin() {
        viewPoin.layer.cornerRadius = 28
        viewPoin.backgroundColor = UIColor.white
        viewPoin.layer.shadowOpacity = 0.15
        viewPoin.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewPoin.layer.shadowRadius = 3.0
        
        ivPoin.image = UIImage(named: "poin-loyalty")
        
        lblTitlePoin.text = "Kamu punya:"
        lblTitlePoin.textColor = UIColor.Grey.grey50
        lblTitlePoin.font = Font.Body.B3.Small.font
        
        lblPoin.text = "2480 Poin Loyalty"
        lblPoin.textColor = UIColor.Grey.grey70
        lblPoin.font = Font.H3.font
    }
    
    private func setupCollectionProduct() {
        let layout = StaggeredLayout()
        layout.delegate = self
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 12
        
        collectionViewProduct.collectionViewLayout = layout
        collectionViewProduct.backgroundColor = .clear
        collectionViewProduct.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionViewProduct.delegate = self
        collectionViewProduct.dataSource = self
        collectionViewProduct.register(PoinCardCell.self, forCellWithReuseIdentifier: "PoinCardCell")
    }
    
    func loadChipShort() {
        short = [
            ShortChip(id: "1", name: "Semua"),
            ShortChip(id: "2", name: "Food & Beverage"),
            ShortChip(id: "3", name: "Detergent")
        ]
        
        collectionChip.reloadData()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = searchBar
        searchBar.placeholderText = "Cari Kupon"
    }
    
    private func addTapGestureToHideSearchBar() {
        if let existingGesture = tapGestureRecognizer {
            view.removeGestureRecognizer(existingGesture)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideSearchBar))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        tapGestureRecognizer = tapGesture
    }
    
    private func removeTapGesture() {
        if let existingGesture = tapGestureRecognizer {
            view.removeGestureRecognizer(existingGesture)
            tapGestureRecognizer = nil
        }
    }
    
    @objc private func handleTapOutsideSearchBar(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        if !searchBar.frame.contains(location) && searchBar.text?.isEmpty ?? true {
            hideSearchBar()
        }
    }
    
    private func hideSearchBar() {
        searchBar.resignFirstResponder()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.searchBar.alpha = 0
        }, completion: { _ in
            self.searchBar.isHidden = true
            self.searchBar.transform = .identity
            self.searchBar.layer.anchorPoint = self.originalSearchBarAnchorPoint
            
            if let superview = self.searchBar.superview {
                self.searchBar.center = CGPoint(
                    x: superview.bounds.midX,
                    y: self.searchBar.center.y
                )
            }
            
            self.removeTapGesture()
            
            self.viewNavBar.isHidden = false
            self.viewNavBar.alpha = 0
            
            UIView.animate(withDuration: 0.2, animations: {
                self.viewNavBar.alpha = 1
            })
        })
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        originalSearchBarAnchorPoint = searchBar.layer.anchorPoint
        
        searchBar.alpha = 0
        searchBar.isHidden = false
        
        let buttonPositionInWindow = btnSearch.convert(btnSearch.bounds.origin, to: searchBar.superview)
        
        let buttonCenterX = buttonPositionInWindow.x + btnSearch.bounds.width/2
        let buttonCenterY = buttonPositionInWindow.y + btnSearch.bounds.height/2
        
        let originX = (buttonCenterX - searchBar.center.x) / searchBar.bounds.width + 0.5
        let originY = (buttonCenterY - searchBar.center.y) / searchBar.bounds.height + 0.5
        
        searchBar.layer.anchorPoint = CGPoint(x: originX, y: originY)
        searchBar.center = CGPoint(
            x: searchBar.center.x + (originX - 0.5) * searchBar.bounds.width,
            y: searchBar.center.y + (originY - 0.5) * searchBar.bounds.height
        )
        
        searchBar.transform = CGAffineTransform(scaleX: 0.1, y: 1)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.viewNavBar.alpha = 0
        }, completion: { _ in
            self.viewNavBar.isHidden = true
            self.viewNavBar.transform = .identity
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.searchBar.alpha = 1
            self.searchBar.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.searchBar.transform = .identity
            }, completion: { _ in
                self.searchBar.becomeFirstResponder()
                self.addTapGestureToHideSearchBar()
            })
        })
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

struct ShortChip {
    let id: String
    let name: String
}

extension PoinLoyaltyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionChip {
            return short.count
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionChip {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChipCollectionViewCell", for: indexPath) as! ChipCollectionViewCell
            
            let short = short[indexPath.item]
            cell.text = short.name
            cell.isClickable = true

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoinCardCell", for: indexPath) as! PoinCardCell
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath, width: CGFloat) -> CGSize {
        
        if collectionView == collectionChip {
            let collectionViewWidth = collectionView.bounds.width
            let estimatedCellWidth = Int(collectionViewWidth * 0.4)
            
            let height = 20
            
            return CGSize(width: estimatedCellWidth, height: height)
        } else {
            let cell = PoinCardCell()
            
            configureCell(cell, for: indexPath)
            
            let height = cell.calculateHeight(for: width)
            
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension PoinLoyaltyPageViewController: StaggeredLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let cell = PoinCardCell()
        
        configureCell(cell, for: indexPath)
        
        let height = cell.calculateHeight(for: width)
        
        return height
    }
    
    private func configureCell(_ cell: PoinCardCell, for indexPath: IndexPath) {
        // Configure with data that would affect height
        // For example:
        // cell.lblPoinCard.text = "Some text that might vary in length..."
        // cell.btnExchange.isHidden = (indexPath.item % 2 == 0)
        
        // This will depend on your specific data model
    }

}

extension PoinLoyaltyPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        
        let transitionStartOffset: CGFloat = 0
        let transitionEndOffset: CGFloat = 100
        
        let progress = max(0, min(1, scrollOffset / transitionEndOffset))
        
        UIView.animate(withDuration: 0.1) {
            
            self.viewPoin.alpha = 1 - progress
            self.viewPoinTop.alpha = progress
            self.viewChip.layer.shadowOpacity = 0
            
            let slideTransform = CGAffineTransform(
                translationX: 0,
                y: -self.viewPoinTop.frame.height * (1 - progress)
            )
            
            NSLayoutConstraint.activate(self.viewPoinTopConstraints)
            self.viewPoinTop.transform = slideTransform
        }
        
        if scrollOffset <= transitionStartOffset {
            viewPoinTop.isHidden = true
            NSLayoutConstraint.deactivate(viewPoinTopConstraints)
            
            viewChip.layer.shadowOpacity = 0.15
        } else if scrollOffset >= transitionEndOffset {
            viewChip.layer.shadowOpacity = 0
            NSLayoutConstraint.activate(viewPoinTopConstraints)
        } else {
            viewChip.layer.shadowOpacity = 0
            viewPoin.isHidden = false
            viewPoinTop.isHidden = false
        }
    }
}
