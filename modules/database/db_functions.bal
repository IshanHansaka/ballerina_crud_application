import ballerina/sql;

// Define the function to fetch books from the database.
public isolated function getBooks() returns Book[]|sql:Error {

    // Execute the query and return a stream of Book records.
    stream<Book, sql:Error?> resultStream = dbClient->query(getBooksQuery());

    return check from Book book in resultStream select book;
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
