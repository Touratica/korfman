DROP DOMAIN IF EXISTS pt_cellphone CASCADE;
DROP DOMAIN IF EXISTS email CASCADE;

CREATE DOMAIN pt_cellphone AS varchar(14)
CHECK(
    VALUE ~ '^(\+351|00351){0,1}9[12356][0-9]{7}$'
    );

CREATE DOMAIN email AS varchar(320)
CHECK(
    VALUE ~ '(?:[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'
    );


DROP TABLE IF EXISTS fpc_members CASCADE;
DROP TABLE IF EXISTS members CASCADE ;
DROP TABLE IF EXISTS clubs CASCADE ;
DROP TABLE IF EXISTS teams CASCADE ;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS competitions CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS match_players CASCADE;
DROP TABLE IF EXISTS analysis_parameter_groups CASCADE;
DROP TABLE IF EXISTS analysis_parameters CASCADE;
DROP TABLE IF EXISTS match_events CASCADE;
DROP TABLE IF EXISTS match_statistics_sum CASCADE;


CREATE TABLE fpc_members (
    fpc_id int4,    -- PRIMARY KEY
    first_name varchar(24) NOT NULL,
    last_name varchar(48) NOT NULL,
    birth_date date NOT NULL,
    mobile pt_cellphone NOT NULL,
    email email NOT NULL,
    PRIMARY KEY (fpc_id)
);

CREATE TABLE members (
    member_id int4 GENERATED ALWAYS AS IDENTITY,      -- PRIMARY KEY
    fpc_id int4 NOT NULL,   -- FOREIGN KEY 1
    first_name varchar(24) NOT NULL,
    last_name varchar(48) NOT NULL,
    birth_date date NOT NULL,
    mobile pt_cellphone NOT NULL,
    email email NOT NULL,
    is_permanent bool NOT NULL DEFAULT FALSE,
    dues_in_day bool NOT NULL DEFAULT FALSE,
    PRIMARY KEY (member_id),
    FOREIGN KEY (fpc_id) REFERENCES fpc_members(fpc_id),
    UNIQUE (fpc_id)
);

CREATE TABLE clubs (
    initials varchar(8),    -- PRIMARY KEY
    name varchar(64) NOT NULL,
    PRIMARY KEY (initials),
    UNIQUE (name)
);

CREATE TABLE teams (
    designation char,           -- PRIMARY KEY
    club_initials varchar(8),   -- PRIMARY KEY, FOREIGN KEY 1
    PRIMARY KEY (designation, club_initials),
    FOREIGN KEY (club_initials) REFERENCES clubs(initials)
);

CREATE TABLE players (
    fpc_id int4,                        -- PRIMARY KEY, FOREIGN KEY 1
    club_initials varchar(8) NOT NULL,  -- FOREIGN KEY 2
    team_designation char NOT NULL,     -- FOREIGN KEY 2
    shirt_number int2 NOT NULL,
    PRIMARY KEY (fpc_id),
    FOREIGN KEY (fpc_id) REFERENCES fpc_members(fpc_id),
    FOREIGN KEY (club_initials, team_designation) REFERENCES teams(club_initials, designation),
    UNIQUE (club_initials, team_designation, shirt_number)
);

CREATE TABLE competitions (
    season varchar(7),  -- PRIMARY KEY
    name varchar(32),   -- PRIMARY KEY
    PRIMARY KEY (season, name)
);

CREATE TABLE matches (
    match_id int4 GENERATED ALWAYS AS IDENTITY, -- PRIMARY KEY
    season varchar(7) NOT NULL, -- FOREIGN KEY 1
    competition varchar(32) NOT NULL,   -- FOREIGN KEY 1
    home_team_club_initials varchar(8) NOT NULL,    -- FOREIGN KEY 2
    home_team_designation char NOT NULL,    -- FOREIGN KEY 2
    away_team_club_initials varchar(8) NOT NULL,    -- FOREIGN KEY 3
    away_team_designation char NOT NULL,    -- FOREIGN KEY 3
    date date NOT NULL,
    PRIMARY KEY (match_id),
    FOREIGN KEY (season, competition) REFERENCES competitions(season, name),
    FOREIGN KEY (home_team_club_initials, home_team_designation) REFERENCES teams(club_initials, designation),
    FOREIGN KEY (away_team_club_initials, away_team_designation) REFERENCES teams(club_initials, designation)
);

CREATE TABLE match_players (
    match_id int4,                      -- PRIMARY KEY, FOREIGN KEY 1
    fpc_id int4,                        -- PRIMARY KEY, FOREIGN KEY 2
    club_initials varchar(8) NOT NULL,  -- FOREIGN KEY 3
    team_designation char NOT NULL,     -- FOREIGN KEY 3
    PRIMARY KEY (match_id, fpc_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (fpc_id) REFERENCES players(fpc_id),
    FOREIGN KEY (club_initials, team_designation) REFERENCES teams(club_initials, designation)
);

CREATE TABLE analysis_parameter_groups (
    id int2 GENERATED ALWAYS AS IDENTITY, -- PRIMARY KEY
    name varchar(32) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE analysis_parameters (
    id int2 GENERATED ALWAYS AS IDENTITY,        -- PRIMARY KEY
    group_id int2,  -- PRIMARY KEY, FOREIGN KEY 1
    name varchar(32) NOT NULL,
    PRIMARY KEY (id, group_id),
    FOREIGN KEY (group_id) REFERENCES analysis_parameter_groups(id)
);

CREATE TABLE match_events (
    date date,                              -- PRIMARY KEY
    match_id int4,                          -- PRIMARY KEY, FOREIGN KEY 1, 2
    fpc_id int4 NOT NULL,                   -- FOREIGN KEY 1
    opponent_id int4 NOT NULL,              -- FOREIGN KEY 2
    analysis_parameter_group int2 NOT NULL, -- FOREIGN KEY 3
    analysis_parameter_id int2 NOT NULL,    -- FOREIGN KEY 3
    value int2 NOT NULL,
    PRIMARY KEY (date, match_id),
    FOREIGN KEY (match_id, fpc_id) REFERENCES match_players(match_id, fpc_id),
    FOREIGN KEY (match_id, opponent_id) REFERENCES match_players(match_id, fpc_id),
    FOREIGN KEY (analysis_parameter_group, analysis_parameter_id) REFERENCES analysis_parameters(group_id, id)
);

CREATE TABLE match_statistics_sum (
    fpc_id int4,                    -- PRIMARY KEY, FOREIGN KEY 1
    match_id int4,                  -- PRIMARY KEY, FOREIGN KEY 1
    analysis_parameter_group int2,  -- PRIMARY KEY, FOREIGN KEY 2
    analysis_parameter_id int2,     -- PRIMARY KEY, FOREIGN KEY 2
    value int2 NOT NULL,
    PRIMARY KEY (fpc_id, match_id, analysis_parameter_group, analysis_parameter_id),
    FOREIGN KEY (fpc_id, match_id) REFERENCES match_players(fpc_id, match_id),
    FOREIGN KEY (analysis_parameter_group, analysis_parameter_id) REFERENCES analysis_parameters(group_id, id)
);

-- Update member's id to exclude unused numbers
-- UPDATE members SET member_id=nextval('members_member_id_seq');

-- Delete member's who are not permanent (honorary)
-- TODO: Add condition to not delete who have their dues paid
-- DELETE FROM members WHERE is_permanent=false AND ;

-- SELECT DISTINCT club_initials, team_designation FROM match_players NATURAL JOIN matches
-- WHERE fpc_id=xxx
-- GROUP BY club_initials, team_designation;