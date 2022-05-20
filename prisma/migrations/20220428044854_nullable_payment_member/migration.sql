-- AlterTable
CREATE SEQUENCE "analysisparameters_id_seq";
ALTER TABLE "AnalysisParameters" ALTER COLUMN "id" SET DEFAULT nextval('analysisparameters_id_seq');
ALTER SEQUENCE "analysisparameters_id_seq" OWNED BY "AnalysisParameters"."id";

-- AlterTable
ALTER TABLE "Payments" ALTER COLUMN "memberId" DROP NOT NULL;
