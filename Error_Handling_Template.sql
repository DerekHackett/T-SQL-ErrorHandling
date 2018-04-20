CREATE PROCEDURE [Error_Handling_Template]
@pInput INT
AS
BEGIN TRY
    -- Stops the count of the number of rows affected messages
    SET NOCOUNT ON;
    -- Automatically roll back the transaction when a run time error occurs(THROW works here but RAISERROR does not)
    SET XACT_ABORT ON;

    -- You can add any code you dont want in a the transaction here

    BEGIN TRANSACTION

    -- This is where your code should be and remember you should try and
    -- use only one TRANSACTION.

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH
    -- 0 = no active transaction needing to be rolled back
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    
    EXEC Base.dbo.spLog @ObjectID = @@PROCID;

    THROW; -- If you want the error to bubble up to the next level use throw

END CATCH
GO