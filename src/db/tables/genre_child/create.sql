CREATE TABLE genre_child (
  gid INT references genre(id),
  child_id INT references genre(id),
  PRIMARY KEY (gid, child_id)
);
