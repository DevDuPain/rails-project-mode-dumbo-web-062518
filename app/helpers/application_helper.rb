module ApplicationHelper

  def randomized_background_image
    images = ["./assets/stockphotos/image1.jpg",
      "./assets/stockphotos/image2.jpg",
      "./assets/stockphotos/image3.jpg",
      "./assets/stockphotos/image4.jpg",
      "./assets/stockphotos/image5.jpg",
      "./assets/stockphotos/image6.jpg"
    ]
    images[rand(images.size)]
  end
end
