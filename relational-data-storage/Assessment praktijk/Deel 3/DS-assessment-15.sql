SELECT TrackId, Album.Title, Album.ArtistId, T.Name
FROM Track T
JOIN Album ON T.AlbumId = Album.AlbumId
