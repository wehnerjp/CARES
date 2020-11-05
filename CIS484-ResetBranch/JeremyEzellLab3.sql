CREATE PROCEDURE dbo.Auth
	@Email AS NCHAR(50),
	@Password AS NCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP (1) * 
	FROM UserInfo
	Where Email = @Email
	AND Password = @Password;

	End