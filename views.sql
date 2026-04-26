-- All cases where harm type is Death
CREATE VIEW "death_cases" AS 
SELECT "cases"."title", "victims"."first_name", "victims"."last_name"
FROM "case_victims"
JOIN "cases" ON "cases"."id" = "case_victims"."case_id"
JOIN "victims" ON "victims"."id" = "case_victims"."victim_id"
WHERE "case_victims"."harm_type" = 'Death';

-- Full evidence trail with case title and collector name
CREATE VIEW "evidence_log" AS
SELECT "evidence"."type", "evidence"."description", "evidence"."location_found", "evidence"."collected_date", "evidence"."status", 
    "cases"."title", 
    "investigators"."first_name", "investigators"."last_name"
FROM "evidence"
JOIN "cases" ON "cases"."id" = "evidence"."case_id"
JOIN "investigators" ON "investigators"."id" = "evidence"."collected_by";

-- All open cases with their lead investigator and suspect count
CREATE VIEW "open_cases_summary" AS
SELECT "cases"."case_number", "cases"."title", "cases"."opened_date",
    "investigators"."first_name", "investigators"."last_name", 
    (SELECT COUNT(*) FROM "case_suspects" WHERE "case_id" = "cases"."id") AS 'Suspect Count'
FROM "case_investigators"
JOIN "cases" ON "cases"."id" = "case_investigators"."case_id"
JOIN "investigators" ON "investigators"."id" = "case_investigators"."investigator_id"
WHERE "cases"."status" = 'Open' AND "case_investigators"."role" = 'Lead Investigator';
