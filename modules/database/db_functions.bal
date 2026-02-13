import ballerina/sql;

public isolated function getAllBooks() returns Book[]|error {
    stream<Book, error?> bookStream = dbClient->query(getAllBooksQuery());

    Book[] books = check from var book in bookStream
        select book;

    return books;
}

public isolated function getBookById(int id) returns Book|error? {
    Book|sql:Error book = dbClient->queryRow(getBookByIdQuery(id));

    if book is sql:Error && book is sql:NoRowsError {
        return;
    }

    return book;
}

public isolated function insertBook(BookCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertBookQuery(payload));
}

public isolated function deleteBook(int bookId) returns sql:ExecutionResult|error {
    return dbClient->execute(deleteBookQuery(bookId));
}

public isolated function updateBook(int bookId, BookUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateBookQuery(bookId, payload));
}
