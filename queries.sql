-- Get all open cases ordered by date opened
SELECT "case_number", "title", "type", "opened_date" 
FROM "cases" 
WHERE "status" = 'Open'
ORDER BY "opened_date";

-- Get all suspects who are currently at large
SELECT "first_name", "last_name"
FROM "suspects"
WHERE "status" = 'At Large';

-- Get all evidence collected for case with an id of 4
SELECT "type", "description", "collected_date", "location_found"
FROM "evidence"
WHERE "case_id" = 4;

-- Get all reports filed for case with an id of 4
SELECT "type", "content", "report_date"
FROM "reports"
WHERE "case_id" = 4;

-- Get all suspects with a prior criminal record
SELECT "first_name", "last_name", "criminal_record"
FROM "suspects"
WHERE "criminal_record" IS NOT NULL; 

-- Get all cases with their lead investigator's full name
SELECT "cases"."title", "investigators"."first_name", "investigators"."last_name"
FROM "case_investigators"
JOIN "cases" ON "cases"."id" = "case_investigators"."case_id"
JOIN "investigators" ON "investigators"."id" = "case_investigators"."investigator_id"
WHERE "case_investigators"."role" = 'Lead Investigator';

-- Get all suspects linked to Riverside Murder along with their role
SELECT "suspects"."first_name", "suspects"."last_name", "case_suspects"."role"
FROM "case_suspects"
JOIN "cases" ON "cases"."id" = "case_suspects"."case_id"
JOIN "suspects" ON "suspects"."id" = "case_suspects"."suspect_id"
WHERE "cases"."title" = 'Riverside Murder';

-- Get all evidence for Harbor Street Assault case along with the name of the investigator who collected it
SELECT "evidence"."type", "evidence"."collected_date", "evidence"."location_found", "investigators"."first_name", "investigators"."last_name"
FROM "evidence"
JOIN "cases" ON "cases"."id" = "evidence"."case_id" 
JOIN "investigators" ON "investigators"."id" = "evidence"."collected_by"
WHERE "cases"."title" = 'Harbor Street Assault';

-- Get all cases Jake Holloway (suspect) is linked to
SELECT "cases"."title"
FROM "case_suspects"
JOIN "cases" ON "cases"."id" = "case_suspects"."case_id"
JOIN "suspects" ON "suspects"."id" = "case_suspects"."suspect_id"
WHERE "suspects"."first_name" = 'Jake' AND "suspects"."last_name" = 'Holloway';

-- Count the number of cases by status
SELECT "status", COUNT(*) AS 'total'
FROM "cases"
GROUP BY "status";

-- Count how many cases each investigator is assigned to
SELECT "investigators"."first_name", "investigators"."last_name", COUNT(*) AS 'No of Cases'
FROM "case_investigators"
JOIN "investigators" ON "investigators"."id" = "case_investigators"."investigator_id"
GROUP BY "case_investigators"."investigator_id"
ORDER BY "No of Cases" DESC;

-- Count how many evidence items each case has
SELECT "cases"."title", COUNT(*) AS 'No of Evidence Items'
FROM "evidence"
JOIN "cases" ON "cases"."id" = "evidence"."case_id"
GROUP BY "evidence"."case_id"
ORDER BY "No of Evidence Items" DESC;

-- Get all suspects linked to more than one case
SELECT "first_name", "last_name"
FROM "suspects"
WHERE "id" IN (
    SELECT "suspect_id"
    FROM "case_suspects"
    GROUP BY "suspect_id"
    HAVING COUNT(*) > 1
);

-- Get all cases that have no suspects linked yet
SELECT "title"
FROM "cases"
WHERE "id" NOT IN (
    SELECT DISTINCT "case_id"
    FROM "case_suspects"
);

-- Get the investigator who has been assigned to the most cases
SELECT "investigators"."first_name", "investigators"."last_name"
FROM "investigators"
WHERE "id" IN (
    SELECT "investigator_id"
    FROM "case_investigators"
    GROUP BY "investigator_id"
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Get all cases that have at least one DNA evidence item
SELECT "title"
FROM "cases"
WHERE "id" IN (
    SELECT DISTINCT "case_id"
    FROM "evidence"
    WHERE "type" = 'DNA'
);

-- Get all cases opened in 2023
SELECT "title", "opened_date"
FROM "cases"
WHERE STRFTIME('%Y', "opened_date") = '2023';

-- Get all cases that have been open for more than a year with no closing date


-- Get all cases with their suspect count and evidence count


-- Get all investigators along with the number of reports they have filed
SELECT "investigators"."first_name", "investigators"."last_name", COUNT(*) AS 'No of Reports'
FROM "reports"
JOIN "investigators" ON "investigators"."id" = "reports"."investigator_id"
GROUP BY "investigator_id";

-- Get all victims along with the case they are linked to and the harm type
SELECT "victims"."first_name", "victims"."last_name", "cases"."title", "case_victims"."harm_type"
FROM "case_victims"
JOIN "victims" ON "victims"."id" = "case_victims"."victim_id"
JOIN "cases" ON "cases"."id" = "case_victims"."case_id";

-- Get all cases where the harm type is Death
SELECT "cases"."title"
FROM "case_victims"
JOIN "cases" ON "cases"."id" = "case_victims"."case_id"
WHERE "case_victims"."harm_type" = 'Death';
