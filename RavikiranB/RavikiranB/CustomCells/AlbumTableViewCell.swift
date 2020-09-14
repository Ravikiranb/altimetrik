//
//  AlbumTableViewCell.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var trackImageView: LazyImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//        //selectionButton.isSelected = selected
//    }

    func updateCell(_ albumVm:AlbumViewModel) {
        trackNameLabel.text = albumVm.trackName
        artistNameLabel.text = albumVm.artistName
        collectionNameLabel.text = albumVm.collectionName
        priceLabel.text = albumVm.collectionPrice
        trackImageView.imageUrl = albumVm.imageUrl
        dateLabel.text = albumVm.releaseDate
        selectionButton.isSelected = albumVm.isSelected
    }
}
