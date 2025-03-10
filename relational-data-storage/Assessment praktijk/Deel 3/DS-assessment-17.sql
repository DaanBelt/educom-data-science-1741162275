SELECT A.ArtistId, A.Name
FROM Artist A
WHERE A.ArtistId NOT IN (SELECT ArtistId FROM Album)