require_relative('../db/sql_runner')
require_relative('./album')

class Artist

    attr_reader :id, :name

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO artists (
                name
            ) VALUES (
                $1
            ) RETURNING id;"
        values = [@name]
        artist_id = SqlRunner.run(sql, values)[0]['id'].to_i
        @id = artist_id
    end

    def self.all()
        sql = "SELECT * FROM artists"
        all_artists = SqlRunner.run(sql)
        array_of_artist_objects = all_artists.map { |artist| Artist.new(artist) }
        return array_of_artist_objects
    end

    def albums()
        sql = "SELECT * FROM albums WHERE id = $1"
        values = [@id]
        matching_albums = SqlRunner.run(sql, values)
        array_of_album_objects = matching_albums.map { |album| Album.new(album) }
        return array_of_album_objects
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [id]
        result = SqlRunner.run(sql, values)[0]
        return nil if result == nil
        artist = Artist.new(result)
        return artist
    end

end