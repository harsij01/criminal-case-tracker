CREATE INDEX "idx_cases_status" ON "cases"("status");

CREATE INDEX "idx_cases_type" ON "cases"("type");

CREATE INDEX "idx_suspects_status" ON "suspects"("status");

CREATE INDEX "idx_evidence_case_id" ON "evidence"("case_id");

CREATE INDEX "idx_evidence_type" ON "evidence"("type");

CREATE INDEX "idx_reports_case_id" ON "reports"("case_id");

CREATE INDEX "idx_suspects_last_name" ON "suspects"("last_name");