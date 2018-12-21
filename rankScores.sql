-- Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. Note that after a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no "holes" between ranks.

-- +----+-------+
-- | Id | Score |
-- +----+-------+
-- | 1  | 3.50  |
-- | 2  | 3.65  |
-- | 3  | 4.00  |
-- | 4  | 3.85  |
-- | 5  | 4.00  |
-- | 6  | 3.65  |
-- +----+-------+
-- For example, given the above Scores table, your query should generate the following report (order by highest score):

-- +-------+------+
-- | Score | Rank |
-- +-------+------+
-- | 4.00  | 1    |
-- | 4.00  | 1    |
-- | 3.85  | 2    |
-- | 3.65  | 3    |
-- | 3.65  | 3    |
-- | 3.50  | 4    |
-- +-------+------+

-- Always Count
Select s.Score,
(Select Count(distinct Score) from Scores Where Score >=s.Score) as Rank
From Scores s
Order By s.Score Desc;

-- With Variables
Select Score, CASE
WHEN @p = Score THEN Cast(@c as unsigned)
WHEN @p := Score THEN Cast(@c := @c + 1 as unsigned)
ELSE Cast(@c := @c + 1 as unsigned)
END as Rank
from Scores, (Select @p := -1, @c := 0) r
order by Score desc;