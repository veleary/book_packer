module BooksHelper
  
  # Make my list of book shipping weights
  # This calls the create_box method to start the packing process
  def ship_weight_list(books)
    @weights = []
    books.each do |book|       
      @weights << book.ship_weight     
    end 
    @boxes = []
    create_box(1, 0)
  end

  # This creates a box which is a hash with a number, the boxes total weight, and the boxes contents (in this case the books that will be shipped in this box)
  def create_box(id, weight)        
    box = {"box" => {"id" => id, "total_weight" => weight, "contents" => []}}
    @boxes << box      
    pack_books
  end

  
  # This adds up the books' weights and determines which box the books need to be placed. This also adds all the content information for each book that is added to the box. This will be used in the JSON output. 
  def pack_books       
    @weights.each_with_index do  |weight, index|
      box = @boxes.last
      sum = weight.to_f + box["box"]["total_weight"]
      if  sum <= 10
        box["box"]["total_weight"] += weight.to_f
        book = Book.find_by_ship_weight(weight)
        content_info = {
          "title:" => book.title, 
          "author:" => book.author,       
          "price:" => book.price,
          "ship_weight:" => book.ship_weight,
          "isbn10:" => book.isbn10,
          "isbn13:" => book.isbn13,
          "total_pages:" => book.total_pages,
          "publisher:" => book.publisher,
          "language:" => book.language
        }
        box["box"]["contents"] << content_info
        @weights.delete_at(index)
      else
        new_box_id = box["box"]["id"] + 1
        create_box(new_box_id, 0)       
      end
    end
  end
end
