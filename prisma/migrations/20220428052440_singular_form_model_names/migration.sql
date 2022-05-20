/*
  Warnings:

  - You are about to drop the `AnalysisParameterGroups` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AnalysisParameters` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Clubs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Competitions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FpcMembers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MatchEvents` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MatchPlayers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Matches` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Members` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Payments` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Players` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Teams` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "AnalysisParameters" DROP CONSTRAINT "AnalysisParameters_groupId_fkey";

-- DropForeignKey
ALTER TABLE "MatchEvents" DROP CONSTRAINT "MatchEvents_analysisParameterGroup_analysisParameterId_fkey";

-- DropForeignKey
ALTER TABLE "MatchEvents" DROP CONSTRAINT "MatchEvents_matchId_fpcId_fkey";

-- DropForeignKey
ALTER TABLE "MatchEvents" DROP CONSTRAINT "MatchEvents_matchId_opponentId_fkey";

-- DropForeignKey
ALTER TABLE "MatchPlayers" DROP CONSTRAINT "MatchPlayers_clubInitials_teamDesignation_fkey";

-- DropForeignKey
ALTER TABLE "MatchPlayers" DROP CONSTRAINT "MatchPlayers_fpcId_fkey";

-- DropForeignKey
ALTER TABLE "MatchPlayers" DROP CONSTRAINT "MatchPlayers_matchId_fkey";

-- DropForeignKey
ALTER TABLE "MatchStatisticsSum" DROP CONSTRAINT "MatchStatisticsSum_analysisParameterGroup_analysisParamete_fkey";

-- DropForeignKey
ALTER TABLE "MatchStatisticsSum" DROP CONSTRAINT "MatchStatisticsSum_fpcId_matchId_fkey";

-- DropForeignKey
ALTER TABLE "Matches" DROP CONSTRAINT "Matches_awayTeamClubInitials_awayTeamDesignation_fkey";

-- DropForeignKey
ALTER TABLE "Matches" DROP CONSTRAINT "Matches_homeTeamClubInitials_homeTeamDesignation_fkey";

-- DropForeignKey
ALTER TABLE "Matches" DROP CONSTRAINT "Matches_season_competition_fkey";

-- DropForeignKey
ALTER TABLE "Members" DROP CONSTRAINT "Members_fpcId_fkey";

-- DropForeignKey
ALTER TABLE "Payments" DROP CONSTRAINT "Payments_memberId_fkey";

-- DropForeignKey
ALTER TABLE "Players" DROP CONSTRAINT "Players_clubInitials_teamDesignation_fkey";

-- DropForeignKey
ALTER TABLE "Players" DROP CONSTRAINT "Players_fpcId_fkey";

-- DropForeignKey
ALTER TABLE "Teams" DROP CONSTRAINT "Teams_clubInitials_fkey";

-- DropTable
DROP TABLE "AnalysisParameterGroups";

-- DropTable
DROP TABLE "AnalysisParameters";

-- DropTable
DROP TABLE "Clubs";

-- DropTable
DROP TABLE "Competitions";

-- DropTable
DROP TABLE "FpcMembers";

-- DropTable
DROP TABLE "MatchEvents";

-- DropTable
DROP TABLE "MatchPlayers";

-- DropTable
DROP TABLE "Matches";

-- DropTable
DROP TABLE "Members";

-- DropTable
DROP TABLE "Payments";

-- DropTable
DROP TABLE "Players";

-- DropTable
DROP TABLE "Teams";

-- CreateTable
CREATE TABLE "AnalysisParameterGroup" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "AnalysisParameterGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalysisParameter" (
    "id" SERIAL NOT NULL,
    "groupId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "AnalysisParameter_pkey" PRIMARY KEY ("id","groupId")
);

-- CreateTable
CREATE TABLE "Club" (
    "initials" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Club_pkey" PRIMARY KEY ("initials")
);

-- CreateTable
CREATE TABLE "Competition" (
    "season" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Competition_pkey" PRIMARY KEY ("season","name")
);

-- CreateTable
CREATE TABLE "FpcMember" (
    "fpcId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "mobile" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "FpcMember_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "MatchEvent" (
    "date" TIMESTAMP(3) NOT NULL,
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "opponentId" INTEGER NOT NULL,
    "analysisParameterGroup" INTEGER NOT NULL,
    "analysisParameterId" INTEGER NOT NULL,
    "value" INTEGER NOT NULL,

    CONSTRAINT "MatchEvent_pkey" PRIMARY KEY ("date","matchId")
);

-- CreateTable
CREATE TABLE "MatchPlayer" (
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "clubInitials" TEXT NOT NULL,
    "teamDesignation" TEXT NOT NULL,

    CONSTRAINT "MatchPlayer_pkey" PRIMARY KEY ("matchId","fpcId")
);

-- CreateTable
CREATE TABLE "Match" (
    "matchId" SERIAL NOT NULL,
    "season" TEXT NOT NULL,
    "competition" TEXT NOT NULL,
    "homeTeamClubInitials" TEXT NOT NULL,
    "homeTeamDesignation" TEXT NOT NULL,
    "awayTeamClubInitials" TEXT NOT NULL,
    "awayTeamDesignation" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Match_pkey" PRIMARY KEY ("matchId")
);

-- CreateTable
CREATE TABLE "Member" (
    "memberId" SERIAL NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "mobile" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "isPermanent" BOOLEAN NOT NULL DEFAULT false,
    "duesInDay" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Member_pkey" PRIMARY KEY ("memberId")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dueIn" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "memberId" INTEGER,
    "value" DOUBLE PRECISION NOT NULL,
    "isPending" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Player" (
    "fpcId" INTEGER NOT NULL,
    "clubInitials" TEXT NOT NULL,
    "teamDesignation" TEXT NOT NULL,
    "shirtNumber" INTEGER NOT NULL,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "Team" (
    "designation" TEXT NOT NULL,
    "clubInitials" TEXT NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("designation","clubInitials")
);

-- CreateIndex
CREATE UNIQUE INDEX "Club_name_key" ON "Club"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Member_fpcId_key" ON "Member"("fpcId");

-- CreateIndex
CREATE UNIQUE INDEX "Player_clubInitials_teamDesignation_shirtNumber_key" ON "Player"("clubInitials", "teamDesignation", "shirtNumber");

-- AddForeignKey
ALTER TABLE "AnalysisParameter" ADD CONSTRAINT "AnalysisParameter_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "AnalysisParameterGroup"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvent" ADD CONSTRAINT "MatchEvent_analysisParameterGroup_analysisParameterId_fkey" FOREIGN KEY ("analysisParameterGroup", "analysisParameterId") REFERENCES "AnalysisParameter"("groupId", "id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvent" ADD CONSTRAINT "MatchEvent_matchId_fpcId_fkey" FOREIGN KEY ("matchId", "fpcId") REFERENCES "MatchPlayer"("matchId", "fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvent" ADD CONSTRAINT "MatchEvent_matchId_opponentId_fkey" FOREIGN KEY ("matchId", "opponentId") REFERENCES "MatchPlayer"("matchId", "fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayer" ADD CONSTRAINT "MatchPlayer_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "Match"("matchId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayer" ADD CONSTRAINT "MatchPlayer_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "Player"("fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayer" ADD CONSTRAINT "MatchPlayer_clubInitials_teamDesignation_fkey" FOREIGN KEY ("clubInitials", "teamDesignation") REFERENCES "Team"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchStatisticsSum" ADD CONSTRAINT "MatchStatisticsSum_analysisParameterGroup_analysisParamete_fkey" FOREIGN KEY ("analysisParameterGroup", "analysisParameterId") REFERENCES "AnalysisParameter"("groupId", "id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchStatisticsSum" ADD CONSTRAINT "MatchStatisticsSum_fpcId_matchId_fkey" FOREIGN KEY ("fpcId", "matchId") REFERENCES "MatchPlayer"("fpcId", "matchId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_season_competition_fkey" FOREIGN KEY ("season", "competition") REFERENCES "Competition"("season", "name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_awayTeamClubInitials_awayTeamDesignation_fkey" FOREIGN KEY ("awayTeamClubInitials", "awayTeamDesignation") REFERENCES "Team"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_homeTeamClubInitials_homeTeamDesignation_fkey" FOREIGN KEY ("homeTeamClubInitials", "homeTeamDesignation") REFERENCES "Team"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Member" ADD CONSTRAINT "Member_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMember"("fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Member"("memberId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Player" ADD CONSTRAINT "Player_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMember"("fpcId") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Player" ADD CONSTRAINT "Player_clubInitials_teamDesignation_fkey" FOREIGN KEY ("clubInitials", "teamDesignation") REFERENCES "Team"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_clubInitials_fkey" FOREIGN KEY ("clubInitials") REFERENCES "Club"("initials") ON DELETE NO ACTION ON UPDATE NO ACTION;
