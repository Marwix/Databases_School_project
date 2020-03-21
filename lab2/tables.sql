CREATE TABLE department(
    D_NAME TEXT NOT NULL,
    D_ABBREVIATIONS  TEXT NOT NULL,

    UNIQUE (D_NAME),
    UNIQUE(D_ABBREVIATIONS),

    PRIMARY KEY (D_NAME,D_ABBREVIATIONS)

);

CREATE TABLE Programs (
P_NAME TEXT NOT NULL,
p_abbreviations TEXT NOT NULL,

UNIQUE (P_NAME),

PRIMARY KEY (P_NAME)
);

CREATE TABLE Students(
    IDNR numeric(10)                 NOT NULL,
    NAME VARCHAR(20)                NOT NULL,
    LOGIN VARCHAR(6)                NOT NULL,
    PROGRAM VARCHAR(20)             NOT NULL,
    UNIQUE(IDNR, PROGRAM),
    UNIQUE(LOGIN),

    PRIMARY KEY (IDNR),
    FOREIGN KEY (PROGRAM) REFERENCES Programs(P_NAME)
);

CREATE TABLE Branches(
    NAME VARCHAR(20)                      ,
    PROGRAM VARCHAR(20)                   ,

    PRIMARY KEY (NAME,PROGRAM)

);

CREATE TABLE StudentBelongsTo(
    s_idnr numeric(10)                NOT NULL,
    s_name TEXT                      NOT NULL,
    s_login  TEXT                      NOT NULL,
    P_NAME TEXT                     NOT NULL,
    B_NAME TEXT                     NOT NULL,

PRIMARY KEY(s_idnr, B_NAME, P_NAME),
FOREIGN KEY(B_NAME, P_NAME) REFERENCES Branches(NAME, PROGRAM),
FOREIGN KEY(s_idnr, P_NAME) REFERENCES Students(IDNR, PROGRAM)

);

CREATE TABLE Courses(
    CODE VARCHAR(6)                       NOT NULL,
    NAME VARCHAR(20)         UNIQUE       NOT NULL,
    CREDITS REAL                           NOT NULL,
    DEPARTMENT VARCHAR(20)                NOT NULL,

    PRIMARY KEY (CODE)

);

CREATE TABLE Prerequisite(
    COURSE TEXT NOT NULL,
    PREREQUISITE TEXT NOT NULL,

    PRIMARY KEY (COURSE),

    FOREIGN KEY (PREREQUISITE) REFERENCES Courses(CODE),
    FOREIGN KEY (COURSE) REFERENCES Courses(CODE)

);


CREATE TABLE OfferedPrograms(
    D_NAME TEXT NOT NULL,
    P_NAME TEXT NOT NULL,

    PRIMARY KEY (D_NAME),

    FOREIGN KEY (P_NAME) REFERENCES Programs(P_NAME),
    FOREIGN KEY (D_NAME) REFERENCES department(D_NAME)


);

CREATE TABLE OfferedCourses(
    COURSE TEXT NOT NULL,
    D_NAME TEXT NOT NULL,

    PRIMARY KEY (D_NAME, COURSE),
    FOREIGN KEY (D_NAME) REFERENCES department(D_NAME),
    FOREIGN KEY (COURSE) REFERENCES Courses(CODE)

);

CREATE TABLE LimitedCourses(
    CODE VARCHAR(6)        UNIQUE      NOT NULL,
    CAPACITY INT                       NOT NULL,

    PRIMARY KEY (CODE) ,

    FOREIGN KEY  (CODE) REFERENCES Courses(CODE)

);

CREATE TABLE StudentBranches(
    STUDENT numeric(10)              NOT NULL,
    BRANCH VARCHAR(20)              NOT NULL,
    PROGRAM VARCHAR(20)             NOT NULL,

    PRIMARY KEY (STUDENT),

    FOREIGN KEY (STUDENT) REFERENCES Students(IDNR),
    FOREIGN KEY (BRANCH, PROGRAM) REFERENCES Branches(NAME, PROGRAM)

);

CREATE TABLE Classifications(
    NAME VARCHAR(20)               NOT NULL,

      PRIMARY KEY (NAME)
);

CREATE TABLE Classified(
    COURSE VARCHAR(20)             NOT NULL,
    CLASSIFICATION VARCHAR(20)     NOT NULL,

    PRIMARY KEY (COURSE, CLASSIFICATION),

    FOREIGN KEY (COURSE) REFERENCES Courses(CODE),
    FOREIGN KEY (CLASSIFICATION) REFERENCES Classifications(NAME)

);

CREATE TABLE MandatoryProgram(
    COURSE VARCHAR(20)            NOT NULL,
    PROGRAM VARCHAR(20)           NOT NULL,

    PRIMARY KEY (COURSE, PROGRAM),

    FOREIGN KEY (COURSE) REFERENCES Courses(CODE)

);

CREATE TABLE MandatoryBranch(
    COURSE VARCHAR(20)           NOT NULL,
    BRANCH VARCHAR(20)           NOT NULL,
    PROGRAM VARCHAR(20)          NOT NULL,

    PRIMARY KEY (COURSE, BRANCH, PROGRAM),

    FOREIGN KEY (COURSE) REFERENCES Courses(CODE),
    FOREIGN KEY  (BRANCH, PROGRAM) REFERENCES Branches(NAME, PROGRAM)

);

CREATE TABLE RecommendedBranch(
    COURSE VARCHAR(20)          NOT NULL,
    BRANCH VARCHAR(20)          NOT NULL,
    PROGRAM VARCHAR(20)         NOT NULL,

    PRIMARY KEY (COURSE, BRANCH, PROGRAM),

    FOREIGN KEY (COURSE) REFERENCES Courses(CODE),
    FOREIGN KEY (BRANCH, PROGRAM) REFERENCES Branches(NAME, PROGRAM)

);

CREATE TABLE Registered(
    STUDENT numeric(10)         NOT NULL,
    COURSE VARCHAR(20)         NOT NULL,

    PRIMARY KEY (STUDENT, COURSE),

    FOREIGN KEY (STUDENT) REFERENCES Students(IDNR),
    FOREIGN KEY (COURSE) REFERENCES Courses(CODE)

);

CREATE TABLE Taken(
    STUDENT numeric(10)         NOT NULL,
    COURSE VARCHAR(20)         NOT NULL,
    GRADE CHAR                 NOT NULL,

    CHECK( GRADE IN ( 'U' ,'3' ,'4' ,'5')),

    PRIMARY KEY (STUDENT, COURSE),

    FOREIGN KEY (STUDENT) REFERENCES Students(IDNR),
    FOREIGN KEY (COURSE) REFERENCES Courses(CODE)

);

CREATE TABLE WaitIngList(
    STUDENT numeric(10)        NOT NULL,
    COURSE VARCHAR(20)       NOT NULL,
    POSITION SERIAL           NOT NULL,

    PRIMARY KEY (STUDENT, COURSE),

    FOREIGN KEY (STUDENT) REFERENCES Students(IDNR),
    FOREIGN KEY (COURSE) REFERENCES LimitedCourses(CODE)


);

