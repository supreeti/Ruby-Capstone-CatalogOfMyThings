CREATE TABLE Item (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    genre_id INT,
    author_id INT,
    label_id INT,
    publish_date DATE,
    archived BOOLEAN,
    FOREIGN KEY (genre_id) REFERENCES Genre(id),
    FOREIGN KEY (author_id) REFERENCES Author(id),
    FOREIGN KEY (label_id) REFERENCES Label(id)
);

CREATE INDEX idx_genre_id ON Item (genre_id);
CREATE INDEX idx_author_id ON Item (author_id);
CREATE INDEX idx_label_id ON Item (label_id);

CREATE TABLE Book (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    genre_id INT,
    author_id INT,
    label_id INT,
    publish_date DATE,
    publisher VARCHAR(255),
    cover_state VARCHAR(50),
    archived BOOLEAN,
    FOREIGN KEY (genre_id) REFERENCES Genre(id),
    FOREIGN KEY (author_id) REFERENCES Author(id),
    FOREIGN KEY (label_id) REFERENCES Label(id)
);

CREATE INDEX idx_genre_id_book ON Book (genre_id);
CREATE INDEX idx_author_id_book ON Book (author_id);
CREATE INDEX idx_label_id_book ON Book (label_id);

CREATE TABLE Game (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    publish_date DATE,
    multiplayer BOOLEAN,
    last_played TIMESTAMP,
    archived BOOLEAN
);

CREATE TABLE MusicAlbum (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    genre_id INT,
    artist VARCHAR(255),
    release_date DATE,
    on_spotify BOOLEAN,
    archived BOOLEAN,
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

CREATE INDEX idx_genre_id_music_album ON MusicAlbum (genre_id);

CREATE TABLE Author (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

CREATE TABLE Genre (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255)
);

CREATE TABLE Label (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    color VARCHAR(50)
);
