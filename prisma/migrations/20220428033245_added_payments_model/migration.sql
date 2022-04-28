-- DropForeignKey
ALTER TABLE "Players" DROP CONSTRAINT "Players_fpcId_fkey";

-- CreateTable
CREATE TABLE "Payments" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dueIn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "memberId" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "isPending" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Payments_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Members"("memberId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Players" ADD CONSTRAINT "Players_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMembers"("fpcId") ON DELETE NO ACTION ON UPDATE CASCADE;
