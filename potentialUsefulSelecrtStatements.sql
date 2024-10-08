-- 1. Find all students taught by Rickson Gracie: 
-- This could be useful for tracking the lineage of students under a specific teacher.

SELECT p.name AS student_name
FROM Instructions i
JOIN People p ON i.student_id = p.person_id
WHERE i.teacher_id = (SELECT person_id FROM People WHERE name = 'Rickson Gracie');

-- 2. List all members of Gracie Academy:
-- Useful for identifying everyone associated with a specific BJJ school.

SELECT p.name AS person_name
FROM MembershipAffiliation ma
JOIN People p ON ma.person_id = p.person_id
WHERE ma.school_id = (SELECT school_id FROM Schools WHERE name = 'Gracie Academy');

-- 3. Find all rounds that took place in a specific tournament (e.g., IBJJF World Championship):
-- Helps track matchups in a specific tournament.

SELECT p1.name AS person1, p2.name AS person2, t.name AS tournament_name, r.round_date
FROM Rounds r
JOIN People p1 ON r.person1_id = p1.person_id
JOIN People p2 ON r.person2_id = p2.person_id
JOIN Tournaments t ON r.tournament_id = t.tournament_id
WHERE t.name = 'IBJJF World Championship';
