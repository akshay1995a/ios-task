import UIKit
import RxSwift


/**
 The cell which displays a campaign.
 */
class CampaignCell: UICollectionViewCell {

    /** Used to arrange of self sizing. */
    @IBOutlet private var imageViewWitdhCnst: NSLayoutConstraint! {
        didSet {
            imageViewWitdhCnst.isActive = false
        }
    }
    
    /** Used to arrange of self sizing. */
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else { return }
            imageViewWitdhCnst.isActive = true
            imageViewWitdhCnst.constant = maxWidth
        }
    }
    
    private let disposeBag = DisposeBag()

    /** Used to display the campaign's title. */
    @IBOutlet private(set) weak var nameLabel: UILabel!

    /** Used to display the campaign's description. */
    @IBOutlet private(set) weak var descriptionLabel: UILabel!

    /** The image view which is used to display the campaign's mood image. */
    @IBOutlet private(set) weak var imageView: UIImageView!

    /** The mood image which is displayed as the background. */
    var moodImage: Observable<UIImage>? {
        didSet {
            moodImage?
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] image in
                    self?.imageView.image = image
                    })
                .disposed(by: disposeBag)
        }
    }

    /** The campaign's name. */
    var name: String? {
        didSet {
            nameLabel?.text = name
        }
    }

    var descriptionText: String? {
        didSet {
            descriptionLabel?.text = descriptionText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        assert(nameLabel != nil)
        assert(descriptionLabel != nil)
        assert(imageView != nil)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
