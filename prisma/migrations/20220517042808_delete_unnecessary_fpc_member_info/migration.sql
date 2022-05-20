/*
  Warnings:

  - You are about to drop the column `birthDate` on the `FpcMember` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `FpcMember` table. All the data in the column will be lost.
  - You are about to drop the column `mobile` on the `FpcMember` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "FpcMember" DROP COLUMN "birthDate",
DROP COLUMN "email",
DROP COLUMN "mobile";
