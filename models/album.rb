require_relative('./artist')

class Album

    attr_reader :title, :genre, :id

    def initialize(options)
        @title = options["title"]
        @id = options["id"].to_i if options["id"]
        @genre = options["genre"]
        @artist_id = options["artist_id"].to_i
    end

    def artist_id()
    end
end