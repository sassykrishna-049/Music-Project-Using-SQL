--Question Set 1 - Easy

--1. Who is the senior most employee based on job title?

select * from employee order by levels desc limit 1

--2. Which countries have the most Invoices?

select count(*) as c,billing_country 
from invoice
group by billing_country 
order by c desc limit 1

--3. What are top 3 values of total invoice?
select total from invoice order by total  desc limit 3

/*4. Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals.*/
select sum(total) as invoice_total,billing_city from invoice
group by billing_city
order by invoice_total desc

/*5. Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money*/

select c.customer_id,c.first_name,c.last_name,sum(i.total) as total
from customer c 
join invoice i
using (customer_id)
group by c.customer_id order by total desc limit 1

-- Question Set 2 – Moderate

--1. Write query to return the email, first name, last name, & Genre of all Rock Music 
--listeners. Return your list ordered alphabetically by email starting with A

select distinct c.email,c.first_name, c.last_name 
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
where track_id in(
					select track_id from track t
					join genre g on t.genre_id = g.genre_id 
					where g.name like 'Rock'
)

order by email

--2. Let's invite the artists who have written the most rock music in our dataset. Write a 
--query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id,artist.name, count(artist.artist_id) as number_of_songs
from track 
join album  on track.album_id = album.album_id
join artist on artist.artist_id = album.artist_id
join genre  on track.genre_id = genre.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc 
limit 10

/*
3. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first.*/

select name ,milliseconds
from track where milliseconds > (
								select avg (milliseconds)  as avg_track_length	
								from track )
order by milliseconds desc

--Question Set 3 – Advance



