-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CheckIn" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "attendeeId" INTEGER NOT NULL,
    CONSTRAINT "CheckIn_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES "attendees" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_CheckIn" ("attendeeId", "createAt", "id") SELECT "attendeeId", "createAt", "id" FROM "CheckIn";
DROP TABLE "CheckIn";
ALTER TABLE "new_CheckIn" RENAME TO "CheckIn";
CREATE UNIQUE INDEX "CheckIn_attendeeId_key" ON "CheckIn"("attendeeId");
CREATE TABLE "new_attendees" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "eventId" TEXT NOT NULL,
    CONSTRAINT "attendees_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "events" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_attendees" ("createdAt", "email", "eventId", "id", "name") SELECT "createdAt", "email", "eventId", "id", "name" FROM "attendees";
DROP TABLE "attendees";
ALTER TABLE "new_attendees" RENAME TO "attendees";
CREATE UNIQUE INDEX "attendees_eventId_email_key" ON "attendees"("eventId", "email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
