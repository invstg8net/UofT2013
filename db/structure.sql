CREATE TABLE "answers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "question_id" integer, "answered" boolean DEFAULT 'f', "body" text, "researcher_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "experts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "topic" varchar(32) NOT NULL, "researcher_count" integer DEFAULT 1, "active" boolean DEFAULT 't');
CREATE TABLE "privacies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "researcher_id" integer, "namepriv" integer DEFAULT 0, "emailpriv" integer DEFAULT 0, "phonepriv" integer DEFAULT 0, "expertisepriv" integer DEFAULT 0);
CREATE TABLE "questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "topic" varchar(255), "phone_number" varchar(255), "body" text, "created_at" datetime NOT NULL, "updated_at" datetime, "escalated" boolean DEFAULT 'f', "needed_by" datetime, "appended_info" varchar(255));
CREATE TABLE "researchers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "email" varchar(255), "password_hash" varchar(255), "password_salt" varchar(255), "phone_number" varchar(255), "name" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "superuser" boolean DEFAULT 'f', "Is_Admin" boolean DEFAULT 'f', "max_questions" integer DEFAULT 3, "textcap" integer DEFAULT 5, "rating" integer DEFAULT 0, "rating_n" integer DEFAULT 0, "status" integer DEFAULT 0, "activated" boolean DEFAULT 'f', "expertise" varchar(255), "pref_contact" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('20120602175842');

INSERT INTO schema_migrations (version) VALUES ('20120602181046');

INSERT INTO schema_migrations (version) VALUES ('20120602183136');

INSERT INTO schema_migrations (version) VALUES ('20120602192213');

INSERT INTO schema_migrations (version) VALUES ('20120602193218');

INSERT INTO schema_migrations (version) VALUES ('20130313040602');

INSERT INTO schema_migrations (version) VALUES ('20130401062218');

INSERT INTO schema_migrations (version) VALUES ('20131111224728');