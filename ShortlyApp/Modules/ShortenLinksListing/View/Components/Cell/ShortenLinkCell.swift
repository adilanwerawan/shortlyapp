//
//  ShortenLinkCell.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import UIKit

class ShortenLinkCell: UICollectionViewCell, ViewConfiguration{
    
    static let identifier = "ShortenLinkCell"
    
    private lazy var viewBackground = UIView()
    private lazy var horizontalStack = UIStackView()
    private lazy var originalLink = UILabel()
    private lazy var emtptyButton = UIButton(type: .custom)
    private lazy var lineView = UIView()
    private lazy var shortLink = UILabel()
    lazy var buttonBackgroundView = ButtonBackgroungViewGreenBig()
    lazy var copyLinkButton = UIButton(type: .custom)
    
    var viewModel: ShortenLinkCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupViews()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("inti(coder:) has not been implemented")
    }
    
    internal func addSubViews() {
        
        [viewBackground].forEach{
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        horizontalStack.addArrangedSubview(originalLink)
        horizontalStack.addArrangedSubview(emtptyButton)
        originalLink.translatesAutoresizingMaskIntoConstraints = false
        emtptyButton.translatesAutoresizingMaskIntoConstraints = false
        
        [horizontalStack,lineView, shortLink, buttonBackgroundView].forEach{
            viewBackground.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        buttonBackgroundView.addSubview(copyLinkButton)
        copyLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func setupConstraints() {
        
        let sideMargin = 20.0
        let heightPercent = 156.0/screenHeight
        let interItemVerticalSpacing = 10.0
        let interItemVerticalSpacingMin = 6.0
        let interItemHorizontalSpacing = 8.0
        let stackViewHeightPercent = 25.0/screenHeight
        let copyBtnheightPercent = 40.0/screenHeight
        
        emtptyButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        emtptyButton.heightAnchor.constraint(equalToConstant: 26.0).isActive = true
        
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: sideMargin),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideMargin),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideMargin),
            viewBackground.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: heightPercent)),
            viewBackground.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            horizontalStack.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: interItemVerticalSpacing),
            horizontalStack.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: interItemHorizontalSpacing),
            horizontalStack.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -interItemHorizontalSpacing),
            horizontalStack.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            horizontalStack.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: stackViewHeightPercent)),
            
            lineView.widthAnchor.constraint(equalTo: viewBackground.widthAnchor),
            lineView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: interItemVerticalSpacingMin),
            lineView.heightAnchor.constraint(equalToConstant: 2.0),
            lineView.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            
            shortLink.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: interItemVerticalSpacingMin),
            shortLink.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: interItemHorizontalSpacing),
            shortLink.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: interItemHorizontalSpacing),
            shortLink.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            
            buttonBackgroundView.topAnchor.constraint(equalTo: shortLink.bottomAnchor, constant: 10),
            buttonBackgroundView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant:sideMargin*2),
            buttonBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonBackgroundView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant:sideMargin*2),
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: copyBtnheightPercent)),
            buttonBackgroundView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -sideMargin),
            
            copyLinkButton.centerXAnchor.constraint(equalTo: buttonBackgroundView.centerXAnchor),
            copyLinkButton.centerYAnchor.constraint(equalTo: buttonBackgroundView.centerYAnchor),
            copyLinkButton.heightAnchor.constraint(equalTo: buttonBackgroundView.heightAnchor),
            copyLinkButton.widthAnchor.constraint(equalTo: buttonBackgroundView.widthAnchor)
        ])
    }
    
    internal func setupViews() {
        contentView.backgroundColor = .appBackground
        backgroundColor = .appBackground
        viewBackground.backgroundColor = .white
        viewBackground.standardCornerRadius(value:10.0)
        
        emtptyButton.setImage(UIImage(named: "del"), for: .normal)
        
        //Stack View
        horizontalStack.axis  = NSLayoutConstraint.Axis.horizontal
        horizontalStack.distribution  = UIStackView.Distribution.fillProportionally
        horizontalStack.alignment = UIStackView.Alignment.center
        horizontalStack.spacing   = 6.0
        
        lineView.backgroundColor = .darkGray
        shortLink.textColor = .appGreen
        
        originalLink.font = .systemFont(ofSize: 17)
        shortLink.font = .systemFont(ofSize: 17)
        
        copyLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        copyLinkButton.setTitle("COPY", for: .normal)
    }

    private func setUpViewModel() {
        
        originalLink.text = viewModel.originalURL
        shortLink.text = viewModel.shortenURL
    }
    
    private func setupTargets(){
        copyLinkButton.addTarget(self, action: #selector(copyButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc private func copyButtonPressed(sender:UIButton){
        UIPasteboard.general.string = viewModel.shortenURL
        buttonBackgroundView.backgroundView.layer.backgroundColor = UIColor.appPurple?.cgColor
        copyLinkButton.setTitle("COPIED!", for: .normal)
    }
}
