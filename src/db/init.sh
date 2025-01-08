#!/bin/bash

# Delete and remake tables
psql postgresql://songarchive:small-scale73.antagonist@postgres.csh.rit.edu/songarchive -f ./init.sql

# Copy data
psql postgresql://songarchive:small-scale73.antagonist@postgres.csh.rit.edu/songarchive << EOF
\copy song From '/home/Sol/Evolution-of-Metal/backend/src/db/tables/song/songs.csv' WITH CSV HEADER DELIMITER ',';
\copy genre From '/home/Sol/Evolution-of-Metal/backend/src/db/tables/genre/genre.csv' WITH CSV HEADER DELIMITER ',';
EOF
