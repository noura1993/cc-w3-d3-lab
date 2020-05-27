require_relative('./artist')
require_relative('../db/sql_runner')

class Album

    attr_reader :title, :genre, :id

    def initialize(options)
        @title = options["title"]
        @id = options["id"].to_i if options["id"]
        @genre = options["genre"]
        @artist_id = options["artist_id"].to_i
    end

    # def artist_id()
    # end

    def save()
        sql = "INSERT INTO albums 
        (
            title,
            genre,
            artist_id
        )
        VALUES
        (
            $1, $2, $3
        )
        RETURNING id;"
        values = [@title, @genre, @artist_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def self.all()
        sql = "SELECT * FROM albums;"
        album_hashes = SqlRunner.run(sql)
        albums = album_hashes.map{ |album| Album.new(album)}
        return albums
    end

    def artist()
        sql = "SELECT * FROM artists WHERE id = $1"
        values = [@artist_id]
        results = SqlRunner.run(sql, values)[0]
        artist = Artist.new(results)
        return artist
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM albums WHERE id = $1;"
        values = [id]
        result = SqlRunner.run(sql, values)[0]
        return nil if result == nil
        album = Album.new(result)
        return album
    end

end