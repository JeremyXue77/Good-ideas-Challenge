# 新手村 Code Level 2



## 今天我們來開一間圖書館

> 這裏為你準備了 3 種分類（`Swift` / `Kotlin` / `PHP`) 的書籍，
>
> 共計 12 本。

### 請選擇其中一個進行挑戰：

#### Stage - 1
請提供兩個方法用來搜尋書籍：

- `searchBooksByName()`
- `searchBooksByCategory()`

#### Stage - 2

- 為三種分類的書籍建立書庫, 例如 `class DonSwiftBooks`
- 建立一個圖書館，例如 `DonLibrary`
- 只為你的圖書館提供一個方法，調用這可以選擇要用 `category` 或者 `name` 來進行搜尋。

### 規則：

- 建立 `class`, 命名規則為：自己的英文名稱 +` class 名稱`，例如 `class DonLibrary`
- `searchBooksByName` 為模糊搜尋，比如 `keyword` 是 s, 就要返回包含 s 的書籍，比如 Swift
- `searchBooksByCategory` 需要提供完整的分類名稱，比如 Swift, 會返回 Swift 相關的書籍.



---

## 實作

### Stage - 2

> 這邊直接略過 Stage - 1，從 Stage - 2 開始

首先先定義書籍分類 `enum`，以及書籍 `struct`：

```swift
enum BookTypes: String {
    case swift = "swift"
    case kotlin = "kotlin"
    case php = "php"
}

struct Book {
    var name: String
    var category: BookTypes
}
```

接著定義一個 `protocol` 並且 `extension ` `JBookDelegate` 中的 `expoertBooks()`，讓我們定義時做的方法：

```
protocol JBooksDelegate {
    var books: [Book] {get}
    func exportBooks() -> [Book]
}

extension JBooksDelegate {
    func exportBooks() -> [Book] {
        return books
    }
}
```

在定義一個作為 `base class` 的 ` JerermyBaseBooks` ，並且讓它遵循上面的 `protocol`：

```Swift
class JerermyBaseBooks: JBooksDelegate {
    var books = [Book]()
    
    // 這邊自訂一個創建假資料的初始化方法
    init(type: BookTypes, amounts: Int) {
        for number in 1...amounts {
            let book = Book(name: "\(type.rawValue) Book (\(number))", category: type)
            books.append(book)
        }
    }
}
```

接著其他三個書庫只需要繼承這個 class 即可：

```swift
class JeremySwiftBooks:JerermyBaseBooks {
    
}

class JeremyKotlinBooks:JerermyBaseBooks {
    
}

class JeremyPhpBooks:JerermyBaseBooks {
    
}
```

我們可以個別使用 `JeremyBaseBooks` 中的 `init(type:,amounts:)` 來初始化它：

```swift
// 透過對應的 type 初始化每個 class
let swiftBooks = JeremySwiftBooks(type: .swift, amounts: 4)
let kotlinBooks = JeremyKotlinBooks(type: .kotlin, amounts: 4)
let phpBooks = JeremyPhpBooks(type: .php, amounts: 4)
```

接著我們會寫一個 `Lirbrary` 的 `class` ，其中我們會有方法去取得這些書庫的所有書籍，以及根據關鍵字以及分類搜索這些書籍：

```swift
class JeremyLibrary {
    var books = [Book]()
    var bookString = [String]()
    
    // 獲得書庫書籍
    func getLibraryBooks(from getBooks: [JerermyBaseBooks]) {
        var libraryBooks = [Book]()
        // 循環 getBooks 並把這些 Array 疊加到 libraryBooks 中
        getBooks.forEach { (books) in
            libraryBooks += books.exportBooks()
        }
        // 將 libraryBooks 賦予給 JeremyLibrary 的 books
        self.books = libraryBooks
    }
    
    // 搜尋書籍方法，同時可以丟入 category 跟 keyword 搜尋
    func searchBooks(category: BookTypes?, keyword:String?) {
        var matchedBooks = [Book]()
        books.forEach { (book) in
            // 判斷是否有 category，有則會判斷是否符合，否則 return
            if category != nil {
                if book.category != category! {
                    return
                }
            }
            // 判斷是否有 keyword，有則會判斷是否包含，否則 return
            if keyword != nil {
                if !book.name.lowercased().contains(keyword!.lowercased()) {
                    return
                }
            }
            
            matchedBooks.append(book)
        }
        // 輸出結果
        print("======== 搜尋到 \(matchedBooks.count) 本書籍 ========")
        for book in matchedBooks {
            print(book.name)
        }
        print("================================")
    }
}
```

