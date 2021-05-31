DROP TABLE "MEMBER";

CREATE TABLE "MEMBER" (
	"M_NO"	NUMBER		NOT NULL,
	"M_EMAIL"	VARCHAR2(50)		NOT NULL,
	"M_PWD"	VARCHAR2(40)		NOT NULL,
	"M_NAME"	VARCHAR2(30)		NOT NULL,
	"M_GENDER"	CHAR(2)		NOT NULL,
	"M_ADDRESS"	VARCHAR2(50)		NOT NULL,
	"M_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"M_ETC"	VARCHAR2(10)		NULL,
	"M_AUTH"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."M_AUTH" IS '0=관리자 / 1=일반회원';

DROP TABLE "COMMENT";

CREATE TABLE "COMMENT" (
	"C_NO"	NUMBER		NOT NULL,
	"C_BODY"	VARCHAR2(255)		NOT NULL,
	"C_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"Q_NO"	NUMBER		NOT NULL,
	"M_NO"	NUMBER		NOT NULL
);

DROP TABLE "GYM";

CREATE TABLE "GYM" (
	"G_NO"	NUMBER		NOT NULL,
	"G_NAME"	VARCHAR2(30)		NOT NULL,
	"G_ADDRESS"	VARCHAR2(50)		NULL,
	"G_EDU_YN"	CHAR(2)		NULL,
	"G_SCORE"	NUMBER		NULL,
	"G_YCODE"	VARCHAR2(10)		NULL,
	"G_XCODE"	VARCHAR2(10)		NULL,
	"G_PARKING_LOT"	VARCHAR2(50)		NULL,
	"G_HOME_PAGE"	VARCHAR2(100)		NULL,
	"G_IN_OUT"	CHAR(2)		NULL,
	"G_GU_NM"	VARCHAR2(20)		NULL,
	"G_TYPE_NM"	VARCHAR2(10)		NOT NULL,
	"G_TEL"	VARCHAR2(20)		NULL
);

DROP TABLE "REVIEW";

CREATE TABLE "REVIEW" (
	"R_NO"	NUMBER		NOT NULL,
	"R_BODY"	VARCHAR2(100)		NOT NULL,
	"R_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"R_TOTAL"	NUMBER		NULL,
	"R_TEACHER"	NUMBER		NULL,
	"R_SERVICE"	NUMBER		NULL,
	"R_GYM"	NUMBER		NULL,
	"R_KEYWORD"	VARCHAR2(50)		NULL,
	"R_STATUS"	CHAR(2)	DEFAULT 'N'	NOT NULL,
	"M_NO"	NUMBER		NOT NULL,
	"G_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW"."R_STATUS" IS 'Y=삭제됨 / N=삭제되지 않음';

DROP TABLE "BOARD";

CREATE TABLE "BOARD" (
	"Q_NO"	NUMBER		NOT NULL,
	"Q_TITLE"	VARCHAR2(100)		NOT NULL,
	"Q_BODY"	VARCHAR2(2000)		NOT NULL,
	"Q_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"Q_COUNT"	NUMBER		NULL,
	"Q_SECRET"	CHAR(2)	DEFAULT 'Y'	NOT NULL,
	"Q_STATUS"	CHAR(2)	DEFAULT 'N'	NOT NULL,
	"Q_BOARD_DIV"	CHAR(2)	DEFAULT 'Q'	NOT NULL,
	"M_NUM"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."Q_SECRET" IS 'Y=공개 / N=비공개';

COMMENT ON COLUMN "BOARD"."Q_STATUS" IS 'Y=삭제됨 / N=삭제되지 않음';

COMMENT ON COLUMN "BOARD"."Q_BOARD_DIV" IS 'F=FAQ/Q=QNA';

DROP TABLE "FAVORITES";

CREATE TABLE "FAVORITES" (
	"F_NO" NUMBER		NOT NULL,
	"M_NO"	NUMBER		NOT NULL,
	"G_NO"	NUMBER		NOT NULL
);

DROP TABLE "REVIEW_FILE";

CREATE TABLE "REVIEW_FILE" (
	"R_FILE_NO"	NUMBER		NOT NULL,
	"R_FILE"	VARCHAR2(500)		NULL,
	"R_NO"	NUMBER		NOT NULL
);

DROP TABLE "QNA_FILE";

CREATE TABLE "QNA_FILE" (
	"Q_FILE_NO"	NUMBER		NOT NULL,
	"Q_FILE"	VARCHAR2(500)		NULL,
	"Q_NO"	NUMBER		NOT NULL
);

DROP TABLE "GYM_FILE";

CREATE TABLE "GYM_FILE" (
	"G_FILE_NO"	NUMBER		NOT NULL,
	"G_FILE"	VARCHAR2(500)		NULL,
	"G_FILE_LV"	NUMBER	DEFAULT 1	NULL,
	"G_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "GYM_FILE"."G_FILE_LV" IS '0=썸/1=일반';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"M_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"C_NO"
);

ALTER TABLE "GYM" ADD CONSTRAINT "PK_GYM" PRIMARY KEY (
	"G_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY (
	"R_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"Q_NO"
);

ALTER TABLE "FAVORITES" ADD CONSTRAINT "PK_FAVORITES" PRIMARY KEY (
	"F_NO"
);

ALTER TABLE "REVIEW_FILE" ADD CONSTRAINT "PK_REVIEW_FILE" PRIMARY KEY (
	"R_FILE_NO"
);

ALTER TABLE "QNA_FILE" ADD CONSTRAINT "PK_QNA_FILE" PRIMARY KEY (
	"Q_FILE_NO"
);

ALTER TABLE "GYM_FILE" ADD CONSTRAINT "PK_GYM_FILE" PRIMARY KEY (
	"G_FILE_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT_1" FOREIGN KEY (
	"Q_NO"
)
REFERENCES "BOARD" (
	"Q_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"M_NO"
)
REFERENCES "MEMBER" (
	"M_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEMBER_TO_REVIEW_1" FOREIGN KEY (
	"M_NO"
)
REFERENCES "MEMBER" (
	"M_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_GYM_TO_REVIEW_1" FOREIGN KEY (
	"G_NO"
)
REFERENCES "GYM" (
	"G_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"M_NUM"
)
REFERENCES "MEMBER" (
	"M_NO"
);

ALTER TABLE "FAVORITES" ADD CONSTRAINT "FK_MEMBER_TO_FAVORITES_1" FOREIGN KEY (
	"M_NO"
)
REFERENCES "MEMBER" (
	"M_NO"
);

ALTER TABLE "FAVORITES" ADD CONSTRAINT "FK_GYM_TO_FAVORITES_1" FOREIGN KEY (
	"G_NO"
)
REFERENCES "GYM" (
	"G_NO"
);

ALTER TABLE "REVIEW_FILE" ADD CONSTRAINT "FK_REVIEW_TO_REVIEW_FILE_1" FOREIGN KEY (
	"R_NO"
)
REFERENCES "REVIEW" (
	"R_NO"
);

ALTER TABLE "QNA_FILE" ADD CONSTRAINT "FK_BOARD_TO_QNA_FILE_1" FOREIGN KEY (
	"Q_NO"
)
REFERENCES "BOARD" (
	"Q_NO"
);

ALTER TABLE "GYM_FILE" ADD CONSTRAINT "FK_GYM_TO_GYM_FILE_1" FOREIGN KEY (
	"G_NO"
)
REFERENCES "GYM" (
	"G_NO"
);

