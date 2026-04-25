CREATE TABLE cases (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "case_number" TEXT NOT NULL UNIQUE,
    "title" TEXT NOT NULL,
    "type" TEXT CHECK("type" IN ('Murder', 'Robbery', 'Fraud', 'Assault', 'Kidnapping', 'Other')),
    "status" TEXT NOT NULL DEFAULT 'Open' CHECK("status" IN ('Open', 'Closed', 'Cold', 'Under Investigation')),
    "opened_date" DATE NOT NULL,
    "closed_date" DATE,
    "description" TEXT
);

CREATE TABLE suspects (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "dob" DATE NOT NULL,
    "gender" TEXT NOT NULL CHECK("gender" IN ('Male', 'Female', 'Other')),
    "nationality" TEXT NOT NULL,
    "contact_info" TEXT,
    "status" TEXT NOT NULL DEFAULT 'At Large' CHECK("status" IN ('At Large', 'Arrested', 'Convicted', 'Released')),
    "criminal_record" TEXT
);

CREATE TABLE victims (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "dob" DATE NOT NULL,
    "gender" TEXT NOT NULL CHECK("gender" IN ('Male', 'Female', 'Other')),
    "nationality" TEXT NOT NULL,
    "contact_info" TEXT,
    "statement" TEXT
);

CREATE TABLE investigators (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "badge_number" TEXT NOT NULL UNIQUE,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "dob" DATE NOT NULL,
    "gender" TEXT NOT NULL CHECK("gender" IN ('Male', 'Female', 'Other')),
    "rank" TEXT NOT NULL CHECK("rank" IN ('Detective', 'Sergeant', 'Lieutenant', 'Captain', 'Officer')),
    "department" TEXT,
    "contact_info" TEXT
);

CREATE TABLE evidence (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "case_id" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "collected_date" DATE NOT NULL,
    "collected_by" INTEGER NOT NULL,
    "location_found" TEXT NOT NULL,
    "status" TEXT NOT NULL CHECK("status" IN ('In Storage', 'Submitted to Lab', 'Destroyed')),
    FOREIGN KEY("case_id") REFERENCES "cases"("id") ON DELETE CASCADE,
    FOREIGN KEY("collected_by") REFERENCES "investigators"("id") ON DELETE CASCADE
);

CREATE TABLE case_suspects (
    "case_id" INTEGER NOT NULL,
    "suspect_id" INTEGER NOT NULL,
    "role" TEXT NOT NULL CHECK("role" IN ('Primary Suspect', 'Accomplice', 'Person of Interest')),
    "date_linked" DATE NOT NULL,
    PRIMARY KEY("case_id", "suspect_id"),
    FOREIGN KEY("case_id") REFERENCES "cases"("id"),
    FOREIGN KEY("suspect_id") REFERENCES "suspects"("id")
);

CREATE TABLE case_victims (
    "case_id" INTEGER NOT NULL,
    "victim_id" INTEGER NOT NULL,
    "harm_type" TEXT NOT NULL CHECK("harm_type" IN ('Physical', 'Financial', 'Emotional', 'Death')),
    PRIMARY KEY("case_id", "victim_id"),
    FOREIGN KEY("case_id") REFERENCES "cases"("id"),
    FOREIGN KEY("victim_id") REFERENCES "victims"("id")
);

CREATE TABLE case_investigators (
    "case_id" INTEGER NOT NULL,
    "investigator_id" INTEGER NOT NULL,
    "role" TEXT NOT NULL CHECK("role" IN ('Lead Investigator', 'Support', 'Forensics')),
    "assigned_date" DATE NOT NULL,
    PRIMARY KEY("case_id", "investigator_id"),
    FOREIGN KEY("case_id") REFERENCES "cases"("id"),
    FOREIGN KEY("investigator_id") REFERENCES "investigators"("id")
);

CREATE TABLE reports (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "case_id" INTEGER NOT NULL,
    "investigator_id" INTEGER NOT NULL,
    "report_date" DATE NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('Incident', 'Progress', 'Closing', 'Forensic')),
    "content" TEXT,
    FOREIGN KEY("case_id") REFERENCES "cases"("id") ON DELETE CASCADE,
    FOREIGN KEY("investigator_id") REFERENCES "investigators"("id") ON DELETE CASCADE
);

INSERT INTO cases (case_number, title, type, status, opened_date, closed_date, description) VALUES
('CR-2021-001', 'Downtown Bank Robbery', 'Robbery', 'Closed', '2021-03-15', '2021-06-20', 'Armed robbery at First National Bank on 5th Ave. Three suspects involved.'),
('CR-2021-002', 'Westside Homicide', 'Murder', 'Closed', '2021-07-02', '2022-01-14', 'Victim found deceased in Westside apartment. Suspected domestic dispute.'),
('CR-2022-001', 'Corporate Fraud Scheme', 'Fraud', 'Under Investigation', '2022-02-10', NULL, 'Large-scale financial fraud involving falsified company records and embezzlement.'),
('CR-2022-002', 'Harbor Street Assault', 'Assault', 'Closed', '2022-05-18', '2022-08-03', 'Violent assault near Harbor Street bar district. Victim hospitalized.'),
('CR-2022-003', 'Northpark Kidnapping', 'Kidnapping', 'Closed', '2022-09-01', '2022-09-18', 'Child abducted from Northpark playground. Recovered safely within 17 days.'),
('CR-2023-001', 'Old Town Jewelry Heist', 'Robbery', 'Under Investigation', '2023-01-22', NULL, 'Smash-and-grab robbery at Goldstein Jewelers. Estimated loss of $200,000.'),
('CR-2023-002', 'Riverside Murder', 'Murder', 'Open', '2023-04-10', NULL, 'Unidentified victim found near Riverside Bridge. No suspects identified yet.'),
('CR-2023-003', 'Phishing Fraud Network', 'Fraud', 'Under Investigation', '2023-06-05', NULL, 'Organized phishing operation targeting elderly victims across the city.'),
('CR-2024-001', 'Midtown Stabbing', 'Assault', 'Open', '2024-02-14', NULL, 'Stabbing incident outside Midtown nightclub. Suspect fled the scene.'),
('CR-2024-002', 'Cold Case Revisit - 2019 Homicide', 'Murder', 'Cold', '2024-05-01', NULL, 'Reopened cold case from 2019. New DNA evidence submitted for analysis.');