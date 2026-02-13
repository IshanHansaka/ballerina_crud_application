import ballerina_crud_application.database;

import ballerina/http;
import ballerina/log;
import ballerina/sql;

service / on new http:Listener(9090) {

    // Resource function to get all books.
    resource function get books() returns database:Book[]|http:InternalServerError {

        database:Book[]|error books = database:getAllBooks();

        if books is error {
            string customError = string `DB Connection Failed`;
            log:printError(customError);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        return books;
    }

    // Resource function to book by id.
    resource function get books/[int id]() returns database:Book|http:NotFound|http:InternalServerError {
        database:Book|error? response = database:getBookById(id);

        // Handle : database read error.
        if response is error {
            string customError = string `Error occurred while retrieving book data!`;
            log:printError(customError, response);
            return <http:InternalServerError>{
                body: {
                    message: customError
                }
            };
        }

        // Handle : not found error.
        if response is () {
            string customError = string `Book not found for ID: ${id}`;
            log:printError(customError);
            return <http:NotFound>{
                body: {
                    message: customError
                }
            };
        }

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

    resource function delete books/[int id]() returns http:NoContent|http:NotFound|http:InternalServerError {
        sql:ExecutionResult|error? response = database:deleteBook(id);

        if response is error {
            string customError = string `Error while deleting book`;
            log:printError(customError);
            return <http:InternalServerError>{
                body: customError
            };
        }

        if response?.affectedRowCount == 0 {
            string customError = string `Book with ID ${id} not found`;
            log:printError(customError);
            return <http:NotFound>{
                body: customError
            };
        }

        return http:NO_CONTENT;
    }

    resource function patch books/[int id](database:BookUpdate book) returns http:NoContent|http:NotFound|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:updateBook(id, book);

        if response is error {
            return <http:InternalServerError>{
                body: "Error while updating book"
            };
        }

        return http:NO_CONTENT;
    }
}
