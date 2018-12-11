import UIKit

enum BookTypes: String {
    case swift = "swift"
    case kotlin = "kotlin"
    case php = "php"
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
    var booksDelegate: JBooksDelegate?
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

// Jeremy's Library
class JeremyLibrary {
    var books = [Book]()
    var bookString = [String]()
    
    func getLibraryBooks(from getBooks: [JerermyBaseBooks]) {
        var libraryBooks = [Book]()
        getBooks.forEach { (books) in
            libraryBooks += books.exportBooks()
        }
        self.books = libraryBooks
        print("獲取 \(libraryBooks.count) 本書籍")
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

/* Jeremy 實例化 */
let swiftBooks = JeremySwiftBooks(type: .swift, amounts: 4)
let kotlinBooks = JeremyKotlinBooks(type: .kotlin, amounts: 4)
let phpBooks = JeremyPhpBooks(type: .php, amounts: 4)

// 測試
let library = JeremyLibrary()
library.getLibraryBooks(from: [swiftBooks, kotlinBooks, phpBooks])
library.searchBooks(category: .swift, keyword: nil)
