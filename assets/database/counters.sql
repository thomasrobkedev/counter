DROP TABLE IF EXISTS counters;

CREATE TABLE counters (
`id`      INTEGER PRIMARY KEY NOT NULL,
`index`   INTEGER NOT NULL,
`keyname` TEXT NOT NULL,
`value`   INTEGER NOT NULL DEFAULT 0
);

INSERT INTO counters VALUES(1, 0, 'coffee', 0);
INSERT INTO counters VALUES(2, 1, 'waterGlasses', 0);
INSERT INTO counters VALUES(3, 2, 'overtime', 0);
INSERT INTO counters VALUES(4, 3, 'cookies', 0);
