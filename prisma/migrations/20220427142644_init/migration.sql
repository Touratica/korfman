-- CreateTable
CREATE TABLE "AnalysisParameterGroups" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(32) NOT NULL,

    CONSTRAINT "AnalysisParameterGroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalysisParameters" (
    "id" SMALLINT NOT NULL,
    "groupId" SMALLINT NOT NULL,
    "name" VARCHAR(32) NOT NULL,

    CONSTRAINT "AnalysisParameters_pkey" PRIMARY KEY ("id","groupId")
);

-- CreateTable
CREATE TABLE "Clubs" (
    "initials" VARCHAR(8) NOT NULL,
    "name" VARCHAR(64) NOT NULL,

    CONSTRAINT "Clubs_pkey" PRIMARY KEY ("initials")
);

-- CreateTable
CREATE TABLE "Competitions" (
    "season" VARCHAR(7) NOT NULL,
    "name" VARCHAR(32) NOT NULL,

    CONSTRAINT "Competitions_pkey" PRIMARY KEY ("season","name")
);

-- CreateTable
CREATE TABLE "FpcMembers" (
    "fpcId" INTEGER NOT NULL,
    "firstName" VARCHAR(24) NOT NULL,
    "lastName" VARCHAR(48) NOT NULL,
    "birthDate" DATE NOT NULL,
    "mobile" VARCHAR(14) NOT NULL,
    "email" VARCHAR(320) NOT NULL,

    CONSTRAINT "FpcMembers_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "MatchEvents" (
    "date" DATE NOT NULL,
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "opponentId" INTEGER NOT NULL,
    "analysisParameterGroup" SMALLINT NOT NULL,
    "analysisParameterId" SMALLINT NOT NULL,
    "value" SMALLINT NOT NULL,

    CONSTRAINT "MatchEvents_pkey" PRIMARY KEY ("date","matchId")
);

-- CreateTable
CREATE TABLE "MatchPlayers" (
    "matchId" INTEGER NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "clubInitials" VARCHAR(8) NOT NULL,
    "teamDesignation" CHAR(1) NOT NULL,

    CONSTRAINT "MatchPlayers_pkey" PRIMARY KEY ("matchId","fpcId")
);

-- CreateTable
CREATE TABLE "MatchStatisticsSum" (
    "fpcId" INTEGER NOT NULL,
    "matchId" INTEGER NOT NULL,
    "analysisParameterGroup" SMALLINT NOT NULL,
    "analysisParameterId" SMALLINT NOT NULL,
    "value" SMALLINT NOT NULL,

    CONSTRAINT "MatchStatisticsSum_pkey" PRIMARY KEY ("fpcId","matchId","analysisParameterGroup","analysisParameterId")
);

-- CreateTable
CREATE TABLE "Matches" (
    "matchId" SERIAL NOT NULL,
    "season" VARCHAR(7) NOT NULL,
    "competition" VARCHAR(32) NOT NULL,
    "homeTeamClubInitials" VARCHAR(8) NOT NULL,
    "homeTeamDesignation" CHAR(1) NOT NULL,
    "awayTeamClubInitials" VARCHAR(8) NOT NULL,
    "awayTeamDesignation" CHAR(1) NOT NULL,
    "date" DATE NOT NULL,

    CONSTRAINT "Matches_pkey" PRIMARY KEY ("matchId")
);

-- CreateTable
CREATE TABLE "Members" (
    "memberId" SERIAL NOT NULL,
    "fpcId" INTEGER NOT NULL,
    "firstName" VARCHAR(24) NOT NULL,
    "lastName" VARCHAR(48) NOT NULL,
    "birthDate" DATE NOT NULL,
    "mobile" VARCHAR(14) NOT NULL,
    "email" VARCHAR(320) NOT NULL,
    "isPermanent" BOOLEAN NOT NULL DEFAULT false,
    "duesInDay" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Members_pkey" PRIMARY KEY ("memberId")
);

-- CreateTable
CREATE TABLE "Players" (
    "fpcId" INTEGER NOT NULL,
    "clubInitials" VARCHAR(8) NOT NULL,
    "teamDesignation" CHAR(1) NOT NULL,
    "shirtNumber" SMALLINT NOT NULL,

    CONSTRAINT "Players_pkey" PRIMARY KEY ("fpcId")
);

-- CreateTable
CREATE TABLE "Teams" (
    "designation" CHAR(1) NOT NULL,
    "clubInitials" VARCHAR(8) NOT NULL,

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
ALTER TABLE "Players" ADD CONSTRAINT "Players_fpcId_fkey" FOREIGN KEY ("fpcId") REFERENCES "FpcMembers"("fpcId") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Players" ADD CONSTRAINT "Players_clubInitials_teamDesignation_fkey" FOREIGN KEY ("clubInitials", "teamDesignation") REFERENCES "Teams"("clubInitials", "designation") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Teams" ADD CONSTRAINT "Teams_clubInitials_fkey" FOREIGN KEY ("clubInitials") REFERENCES "Clubs"("initials") ON DELETE NO ACTION ON UPDATE NO ACTION;
