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
