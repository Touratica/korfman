-- CreateTable
CREATE TABLE "AnalysisParameterGroups" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "AnalysisParameterGroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalysisParameters" (
    "id" INTEGER NOT NULL,
    "groupId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "AnalysisParameters_pkey" PRIMARY KEY ("id","groupId")
);

-- CreateTable
CREATE TABLE "Clubs" (
    "initials" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Clubs_pkey" PRIMARY KEY ("initials")
);

-- CreateTable
CREATE TABLE "Competitions" (
    "season" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Competitions_pkey" PRIMARY KEY ("season","name")
);

-- CreateTable
CREATE TABLE "FpcMembers" (
    "fpcId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "mobile" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "FpcMembers_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "MatchEvents" (
    "date" TIMESTAMP(3) NOT NULL,
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "opponentId" INTEGER NOT NULL,
    "analysisParameterGroup" INTEGER NOT NULL,
    "analysisParameterId" INTEGER NOT NULL,
    "value" INTEGER NOT NULL,

    CONSTRAINT "MatchEvents_pkey" PRIMARY KEY ("date","matchId")
);

-- CreateTable
CREATE TABLE "MatchPlayers" (
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "clubInitials" TEXT NOT NULL,
    "teamDesignation" TEXT NOT NULL,

    CONSTRAINT "MatchPlayers_pkey" PRIMARY KEY ("matchId","fpcId")
);

-- CreateTable
CREATE TABLE "MatchStatisticsSum" (
    "fpcId" INTEGER NOT NULL,
    "matchId" INTEGER NOT NULL,
    "analysisParameterGroup" INTEGER NOT NULL,
    "analysisParameterId" INTEGER NOT NULL,
    "value" INTEGER NOT NULL,

    CONSTRAINT "MatchStatisticsSum_pkey" PRIMARY KEY ("fpcId","matchId","analysisParameterGroup","analysisParameterId")
);

-- CreateTable
CREATE TABLE "Matches" (
    "matchId" SERIAL NOT NULL,
    "season" TEXT NOT NULL,
    "competition" TEXT NOT NULL,
    "homeTeamClubInitials" TEXT NOT NULL,
    "homeTeamDesignation" TEXT NOT NULL,
    "awayTeamClubInitials" TEXT NOT NULL,
    "awayTeamDesignation" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Matches_pkey" PRIMARY KEY ("matchId")
);

-- CreateTable
CREATE TABLE "Members" (
    "memberId" SERIAL NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "mobile" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "isPermanent" BOOLEAN NOT NULL DEFAULT false,
    "duesInDay" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Members_pkey" PRIMARY KEY ("memberId")
);

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

-- CreateTable
CREATE TABLE "Players" (
    "fpcId" INTEGER NOT NULL,
    "clubInitials" TEXT NOT NULL,
    "teamDesignation" TEXT NOT NULL,
    "shirtNumber" INTEGER NOT NULL,

    CONSTRAINT "Players_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "Teams" (
    "designation" TEXT NOT NULL,
    "clubInitials" TEXT NOT NULL,

    CONSTRAINT "Teams_pkey" PRIMARY KEY ("designation","clubInitials")
);

-- CreateIndex
CREATE UNIQUE INDEX "Clubs_name_key" ON "Clubs"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Members_fpcId_key" ON "Members"("fpcId");

-- CreateIndex
CREATE UNIQUE INDEX "Players_clubInitials_teamDesignation_shirtNumber_key" ON "Players"("clubInitials", "teamDesignation", "shirtNumber");

-- AddForeignKey
ALTER TABLE "AnalysisParameters" ADD CONSTRAINT "AnalysisParameters_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "AnalysisParameterGroups"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvents" ADD CONSTRAINT "MatchEvents_analysisParameterGroup_analysisParameterId_fkey" FOREIGN KEY ("analysisParameterGroup", "analysisParameterId") REFERENCES "AnalysisParameters"("groupId", "id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvents" ADD CONSTRAINT "MatchEvents_matchId_fpcId_fkey" FOREIGN KEY ("matchId", "fpcId") REFERENCES "MatchPlayers"("matchId", "fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchEvents" ADD CONSTRAINT "MatchEvents_matchId_opponentId_fkey" FOREIGN KEY ("matchId", "opponentId") REFERENCES "MatchPlayers"("matchId", "fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayers" ADD CONSTRAINT "MatchPlayers_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "Matches"("matchId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayers" ADD CONSTRAINT "MatchPlayers_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "Players"("fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchPlayers" ADD CONSTRAINT "MatchPlayers_clubInitials_teamDesignation_fkey" FOREIGN KEY ("clubInitials", "teamDesignation") REFERENCES "Teams"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchStatisticsSum" ADD CONSTRAINT "MatchStatisticsSum_analysisParameterGroup_analysisParamete_fkey" FOREIGN KEY ("analysisParameterGroup", "analysisParameterId") REFERENCES "AnalysisParameters"("groupId", "id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MatchStatisticsSum" ADD CONSTRAINT "MatchStatisticsSum_fpcId_matchId_fkey" FOREIGN KEY ("fpcId", "matchId") REFERENCES "MatchPlayers"("fpcId", "matchId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Matches" ADD CONSTRAINT "Matches_season_competition_fkey" FOREIGN KEY ("season", "competition") REFERENCES "Competitions"("season", "name") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Matches" ADD CONSTRAINT "Matches_awayTeamClubInitials_awayTeamDesignation_fkey" FOREIGN KEY ("awayTeamClubInitials", "awayTeamDesignation") REFERENCES "Teams"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Matches" ADD CONSTRAINT "Matches_homeTeamClubInitials_homeTeamDesignation_fkey" FOREIGN KEY ("homeTeamClubInitials", "homeTeamDesignation") REFERENCES "Teams"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Members" ADD CONSTRAINT "Members_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMembers"("fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Payments" ADD CONSTRAINT "Payments_memberId_fkey" FOREIGN KEY ("memberId") REFERENCES "Members"("memberId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Players" ADD CONSTRAINT "Players_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMembers"("fpcId") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Players" ADD CONSTRAINT "Players_clubInitials_teamDesignation_fkey" FOREIGN KEY ("clubInitials", "teamDesignation") REFERENCES "Teams"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Teams" ADD CONSTRAINT "Teams_clubInitials_fkey" FOREIGN KEY ("clubInitials") REFERENCES "Clubs"("initials") ON DELETE NO ACTION ON UPDATE NO ACTION;
