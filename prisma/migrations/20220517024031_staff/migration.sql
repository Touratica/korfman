/*
  Warnings:

  - You are about to drop the column `isPermanent` on the `Member` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Member" DROP COLUMN "isPermanent",
ADD COLUMN     "joinedOn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateTable
CREATE TABLE "Coordenation" (
    "staffId" INTEGER NOT NULL,

    CONSTRAINT "Coordenation_pkey" PRIMARY KEY ("staffId")
);

-- CreateTable
CREATE TABLE "Staff" (
    "staffId" SERIAL NOT NULL,
    "memberId" INTEGER,
    "department" TEXT NOT NULL,
    "title" TEXT,

    CONSTRAINT "Staff_pkey" PRIMARY KEY ("staffId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Staff_memberId_key" ON "Staff"("memberId");

-- AddForeignKey
ALTER TABLE "Coordenation" ADD CONSTRAINT "Coordenation_staffId_fkey" FOREIGN KEY ("staffId") REFERENCES "Staff"("staffId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Staff" ADD CONSTRAINT "Staff_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE NO ACTION ON UPDATE CASCADE;
