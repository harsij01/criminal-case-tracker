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

INSERT INTO cases ("case_number", "title", "type", "status", "opened_date", "closed_date", "description") VALUES
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

INSERT INTO suspects ("first_name", "last_name", "dob", "gender", "nationality", "contact_info", "status", "criminal_record") VALUES
('Victor', 'Hale', '1988-04-11', 'Male', 'American', '555-0101', 'Convicted', 'Prior robbery, 2018'),
('Danny', 'Marsh', '1992-08-23', 'Male', 'American', '555-0102', 'Convicted', 'Assault, 2019'),
('Rosa', 'Vega', '1985-12-30', 'Female', 'Mexican', '555-0103', 'Released', 'Fraud, 2017'),
('Tom', 'Briggs', '1979-02-14', 'Male', 'British', NULL, 'Arrested', 'None'),
('Angela', 'Foster', '1990-06-05', 'Female', 'American', '555-0105', 'At Large', 'Fraud, 2020'),
('Chen', 'Wei', '1983-10-19', 'Male', 'Chinese', NULL, 'At Large', 'None'),
('Marcus', 'Stone', '1975-07-07', 'Male', 'American', '555-0107', 'Convicted', 'Murder, 2010; Assault, 2015'),
('Nina', 'Petrov', '1995-03-25', 'Female', 'Russian', '555-0108', 'Arrested', 'None'),
('Jake', 'Holloway', '1987-11-02', 'Male', 'American', NULL, 'At Large', 'Robbery, 2016'),
('Diana', 'Cross', '1993-01-17', 'Female', 'Canadian', '555-0110', 'Released', 'None');

INSERT INTO victims ("first_name", "last_name", "dob", "gender", "nationality", "contact_info", "statement") VALUES
('Robert', 'Lane', '1965-05-20', 'Male', 'American', '555-0201', 'I was behind the counter when three masked men entered and demanded cash.'),
('Linda', 'Park', '1978-11-13', 'Female', 'Korean', '555-0202', 'I heard shouting and then a gunshot from the next room.'),
('George', 'Simmons', '1952-08-07', 'Male', 'American', '555-0203', 'They contacted me pretending to be from the IRS and I transferred the funds.'),
('Amy', 'Torres', '1989-03-29', 'Female', 'American', '555-0204', 'He attacked me from behind near the bar entrance.'),
('Lily', 'Johnson', '2015-06-14', 'Female', 'American', '555-0205', 'Victim is a minor. Statement taken with guardian present.'),
('Paul', 'Nguyen', '1971-09-18', 'Male', 'Vietnamese', '555-0206', 'The display case was smashed and three men grabbed the trays and ran.'),
('Jane', 'Doe', '1990-01-01', 'Female', 'Unknown', NULL, NULL),
('Harold', 'Green', '1948-12-05', 'Male', 'American', '555-0208', 'I received an email saying my account was compromised. I lost $15,000.'),
('Chris', 'Adams', '1996-07-22', 'Male', 'American', '555-0209', 'Someone came up and stabbed me. I did not see their face clearly.'),
('Mary', 'Collins', '1955-04-10', 'Female', 'American', '555-0210', 'My husband never came home that night. That is all I know.');

INSERT INTO investigators ("badge_number", "first_name", "last_name", "dob", "gender", "rank", "department", "contact_info") VALUES
('B001', 'James', 'Carter', '1975-03-12', 'Male', 'Detective', 'Homicide', 'james.carter@police.gov'),
('B002', 'Sarah', 'Mitchell', '1980-07-24', 'Female', 'Sergeant', 'Narcotics', 'sarah.mitchell@police.gov'),
('B003', 'David', 'Nguyen', '1983-11-05', 'Male', 'Lieutenant', 'Cyber Crime', 'david.nguyen@police.gov'),
('B004', 'Emily', 'Brooks', '1990-01-18', 'Female', 'Officer', 'Homicide', 'emily.brooks@police.gov'),
('B005', 'Marcus', 'Reid', '1978-09-30', 'Male', 'Captain', 'Major Crimes', 'marcus.reid@police.gov'),
('B006', 'Laura', 'Chen', '1985-06-15', 'Female', 'Detective', 'Forensics', 'laura.chen@police.gov'),
('B007', 'Kevin', 'Walsh', '1992-04-22', 'Male', 'Officer', 'Patrol', 'kevin.walsh@police.gov');

