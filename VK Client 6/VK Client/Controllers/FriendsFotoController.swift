//
//  FriendsFotoController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift

class FriendsFotoController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var id = 0
    var friendName = ""
    var friendGallery: [Photo] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = friendName
        
        collectionView.delegate = self
        
        userService.loadUserPhotos(id: id) { [weak self] in
            self?.loadData()
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - Load Data
    
    func loadData() {
        do {
            let realm = try Realm()
            let photos = realm.objects(Photo.self)
            self.friendGallery = Array(photos)
        } catch {
            print(error)
        }
    }
    
    // MARK: -  UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendGallery.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsFotoCell", for: indexPath) as! FriendsFotoCell
    
    if let url = URL(string: (friendGallery[indexPath.row].sizes.last!.url)) {
            let data = try? Data(contentsOf: url)
            cell.friendImage.image = UIImage(data: data!)
        } else {
            cell.friendImage.image = UIImage(systemName: "person.fill")
        }
        
        let button = ILikeButton(frame: CGRect(x: 112, y: 128, width: 60, height: 20))
        cell.addSubview(button)
    
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? FullScreenPhotoViewController {

            controller.friendsImage = friendGallery
            controller.index = collectionView.indexPathsForSelectedItems?.first?.row ?? 0
        }
    }
   
}
