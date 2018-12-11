import UIKit

/* 00 */

protocol ZBooksDelegate {
    func ShowMeYourName() -> String
    func ShowMeYourCategory() -> String
}

struct Swift: ZBooksDelegate {
    func ShowMeYourCategory() -> String {
        return self.category
    }
    
    func ShowMeYourName() -> String {
        return self.name
    }
    
    var name: String
    var category: String
    var isbn: Int
}

struct Kotlin: ZBooksDelegate {
    func ShowMeYourCategory() -> String {
        return self.category
    }
    
    func ShowMeYourName() -> String {
        return self.name
    }
    
    var name: String
    var category: String
    var isbn: Int
}

struct Php: ZBooksDelegate {
    func ShowMeYourCategory() -> String {
        return self.category
    }
    
    func ShowMeYourName() -> String {
        return self.name
    }
    
    var name: String
    var category: String
    var isbn: Int
}

/* Jeremy */
enum BookTypes: String {
    case swift = "swift"
    case kotlin = "kotlin"
    case php = "php"
}

enum SearchType {
    case name
    case category
}

struct Book {
    var name: String
    var category: BookTypes
}

protocol JBooksDelegate {
    var books: [Book] {get}
    func exportBooks() -> [Book]
}

extension JBooksDelegate {
    func exportBooks() -> [Book] {
        return books
    }
}

class JerermyBaseBooks: JBooksDelegate {
    var books = [Book]()
    init(type: BookTypes, amounts: Int) {
        for number in 1...amounts {
            let book = Book(name: "\(type.rawValue) Book (\(number))", category: type)
            books.append(book)
        }
    }
}

class JeremySwiftBooks:JerermyBaseBooks {
    
}

class JeremyKotlinBooks:JerermyBaseBooks {
    
}

class JeremyPhpBooks:JerermyBaseBooks {
    
}

class JeremyLibrary {
    var books = [Book]()
    
    func getLibraryBooks(from getBooks: [JerermyBaseBooks]) {
        var libraryBooks = [Book]()
        getBooks.forEach { (books) in
            libraryBooks += books.exportBooks()
        }
        self.books = libraryBooks
    }
    
    
    // New Functions:
    func getLibraryBooks(from getBooks: [Any]) {
        var libraryBooks = [Book]()
        getBooks.forEach { (books) in
            if let books = books as? JerermyBaseBooks {
                libraryBooks += books.exportBooks()
            } else if let books = books as? [ZBooksDelegate] {
                books.forEach({ (book) in
                    let book = Book(name: book.ShowMeYourName(), category: BookTypes(rawValue: book.ShowMeYourCategory())!)
                    libraryBooks.append(book)
                })
            }
        }
        
        self.books = libraryBooks
    }
    
    func searchBooks(category: BookTypes?, keyword:String?) {
        var matchedBooks = [Book]()
        books.forEach { (book) in
            if category != nil {
                if book.category != category! {
                    return
                }
            }
            
            if keyword != nil {
                if !book.name.lowercased().contains(keyword!.lowercased()) {
                    return
                }
            }
            
            matchedBooks.append(book)
        }
        print("======== 搜尋到 \(matchedBooks.count) 本書籍 ========")
        for book in matchedBooks {
            print(book.name)
        }
        print("================================")
    }
}

/* 實例化 */
let swiftBooks = JeremySwiftBooks(type: .swift, amounts: 4)
let kotlinBooks = JeremyKotlinBooks(type: .kotlin, amounts: 4)
let phpBooks = JeremyPhpBooks(type: .php, amounts: 4)
var zswiftBooks = [Swift]()
var zkotlinBooks = [Kotlin]()
var zphpBooks = [Php]()

for i in 1...4 {
    let book = Swift(name: "swift" + "\(i)", category: "swift", isbn: i)
    zswiftBooks.append(book)
}

for i in 1...4 {
    let book = Kotlin(name: "kotlin" + "\(i)", category: "kotlin", isbn: i)
    zkotlinBooks.append(book)
}

for i in 1...4 {
    let book = Php(name: "php" + "\(i)", category: "php", isbn: i)
    zphpBooks.append(book)
}

// 測試
let library = JeremyLibrary()
library.getLibraryBooks(from: [swiftBooks, kotlinBooks, phpBooks,zswiftBooks,zkotlinBooks,zphpBooks])
library.searchBooks(category: .swift, keyword: nil)
