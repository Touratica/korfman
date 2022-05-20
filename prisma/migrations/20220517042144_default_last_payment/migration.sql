/*
  Warnings:

  - A unique constraint covering the columns `[fpcId,firstName,lastName]` on the table `FpcMember` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[fpcId,firstName,lastName]` on the table `Member` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "Member" DROP CONSTRAINT "Member_fpcId_fkey";

-- AlterTable
ALTER TABLE "Member" ALTER COLUMN "lastPayment" SET DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE UNIQUE INDEX "FpcMember_fpcId_firstName_lastName_key" ON "FpcMember"("fpcId", "firstName", "lastName");

-- CreateIndex
CREATE UNIQUE INDEX "Member_fpcId_firstName_lastName_key" ON "Member"("fpcId", "firstName", "lastName");

-- AddForeignKey
ALTER TABLE "Member" ADD CONSTRAINT "Member_fpcId_firstName_lastName_fkey" FOREIGN KEY ("fpcId", "firstName", "lastName") REFERENCES "FpcMember"("fpcId", "firstName", "lastName") ON DELETE NO ACTION ON UPDATE CASCADE;
