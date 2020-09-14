//
//  SearchListViewController.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController {

    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var tblView: UITableView!
    var albumListVM: AlbumListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchResults()
    }
    

    func fetchResults(){
        WebService().getAlbums() { albums in
            if let albums = albums {
                self.albumListVM = AlbumListViewModel.init(albums)
                
                self.tblView.reloadData()
            }
        }
    }
    
   
    
    //MARK:- Actions
    @IBAction func changeSort(_ sender: Any) {
        let type = SortType.init(rawValue: sortSegment.selectedSegmentIndex)
        albumListVM?.sortAlbums(type)
        tblView.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController, let options = navigation.viewControllers.first as? SearchOptionsViewController {
            options.delegate = self
        }
    }
}

//MARK:- TableVIew
extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumListVM?.numberOfAlbums() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as! AlbumTableViewCell
        if let albumVM = albumListVM?.albumAtIndex(indexPath.row) {
            cell.updateCell(albumVM)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumListVM?.selectAlbumAtIndex(indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}


extension SearchListViewController: SearchOptionsViewControllerDelegate {
    func filterAlbums(_ searchOptions: SearchOptionViewModel) {
        albumListVM?.filterOptions = searchOptions
        albumListVM?.filterAlbums()
        tblView.reloadData()
    }
    
    
    
}
