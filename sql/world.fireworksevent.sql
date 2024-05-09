-- Set variables
SET @OGUID := 9709;
SET @FourthOfJulyEvent := 72;
SET @NewYearEvent := 6;

-- Delete existing Fourth of July event if it exists
DELETE FROM `game_event` WHERE `eventEntry` = @FourthOfJulyEvent;

-- Insert a new Fourth of July event
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `description`)
VALUES (@FourthOfJulyEvent, '2010-07-04 10:00:00', '2030-07-04 10:00:00', 525600, 1440, 62, 'Fireworks Spectacular');

-- Update gameobject_template for a specific entry
UPDATE `gameobject_template` SET `ScriptName` = 'go_cheer_speaker' WHERE `entry` = 180749;

-- Delete gameobjects within a specified range
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 33;

-- Insert new gameobjects with specific details
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
VALUES
(@OGUID + 0, 180749, 0, 0, 0, 1, 1, -14370.99, 420.3124, 16.51293, 4.398232, 0, 0, 0, 1, 120, 255, 1, 21742), -- Specify more entries here
(@OGUID + 33, 180749, 0, 0, 0, 1, 1, -9044.079, 412.5068, 120.3821, 3.892087, 0, 0, 0, 1, 120, 255, 1, 21742); -- End of insertion

-- Delete old event-gameobject associations for Fourth of July event
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 33 AND `eventEntry` = @FourthOfJulyEvent;

-- Insert new event-gameobject associations for Fourth of July event
INSERT INTO `game_event_gameobject` SELECT @FourthOfJulyEvent, gameobject.guid FROM `gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 33;

-- Delete old event-gameobject associations for New Year event
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 33 AND `eventEntry` = @NewYearEvent;

-- Insert new event-gameobject associations for New Year event
INSERT INTO `game_event_gameobject` SELECT @NewYearEvent, gameobject.guid FROM `gameobject` WHERE `guid` BETWEEN @OGUID AND @OGUID + 33;
