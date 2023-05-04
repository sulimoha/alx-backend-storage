CREATE PROCEDURE ComputeAverageWeightedScoreForUsers
AS
BEGIN
    -- create a temporary table to store weighted scores for all students
    CREATE TABLE #temp (
        user_id INT,
        weighted_score FLOAT
    )

    -- calculate and store the weighted score for each student
    INSERT INTO #temp
    SELECT u.user_id, SUM(e.score * c.weight) / SUM(c.weight)
    FROM users u
    JOIN enrollments en ON u.user_id = en.user_id
    JOIN courses c ON en.course_id = c.course_id
    JOIN exams e ON en.enrollment_id = e.enrollment_id
    GROUP BY u.user_id

    -- calculate the average weighted score for all students and store it in a variable
    DECLARE @avg_weighted_score FLOAT
    SELECT @avg_weighted_score = AVG(weighted_score)
    FROM #temp

    -- update the users table with the average weighted score for each user
    UPDATE users
    SET avg_weighted_score = @avg_weighted_score

    -- drop the temporary table
    DROP TABLE #temp
END
