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