INSERT INTO evidence ("case_id", "type", "description", "collected_date", "collected_by", "location_found", "status") VALUES
(1, 'Weapon', 'Loaded handgun found in suspect vehicle', '2021-03-15', 1, 'Suspect vehicle, Elm Street', 'In Storage'),
(1, 'Digital', 'Bank CCTV footage showing suspects', '2021-03-16', 4, 'First National Bank', 'Submitted to Lab'),
(2, 'DNA', 'Blood sample from crime scene', '2021-07-02', 6, 'Westside Apartment 4B', 'Submitted to Lab'),
(2, 'Document', 'Threatening letters found in victim apartment', '2021-07-03', 1, 'Westside Apartment 4B', 'In Storage'),
(3, 'Document', 'Falsified financial records', '2022-02-15', 3, 'Corporate HQ, Floor 12', 'Submitted to Lab'),
(3, 'Digital', 'Encrypted hard drive seized from office', '2022-02-15', 3, 'Corporate HQ, Floor 12', 'Submitted to Lab'),
(4, 'Weapon', 'Broken glass bottle used in assault', '2022-05-18', 7, 'Harbor Street sidewalk', 'In Storage'),
(4, 'Digital', 'Street camera footage of altercation', '2022-05-19', 4, 'City Traffic Camera #47', 'Submitted to Lab'),
(5, 'Digital', 'Ransom note photo sent via phone', '2022-09-02', 3, 'Victim family residence', 'In Storage'),
(6, 'Physical', 'Broken display case glass shards', '2023-01-22', 7, 'Goldstein Jewelers', 'In Storage'),
(6, 'Digital', 'Store CCTV footage', '2023-01-22', 4, 'Goldstein Jewelers', 'Submitted to Lab'),
(7, 'DNA', 'Unidentified blood sample from scene', '2023-04-10', 6, 'Riverside Bridge embankment', 'Submitted to Lab'),
(8, 'Digital', 'Phishing email server logs', '2023-06-10', 3, 'ISP Records', 'Submitted to Lab'),
(9, 'Weapon', 'Knife recovered near dumpster', '2024-02-14', 7, 'Midtown nightclub alley', 'Submitted to Lab'),
(10, 'DNA', 'DNA sample from 2019 evidence resubmitted', '2024-05-05', 6, 'Evidence storage vault', 'Submitted to Lab');

INSERT INTO case_suspects ("case_id", "suspect_id", "role", "date_linked") VALUES
(1, 1, 'Primary Suspect', '2021-03-16'),
(1, 2, 'Accomplice', '2021-03-18'),
(1, 9, 'Accomplice', '2021-03-20'),
(2, 7, 'Primary Suspect', '2021-07-05'),
(3, 3, 'Primary Suspect', '2022-02-20'),
(3, 5, 'Accomplice', '2022-03-01'),
(4, 2, 'Primary Suspect', '2022-05-19'),
(5, 4, 'Primary Suspect', '2022-09-03'),
(6, 1, 'Person of Interest', '2023-01-25'),
(6, 9, 'Primary Suspect', '2023-02-01'),
(8, 5, 'Primary Suspect', '2023-06-15'),
(8, 6, 'Accomplice', '2023-06-20'),
(9, 8, 'Person of Interest', '2024-02-16'),
(10, 7, 'Person of Interest', '2024-05-10');

INSERT INTO case_victims ("case_id", "victim_id", "harm_type") VALUES
(1, 1, 'Physical'),
(2, 2, 'Death'),
(3, 3, 'Financial'),
(3, 8, 'Financial'),
(4, 4, 'Physical'),
(5, 5, 'Emotional'),
(6, 6, 'Financial'),
(7, 7, 'Death'),
(8, 8, 'Financial'),
(8, 3, 'Financial'),
(9, 9, 'Physical'),
(10, 10, 'Emotional');

