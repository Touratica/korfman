/*
  Warnings:

  - You are about to drop the column `coachFpcId` on the `Team` table. All the data in the column will be lost.
  - Added the required column `mainCoachFpcId` to the `Team` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Team" DROP CONSTRAINT "Team_coachFpcId_fkey";

-- AlterTable
ALTER TABLE "Team" RENAME COLUMN "coachFpcId" TO "mainCoachFpcId";
ALTER TABLE "Team" ADD COLUMN "assistantCoachFpcId" INTEGER;
ALTER TABLE "Team" ALTER COLUMN "mainCoachFpcId" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_mainCoachFpcId_fkey" FOREIGN KEY ("mainCoachFpcId") REFERENCES "Coach"("fpcId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_assistantCoachFpcId_fkey" FOREIGN KEY ("assistantCoachFpcId") REFERENCES "Coach"("fpcId") ON DELETE SET NULL ON UPDATE CASCADE;
