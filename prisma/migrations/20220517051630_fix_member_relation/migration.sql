-- DropForeignKey
ALTER TABLE "Member" DROP CONSTRAINT "Member_fpcId_firstName_lastName_fkey";

-- DropIndex
DROP INDEX "FpcMember_fpcId_firstName_lastName_key";

-- DropIndex
DROP INDEX "Member_fpcId_firstName_lastName_key";

-- AddForeignKey
ALTER TABLE "Member" ADD CONSTRAINT "Member_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMember"("fpcId") ON DELETE NO ACTION ON UPDATE CASCADE;
