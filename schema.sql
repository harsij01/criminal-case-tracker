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