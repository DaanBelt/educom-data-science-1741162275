SELECT AlbumId, COUNT(TrackId)
FROM Track 
GROUP BY AlbumId 
HAVING COUNT(TrackId) >= 12