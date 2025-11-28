INSERT INTO NatureOfWork_Fact (NatureOfWork_id, Gender_id, Gov_id, Total)
SELECT 
    nw.NatureOfWork_id,
    g.Gender_id,
    gv.Gov_id,
    f.Total
FROM NatureOfWorkFlat f
JOIN NatureOfWork nw ON LTRIM(RTRIM(f.NatureOfWork_Name)) = nw.NatureOfWork_Name
JOIN Gender g ON LTRIM(RTRIM(f.Gender_Type)) = g.Gender_Type
JOIN Governorates gv ON LTRIM(RTRIM(f.Governorate)) = gv.Gov_Name;
-----------------------------------
CREATE TABLE EmpAndAge_Fact (
    EmpAndAgeFact_id INT PRIMARY KEY IDENTITY(1,1),
    Gov_id INT NOT NULL,
    Gender_id INT NOT NULL,
    AgeGroup_id INT NOT NULL,
    Total INT,
    FOREIGN KEY (Gov_id) REFERENCES Governorates(Gov_id),
    FOREIGN KEY (Gender_id) REFERENCES Gender(Gender_id),
    FOREIGN KEY (AgeGroup_id) REFERENCES Age_Group(AgeGroup_id)
);
-------------------------------------
INSERT INTO EmpAndAge_Fact (Gov_id, Gender_id, AgeGroup_id, Total)
SELECT 
    gv.Gov_id,
    g.Gender_id,
    ag.AgeGroup_id,
    f.Total
FROM [Emp&Age] f
JOIN Governorates gv ON f.Governorate = gv.Gov_Name
JOIN Gender g ON f.Gender_Type = g.Gender_Type
JOIN Age_Group ag ON f.Age_Range = ag.Age_Range;
---------------------
INSERT INTO Educational_Status_Fact (Gov_id, Gender_id, EduStatus_id, Total)
SELECT 
    gv.Gov_id,
    g.Gender_id,
    es.EduStatus_id,
    f.Total
FROM Educational_Status f
JOIN Governorates gv ON f.Governorate = gv.Gov_Name
JOIN Gender g ON f.Gender_Type = g.Gender_Type
JOIN Educational es ON f.Status = es.Status;
