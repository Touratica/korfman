/*
  Warnings:

  - Added the required column `firstName` to the `Staff` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `Staff` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Staff" ADD COLUMN     "firstName" TEXT,
ADD COLUMN     "lastName" TEXT;

UPDATE "Staff" SET "firstName"='firstName', "lastName"='lastName';

ALTER TABLE "Staff" ALTER COLUMN "firstName" SET NOT NULL, ALTER COLUMN "lastName" SET NOT NULL;