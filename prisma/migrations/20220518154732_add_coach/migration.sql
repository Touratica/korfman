-- AlterTable
ALTER TABLE "Team" ADD COLUMN     "coachFpcId" INTEGER;

-- CreateTable
CREATE TABLE "Coach" (
    "fpcId" INTEGER NOT NULL,
    "level" INTEGER NOT NULL,

    CONSTRAINT "Coach_pkey" PRIMARY KEY ("fpcId")
);

-- AddForeignKey
ALTER TABLE "Coach" ADD CONSTRAINT "Coach_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMember"("fpcId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_coachFpcId_fkey" FOREIGN KEY ("coachFpcId") REFERENCES "Coach"("fpcId") ON DELETE SET NULL ON UPDATE CASCADE;
