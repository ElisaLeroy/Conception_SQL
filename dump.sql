CREATE DATABASE IF NOT EXISTS game;
#drop database game;

CREATE TABLE users
(
    id                   INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    login                varchar(50)     NOT NULL,
    password             varchar(50)     NOT NULL,
    connection_statement boolean         NOT NULL,
    register_date        date            NOT NULL,
    avatar               varchar(150),
    pseudo               varchar(50)     NOT NULL,
    birthday             date            NOT NULL,
    is_adult             boolean         NOT NULL,
    is_admin             boolean         NOT NULL,
    parental_consent     boolean DEFAULT FALSE
);

CREATE TABLE colors
(
    id      INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    red     int(10),
    green   int(10),
    blue    int(10),
    opacity int(10)
);

CREATE TABLE pawns
(
    id              INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    is_pawn_default boolean         NOT NULL,
    pawn_pattern    varchar(100),
    pawn_type       varchar(50),
    pawn_favorite   boolean,
    color_id        int,
    FOREIGN KEY (color_id) REFERENCES colors (id),
    user_id         int,
    FOREIGN KEY (user_id) REFERENCES users (id)
);



CREATE TABLE boards
(
    id       INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    length   int,
    name     varchar(50),
    zoom     int(3),
    color_id int,
    FOREIGN KEY (color_id) REFERENCES colors (id)
);


CREATE TABLE rules
(
    id          INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    description varchar(255),
    pawn_id     int,
    board_id    int,
    FOREIGN KEY (pawn_id) REFERENCES pawns (id),
    FOREIGN KEY (board_id) REFERENCES boards (id)
);


CREATE TABLE games
(
    id      INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    rule_id int,
    FOREIGN KEY (rule_id) REFERENCES rules (id)
);

CREATE TABLE moves
(
    id      INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id int,
    pawn_id int,
    game_id int,
    date    date,
    x       int,
    y       int,
    FOREIGN KEY (pawn_id) REFERENCES pawns (id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (game_id) REFERENCES games (id)
);


CREATE TABLE tokenOffers
(
    id       INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    quantity int,
    price    float
);

CREATE TABLE purchases
(
    user_id int,
    offer_id int,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (offer_id) REFERENCES tokenOffers (id)
);

CREATE TABLE parents(
    parent_id int,
    child_id int,
    FOREIGN KEY (parent_id) REFERENCES users (id),
    FOREIGN KEY (child_id) REFERENCES users (id)
)