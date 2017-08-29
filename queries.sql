-- Query all of the entries in the Genre table
SELECT * FROM genre


-- Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT into artist
(artistid, artistname, yearestablished)--don't have to put in artistid
values(29, 'Queen', 1970)--can leave out 29 -- autoincrement



-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT into album
(albumid, title, releasedate, albumlength, label, artistid, genreid)
values(25,'A Kind Of Magic', '06/03/1986', 3060, 'EMI', 29, 2 )

--can also do it this way:
INSERT into Album(title, releasedate, albumlength, label, artistid, genreid)
SELECT "Georgetown Station", 1986, 2345, "Fifth Column Records", ar.artistid, g.genreid
FROM artist ar, genre g
WHERE ar.artistname = "The Model Citizens" -- as long as that artist exists already
and g.label= "Rock"



-- Using the INSERT statement, add some songs that are on that album to the Song table.
INSERT into song
(songid, title, songlength, releasedate, genreid, artistid, albumid)
values(23, 'Who Wants To Live Forever', 309, '06/03/1986', 2, 29, 25)

INSERT into song
(songid, title, songlength, releasedate, genreid, artistid, albumid)
values(24, 'Princes of the Universe', 200, '06/03/1986', 2, 29, 25)
--or
INSERT into Song(title, songlength, releasedate,  genreid, artistid, albumid)
SELECT "Second Sight",2345, 1986, g.genreid, ar.artistid, al.albumid
FROM artist ar, genre g, album al
WHERE ar.artistname = "The Model Citizens" -- as long as that artist exists already
and g.label= "Rock"
and al.title ="Georgetown Station"





-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in.
SELECT s.title, a.artistname, al.title
FROM song s, artist a, album al
WHERE a.artistname ="Queen"
and s.artistid = a.artistid
and al.albumid =s.albumid

--or
SELECT s.title as "Song", a.artistname, al.title as"Album" --changes titles of columns to be clear
FROM song s, artist a, album al
ON s.artistid = a.artistid
and al.albumid =s.albumid
and ar.artistid = "25"




--with LEFT JOIN, get song titles, album title, and artist name for all the data I entered
SELECT s.title, al.Title, ar.artistname
--artist joins song, song becomes our left table we're left joining to album
FROM artist ar, song s LEFT JOIN album al ON al.albumid = s.AlbumId
WHERE ar.artistname="Queen"
and al.artistid= ar.artistid

--or

SELECT s.title, ar.artistname, al.title --get these items
FROM artist ar, album al
 --from these two tables put together, then join album to song:
LEFT JOIN song s -- left table is now artist/album combo that's combining with song here
ON al.AlbumId = s.AlbumId
WHERE ar.artistname="Queen"
and al.artistid = ar.artistid




-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the
--GROUP BY keyword sequence.
--The GROUP BY statement is often used with aggregate functions (COUNT, MAX, MIN, SUM, AVG) to group the result-set by one or more columns.

SELECT COUNT(title) FROM song GROUP BY albumid  --just numbers

--or

SELECT  a.title, COUNT(songid) as "Total Songs"--changes label on returned data
FROM song s
LEFT JOIN Album a ON s.albumid = a.albumid
GROUP BY s.albumid --group based on album
ORDER BY COUNT(songid) -- put in order based on how many songs lowest to highest





-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the
-- GROUP BY keyword sequence.
SELECT COUNT(artistid) FROM song GROUP BY artistid  --for just numbers
--or
SELECT ar.artistname, COUNT(s.artistid)
FROM song s
LEFT JOIN artist ar
on s.artistid= ar.artistid
GROUP BY s.artistid




-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT()
--function and the GROUP BY keyword sequence.
SELECT COUNT(genreid) FROM song GROUP BY genreid --just numbers

--or
SELECT g.label as "Genres", COUNT(s.genreid)as "Number Of Songs" FROM song s LEFT JOIN genre g ON g.genreid = s.genreid
GROUP BY g.genreid



-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display
--the album title and the duration.

SELECT MAX(albumlength), title FROM album
--or
SELECT  title as "Album", MAX(albumlength) as "Duration" FROM album


-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song
--title and the duration.
SELECT  title as "Song", MAX(songlength) as "Duration" FROM song



-- Modify the previous query to also display the title of the album.
SELECT MAX(s.songlength), s.title, al.title FROM song s, album al WHERE s.albumid = al.albumid
--or
SELECT  s.title as "Song", MAX(s.songlength)as "Duration",al.title as "Album" FROM song s, album al WHERE s.albumid = al.albumid