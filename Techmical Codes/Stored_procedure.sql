--========================CRUD EconomyAndAge_Fact====================================
CREATE PROCEDURE CreateEconomyAndAgeFact 
    @Economy_id INT,
    @Gender_id INT,
    @AgeGroup_id INT,
    @AreaType_id INT,
    @Total INT
AS
BEGIN
    INSERT INTO EconomyAndAge_Fact (Economy_id, Gender_id, AgeGroup_id, AreaType_id, Total)
    VALUES (@Economy_id, @Gender_id, @AgeGroup_id, @AreaType_id, @Total)
END
GO
---------------------------------------------------------------------------------
CREATE PROCEDURE ReadEconomyAndAgeFact 
    @Economy_id INT,
    @Gender_id INT,
    @AgeGroup_id INT,
    @AreaType_id INT
AS
BEGIN
    SELECT Economy_id, Gender_id, AgeGroup_id, AreaType_id, Total
    FROM EconomyAndAge_Fact
    WHERE Economy_id = @Economy_id
      AND Gender_id = @Gender_id
      AND AgeGroup_id = @AgeGroup_id
      AND AreaType_id = @AreaType_id
END
GO
---------------------------------------------------------------------------------
CREATE PROCEDURE UpdateEconomyAndAgeFact 
    @Economy_id INT,
    @Gender_id INT,
    @AgeGroup_id INT,
    @AreaType_id INT,
    @Total INT
AS
BEGIN
    UPDATE EconomyAndAge_Fact
    SET Total = @Total
    WHERE Economy_id = @Economy_id
      AND Gender_id = @Gender_id
      AND AgeGroup_id = @AgeGroup_id
      AND AreaType_id = @AreaType_id
END
GO
---------------------------------------------------------------------------------
CREATE PROCEDURE DeleteEconomyAndAgeFact 
    @Economy_id INT,
    @Gender_id INT,
    @AgeGroup_id INT,
    @AreaType_id INT
AS
BEGIN
    DELETE FROM EconomyAndAge_Fact
    WHERE Economy_id = @Economy_id
      AND Gender_id = @Gender_id
      AND AgeGroup_id = @AgeGroup_id
      AND AreaType_id = @AreaType_id
END
GO