INSERT INTO case_investigators ("case_id", "investigator_id", "role", "assigned_date") VALUES
(1, 1, 'Lead Investigator', '2021-03-15'),
(1, 4, 'Support', '2021-03-15'),
(2, 1, 'Lead Investigator', '2021-07-02'),
(2, 6, 'Forensics', '2021-07-02'),
(3, 3, 'Lead Investigator', '2022-02-10'),
(3, 2, 'Support', '2022-02-12'),
(4, 2, 'Lead Investigator', '2022-05-18'),
(4, 7, 'Support', '2022-05-18'),
(5, 5, 'Lead Investigator', '2022-09-01'),
(5, 3, 'Support', '2022-09-02'),
(6, 1, 'Lead Investigator', '2023-01-22'),
(6, 7, 'Support', '2023-01-22'),
(7, 1, 'Lead Investigator', '2023-04-10'),
(7, 6, 'Forensics', '2023-04-10'),
(8, 3, 'Lead Investigator', '2023-06-05'),
(8, 2, 'Support', '2023-06-06'),
(9, 2, 'Lead Investigator', '2024-02-14'),
(9, 7, 'Support', '2024-02-14'),
(10, 5, 'Lead Investigator', '2024-05-01'),
(10, 6, 'Forensics', '2024-05-03');

INSERT INTO reports ("case_id", "investigator_id", "report_date", "type", "content") VALUES
(1, 1, '2021-03-15', 'Incident', 'Three armed suspects entered First National Bank at 14:32. Cashier Robert Lane was threatened at gunpoint. Approximately $85,000 was taken.'),
(1, 1, '2021-04-10', 'Progress', 'Suspects identified via CCTV. Victor Hale and Danny Marsh taken into custody. Third suspect Jake Holloway still at large.'),
(1, 1, '2021-06-20', 'Closing', 'Case closed. Victor Hale and Danny Marsh convicted. Jake Holloway remains a fugitive.'),
(2, 1, '2021-07-02', 'Incident', 'Victim Linda Park found deceased in Westside apartment. Cause of death: blunt force trauma. No forced entry detected.'),
(2, 6, '2021-07-05', 'Forensic', 'DNA samples collected from scene. Blood found matches suspect Marcus Stone from prior database records.'),
(2, 1, '2022-01-14', 'Closing', 'Marcus Stone convicted of second-degree murder. Case closed.'),
(3, 3, '2022-02-10', 'Incident', 'Tip received regarding falsified financial records at Meridian Corp. Digital forensics team engaged.'),
(3, 3, '2023-01-15', 'Progress', 'Rosa Vega cooperating with investigators. Angela Foster believed to be operating offshore. Investigation ongoing.'),
(4, 2, '2022-05-18', 'Incident', 'Amy Torres assaulted outside Harbor Bar at 23:15. Suspect Danny Marsh identified on camera footage.'),
(4, 2, '2022-08-03', 'Closing', 'Danny Marsh charged with aggravated assault. Pleaded guilty. Case closed.'),
(5, 5, '2022-09-01', 'Incident', 'Lily Johnson, age 7, reported missing from Northpark playground at approximately 16:00.'),
(5, 5, '2022-09-18', 'Closing', 'Lily Johnson recovered safely. Tom Briggs arrested. Case closed.'),
(6, 1, '2023-01-22', 'Incident', 'Smash-and-grab robbery at Goldstein Jewelers at 20:45. Three suspects fled in a dark SUV.'),
(6, 1, '2023-03-10', 'Progress', 'Jake Holloway identified as primary suspect. Still at large. Investigation ongoing.'),
(7, 1, '2023-04-10', 'Incident', 'Unidentified female victim found near Riverside Bridge. No ID on body. Cause of death unknown pending autopsy.'),
(7, 6, '2023-04-12', 'Forensic', 'Autopsy confirms cause of death as strangulation. DNA samples submitted. No matches found in database yet.'),
(8, 3, '2023-06-05', 'Incident', 'Multiple reports of phishing emails targeting seniors. Estimated total loss exceeds $500,000 across 40 victims.'),
(8, 3, '2024-01-20', 'Progress', 'Angela Foster linked to phishing network. Chen Wei identified as technical operator. Both remain at large.'),
(9, 2, '2024-02-14', 'Incident', 'Chris Adams stabbed outside Vertigo nightclub at 02:10. Suspect fled on foot. Knife recovered nearby.'),
(10, 5, '2024-05-01', 'Progress', 'Cold case from 2019 reopened following new DNA technology. Sample resubmitted. Marcus Stone flagged as person of interest.');