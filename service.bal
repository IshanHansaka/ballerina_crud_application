import ballerina_crud_application.database;

import ballerina/http;
import ballerina/sql;

service / on new http:Listener(9090) {

    // Resource function to get all books.
    resource function get books() returns database:Book[]|http:InternalServerError {
        // Call the getBooks function to fetch data from the database.
        database:Book[]|error response = database:getBooks();

        // If there's an error while fetching, return an internal server error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving books"
            };
        }

        // Return the response containing the list of books.
        return response;
    }

    // Resource function to add new book.
    resource function post books(database:BookCreate book) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertBook(book);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting book"
            };
        }
        return http:CREATED;
    }

    resource function delete books/[int id]() returns http:NoContent|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:deleteBook(id);

        if response is error {
            return <http:InternalServerError>{
                body: "Error while deleting book"
            };
        }

        return http:NO_CONTENT;
    }

    resource function patch books/[int id](database:BookUpdate book) returns http:NoContent|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:updateBook(id, book);

        if response is error {
            return <http:InternalServerError>{
                body: "Error while updating book"
            };
        }

        return http:NO_CONTENT;
    }
}
