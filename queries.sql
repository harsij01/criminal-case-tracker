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