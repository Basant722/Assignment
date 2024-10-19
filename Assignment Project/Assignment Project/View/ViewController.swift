//
//  ViewController.swift
//  Assignment Project
//
//  Created by Basant Kumar on 18/10/24.
//


import UIKit

// MARK: - ViewController

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var viewModel = ImageGalleryViewModel()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let searchBar = UISearchBar()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let nameTextField = CustomTextField()
    private let submitButton = CustomButton()
    private let refreshControl = UIRefreshControl() // Add refresh control

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Gallery"
        
        setupUI()
        
        // Bind the view model's update to the UI
        viewModel.onUpdate = { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
            // End refreshing if it's active
            if self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            }
        }
        
        // Fetch initial images
        Task {
            await viewModel.fetchImages()
        }
    }
    
    private func setupUI() {
        setupSearchBar()
        setupCollectionView()
        setupActivityIndicator()
        setupForm()
        
        // Set up Auto Layout for the collection view
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -10),
        ])
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search images..."
        view.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.backgroundColor = .systemBackground
        
        // Add refresh control to the collection view
        refreshControl.addTarget(self, action: #selector(refreshImages), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func setupForm() {
        view.addSubview(nameTextField)
        view.addSubview(submitButton)
        
        nameTextField.placeholder = "Enter your name"
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        // Layout the text field and button
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Place the text field above the button
            nameTextField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    @objc private func refreshImages() {
        // Fetch images again on refresh
        Task {
            await viewModel.fetchImages()
        }
    }

    @objc private func handleSubmit() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showErrorAlert(message: "Name cannot be empty!")
            return
        }

        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicator.stopAnimating()
            self.showSuccessAlert(message: "Success! Hello, \(name).")
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    // MARK: - UICollectionViewDataSource Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let imageData = viewModel.images[indexPath.item]
        cell.configure(with: imageData.urls.regular)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout Methods

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 20) / 3 // Three items per row
        return CGSize(width: width, height: width)
    }
    
    // MARK: - UISearchBarDelegate Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let query = searchBar.text {
            Task {
                await viewModel.fetchImages(query: query)
            }
        }
    }
}
