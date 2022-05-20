/*
  Warnings:

  - You are about to drop the column `duesInDay` on the `Member` table. All the data in the column will be lost.
  - Added the required column `documentNumber` to the `Member` table without a default value. This is not possible if the table is not empty.
  - Added the required column `documentType` to the `Member` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastPayment` to the `Member` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type` to the `Member` table without a default value. This is not possible if the table is not empty.
  - Added the required column `vatId` to the `Member` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "MemberType" AS ENUM ('effective', 'founder', 'honorary', 'sympathizer');

-- AlterTable
ALTER TABLE "Member" DROP COLUMN "duesInDay",
ADD COLUMN     "documentNumber" TEXT NOT NULL,
ADD COLUMN     "documentType" TEXT NOT NULL,
ADD COLUMN     "lastPayment" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "type" "MemberType" NOT NULL,
ADD COLUMN     "vatId" INTEGER NOT NULL;
