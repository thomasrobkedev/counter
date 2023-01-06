DROP TABLE IF EXISTS counters;

CREATE TABLE counters (
`id`      INTEGER PRIMARY KEY NOT NULL,
`keyname` TEXT NOT NULL,
`value`   INTEGER NOT NULL DEFAULT 0
);

INSERT INTO counters VALUES(1, 'coffee', 0);
INSERT INTO counters VALUES(2, 'waterGlasses', 0);
INSERT INTO counters VALUES(3, 'overtime', 0);
INSERT INTO counters VALUES(4, 'cookies', 0);
