/*
  Warnings:

  - The `department` column on the `Staff` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `title` column on the `Staff` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "Department" AS ENUM ('Administration', 'aKademyLx', 'Competition', 'Financial', 'IT', 'MarketingAndSales', 'Resources');

-- AlterTable
ALTER TABLE "Staff" DROP COLUMN "department",
ADD COLUMN     "department" "Department"[],
DROP COLUMN "title",
ADD COLUMN     "title" TEXT[];
