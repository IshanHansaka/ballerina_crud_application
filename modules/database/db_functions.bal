import ballerina/sql;

public isolated function getBooks() returns Book[]|sql:Error {

    stream<Book, sql:Error?> resultStream = dbClient->query(getBooksQuery());

    return check from Book book in resultStream
        select book;
}

public isolated function getBookById(int id) returns Book|sql:Error {
    return dbClient->queryRow(getBookByIdQuery(id));
}

public isolated function insertBook(BookCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertBookQuery(payload));
}

public isolated function deleteBook(int bookId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteBookQuery(bookId));
}

public isolated function updateBook(int bookId, BookUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateBookQuery(bookId, payload));
}
