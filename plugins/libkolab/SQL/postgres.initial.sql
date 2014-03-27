/**
 * libkolab database schema
 *
 * @version 1.0
 * @author Thomas Bruederli
 * @author Diane Trout
 * @licence GNU AGPL
 **/


DROP TABLE IF EXISTS kolab_folders CASCADE ;

CREATE TABLE kolab_folders (
  folder_id SERIAL PRIMARY KEY,
  resource VARCHAR(255) NOT NULL,
  type VARCHAR(32) NOT NULL,
  synclock NUMERIC(10) NOT NULL DEFAULT '0',
  ctag VARCHAR(40) DEFAULT NULL
);

DROP INDEX IF EXISTS resource_types;
CREATE INDEX resource_type on kolab_folders  (resource, type);

DROP TABLE IF EXISTS kolab_cache;
DROP TABLE IF EXISTS kolab_cache_contact CASCADE;

CREATE TABLE kolab_cache_contact (
  folder_id BIGINT NOT NULL,
  msguid BIGINT NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  type VARCHAR(32) NOT NULL,
  name VARCHAR(255) NOT NULL,
  firstname VARCHAR(255) NOT NULL,
  surname VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  CONSTRAINT fk_kolab_cache_contact_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);
CREATE INDEX contact_type ON kolab_cache_contact (folder_id, type);

DROP TABLE IF EXISTS kolab_cache_event CASCADE;

CREATE TABLE kolab_cache (
  resource character varying(255) NOT NULL,
  type character varying(32) NOT NULL,
  msguid NUMERIC(20) NOT NULL,
  uid character varying(128) NOT NULL,
  created timestamp without time zone DEFAULT NULL,
  changed timestamp without time zone DEFAULT NULL,
  data text NOT NULL,
  xml text NOT NULL,
  dtstart timestamp without time zone,
  dtend timestamp without time zone,
  tags character varying(255) NOT NULL,
  words text NOT NULL,
  filename character varying(255) DEFAULT NULL,
  PRIMARY KEY(resource, type, msguid)
CREATE TABLE kolab_cache_event (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  dtstart timestamp with time zone,
  dtend timestamp with time zone,
  CONSTRAINT fk_kolab_cache_event_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);

CREATE INDEX kolab_cache_resource_filename_idx ON kolab_cache (resource, filename);
DROP TABLE IF EXISTS kolab_cache_task CASCADE;

CREATE TABLE kolab_cache_task (
  folder_id BIGINT NOT NULL,
  msguid BIGINT NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  dtstart timestamp with time zone,
  dtend timestamp with time zone,
  CONSTRAINT fk_kolab_cache_task_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);

DROP TABLE IF EXISTS kolab_cache_journal CASCADE;

CREATE TABLE kolab_cache_journal (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  dtstart timestamp with time zone,
  dtend timestamp with time zone,
  CONSTRAINT fk_kolab_cache_journal_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);

DROP TABLE IF EXISTS kolab_cache_note CASCADE;

CREATE TABLE kolab_cache_note (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  CONSTRAINT fk_kolab_cache_note_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);

DROP TABLE IF EXISTS kolab_cache_file CASCADE;

CREATE TABLE kolab_cache_file (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  filename varchar(255) DEFAULT NULL,
  CONSTRAINT fk_kolab_cache_file_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);
CREATE INDEX folder_filename on kolab_cache_file (folder_id,filename);

DROP TABLE IF EXISTS kolab_cache_configuration CASCADE;

CREATE TABLE kolab_cache_configuration (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  type VARCHAR(32) NOT NULL,
  CONSTRAINT fk_kolab_cache_configuration_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);
CREATE INDEX configuration_type ON kolab_cache_configuration (folder_id,type);

DROP TABLE IF EXISTS kolab_cache_freebusy CASCADE;

CREATE TABLE kolab_cache_freebusy (
  folder_id BIGINT  NOT NULL,
  msguid BIGINT  NOT NULL,
  uid VARCHAR(128) NOT NULL,
  created timestamp with time zone DEFAULT NULL,
  changed timestamp with time zone DEFAULT NULL,
  data TEXT NOT NULL,
  xml xml NOT NULL,
  tags VARCHAR(255) NOT NULL,
  words TEXT NOT NULL,
  dtstart timestamp with time zone,
  dtend timestamp with time zone,
  CONSTRAINT fk_kolab_cache_freebusy_folder FOREIGN KEY (folder_id)
    REFERENCES kolab_folders(folder_id) ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE(folder_id,msguid)
);


INSERT INTO system (name, value) VALUES ('libkolab-version', '2013041900');

