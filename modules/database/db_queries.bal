import ballerina/sql;

isolated function getBooksQuery() returns sql:ParameterizedQuery => `
SELECT
        id,
        title,
        author,
        published_year,
        genre,
        price,
        quantity
    FROM
        book;
`;

isolated function insertBookQuery(BookCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO book
        (
            title,
            author,
            published_year,
            genre,
            price,
            quantity
        )
    VALUES
        (
            ${payload.title},
            ${payload.author},
            ${payload.publishedYear},
            ${payload.genre},
            ${payload.price},
            ${payload.quantity}
        )
`;

isolated function deleteBookQuery(int bookId) returns sql:ParameterizedQuery => `
    DELETE FROM book WHERE id = ${bookId}
`;

isolated function updateBookQuery(int bookId, BookUpdate payload) returns sql:ParameterizedQuery => `
    UPDATE book
        SET 
            title = COALESCE(${payload.title}, title),
            author = COALESCE(${payload.author}, author),
            published_year = COALESCE(${payload.publishedYear}, published_year),
            genre = COALESCE(${payload.genre}, genre),
            price = COALESCE(${payload.price}, price),
            quantity = COALESCE(${payload.quantity}, quantity)
        WHERE id = ${bookId}
`;
