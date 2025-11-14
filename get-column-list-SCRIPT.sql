-- Builds a list of columns from the table defined in @TABLE_NAME
-- you can turn on identing, using commas and whether or not to wrap
-- the column name in brackets

DECLARE
	-- these would be parameters passed into the stored procedure
	-- if that form of the code was used
	@TABLE_NAME nvarchar(255) = N'mail_list',
	@USE_INDENT bit = 1,
	@USE_BRACKETS bit = 1,
	@USE_COMMA bit = 1,
	@USE_CRLF bit = 1

DECLARE
	-- these would be local variables if this code was converted to a stored procedure
	@COLCT int,
	@RETURN_STRING nvarchar(MAX)

SELECT @COLCT = COUNT(*) FROM sys.columns WHERE [object_id] = OBJECT_ID(@TABLE_NAME)

SELECT 
	A.[column_id],

	-- Beginning of column name text
    CASE @USE_INDENT
        WHEN 1 THEN CHAR(9)
        ELSE ''
    END +
	CASE @USE_BRACKETS 
		WHEN 1 THEN '['
		ELSE ''
	END +
	A.[name] + 
	+ 
	CASE @USE_BRACKETS 
		WHEN 1 THEN ']'
		ELSE ''
	END +
	CASE @USE_COMMA
		WHEN 1 THEN
			CASE column_id
				WHEN @COLCT THEN ''
				ELSE ','
			END
		ELSE ''
	END	+ 
	CASE @USE_CRLF
		WHEN 1 THEN 
			CASE column_id
				WHEN @COLCT THEN ''
				ELSE CHAR(13) + CHAR(10) 
			END
		ELSE ''
	END AS [COL_STRING]
	-- end of column name text
INTO 
	col_name_table
FROM 
	sys.columns A
INNER JOIN 
	sys.tables B
ON
	A.[object_id] = b.[object_id]
WHERE
	A.[object_id] = OBJECT_ID(@TABLE_NAME)

SELECT @RETURN_STRING = STRING_AGG(COL_STRING, '') WITHIN GROUP (ORDER BY column_id)
FROM col_name_table

DROP TABLE IF EXISTS col_name_table

-- if converted to a stored procedure, @RETURN_STRING would be the return value.
-- As it's currently setup, you could run this in SSMS, get the result in text
-- format and copy it
PRINT CHAR(13) + CHAR(10)
PRINT @RETURN_STRING 