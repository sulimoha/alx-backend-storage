SELECT band_name, 
       DATEDIFF(IFNULL(split, NOW()), formed) / 365 AS lifespan
FROM metal_bands 
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;
