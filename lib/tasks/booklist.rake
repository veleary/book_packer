desc "Fetch Booklist Details"

task :fetch_book_details => :environment do
  require 'nokogiri'  
  Book.all.each do |book|
    doc = Nokogiri::HTML(File.read("data/#{book.filename}")) 
    # Retrieve Title Information  
    full_title = doc.at_css("#btAsinTitle").text
    last_word = full_title.split("\s").last
    title = full_title.chomp(last_word)

    # Retrieve Author Information
    author = doc.at_css(".buying span a").text 

    # Retrieve Price Information
    price = doc.at_css(".bb_price").text[/[0-9\.\S0-9]+/]

    # Retrieve Ship Weight Information 
    ship_weight = doc.at_css("#productDetailsTable li:nth-child(7)").text[/[0-9\.]+/]

    # Retrieve ISBN-10 Information
    full_isbn10= doc.at_css("#productDetailsTable li:nth-child(4)").text
    isbn10 = full_isbn10.split("\s").last

    # Retrieve ISBN-13 Information
    full_isbn13 = doc.at_css("#productDetailsTable li:nth-child(5)").text
    isbn13 = full_isbn13.split("\s").last

    # Retrieve Total Pages Information
    total_pages = doc.at_css("#productDetailsTable li:nth-child(1)").text[/[0-9\.]+/]

    # Retrieve Publisher Information
    publisher = doc.at_css("#productDetailsTable li:nth-child(2)").text[/(?<=\s).*/]

    # Retrieve Language Information
    language = doc.at_css("#productDetailsTable li:nth-child(3)").text[/(?<=\s).*/]

    # description = doc.at_css("#postBodyPS div").text 

    book.update_attributes(title: title, author: author, price: price, ship_weight: ship_weight, isbn10: isbn10, isbn13: isbn13, total_pages: total_pages, publisher: publisher, language: language)
   end
  
  # File for Book 20 has a different HTML format for the shipping weight compared to the other files
  book20 = Book.find_by_filename("book20.html")
  new_doc = Nokogiri::HTML(File.read("data/#{book20.filename}"))
  ship_weight = new_doc.at_css("#productDetailsTable li:nth-child(6)").text[/[0-9\.]+/]
  book20.update_attributes(ship_weight: ship_weight)

  # File for Book 12 has a different HTML format compared to the other files
  book = Book.find_by_filename("book12.html")
  book12 = Nokogiri::HTML(File.read("data/#{book.filename}"))
  language = book12.at_css("#productDetailsTable li:nth-child(4)").text[/(?<=\s).*/]
  total_pages = book12.at_css("#productDetailsTable li:nth-child(2)").text[/[0-9\.]+/]
  publisher = book12.at_css("#productDetailsTable li:nth-child(3)").text[/(?<=\s).*/]
  full_isbn10= book12.at_css("#productDetailsTable li:nth-child(5)").text
  isbn10 = full_isbn10.split("\s").last
  full_isbn13 = book12.at_css("#productDetailsTable li:nth-child(6)").text
  isbn13 = full_isbn13.split("\s").last  
  ship_weight = book12.at_css("#productDetailsTable li:nth-child(8)").text[/[0-9\.]+/]

  book.update_attributes(language: language, total_pages: total_pages, publisher: publisher, isbn10: isbn10, isbn13: isbn13, ship_weight: ship_weight)

  # File for Book 6 has a different HTML format compared to the other files
  book = Book.find_by_filename("book6.html")
  book6 = Nokogiri::HTML(File.read("data/#{book.filename}"))
  language = book6.at_css("#productDetailsTable li:nth-child(4)").text[/(?<=\s).*/]
  total_pages = book6.at_css("#productDetailsTable li:nth-child(2)").text[/[0-9\.]+/]
  publisher = book6.at_css("#productDetailsTable li:nth-child(3)").text[/(?<=\s).*/]
  full_isbn10= book6.at_css("#productDetailsTable li:nth-child(5)").text
  isbn10 = full_isbn10.split("\s").last
  full_isbn13 = book6.at_css("#productDetailsTable li:nth-child(6)").text
  isbn13 = full_isbn13.split("\s").last  
  ship_weight = book6.at_css("#productDetailsTable li:nth-child(8)").text[/[0-9\.]+/]

  book.update_attributes(language: language, total_pages: total_pages, publisher: publisher, isbn10: isbn10, isbn13: isbn13, ship_weight: ship_weight)

end
















