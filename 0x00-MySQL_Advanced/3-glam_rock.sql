-- Lists all bands with Glam rock as their main style, ranked by their longevity
SELECT band_name, 
       (YEAR(MAX(end_date)) - YEAR(MIN(start_date))) - 
           (COUNT(DISTINCT YEAR(end_date))*0.5) AS lifespan
FROM bands 
WHERE style = 'Glam rock'
GROUP BY band_name
ORDER BY lifespan DESC;
