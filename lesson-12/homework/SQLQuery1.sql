-- task 1
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'';

SELECT @sql = @sql + 
'SELECT 
    ''' + name + ''' AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType
FROM ' + QUOTENAME(name) + '.sys.tables t
JOIN ' + QUOTENAME(name) + '.sys.schemas s ON t.schema_id = s.schema_id
JOIN ' + QUOTENAME(name) + '.sys.columns c ON t.object_id = c.object_id
JOIN ' + QUOTENAME(name) + '.sys.types ty ON c.user_type_id = ty.user_type_id
WHERE name NOT IN (''master'', ''tempdb'', ''model'', ''msdb'')
UNION ALL
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

-- Remove the last UNION ALL
SET @sql = LEFT(@sql, LEN(@sql) - 10);

-- Execute the dynamic SQL
EXEC sp_executesql @sql;


-- task 2
CREATE PROCEDURE GetProceduresAndFunctions 
    @DatabaseName NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = N'';

    -- Collect info for either a specific database or all databases
    SELECT @sql = @sql + 
    'SELECT 
        ''' + name + ''' AS DatabaseName,
        s.name AS SchemaName,
        p.name AS ProcedureOrFunctionName,
        p.type_desc AS ObjectType,
        pa.name AS ParameterName,
        ty.name AS DataType,
        pa.max_length AS MaxLength
    FROM ' + QUOTENAME(name) + '.sys.objects p
    JOIN ' + QUOTENAME(name) + '.sys.schemas s ON p.schema_id = s.schema_id
    LEFT JOIN ' + QUOTENAME(name) + '.sys.parameters pa ON p.object_id = pa.object_id
    LEFT JOIN ' + QUOTENAME(name) + '.sys.types ty ON pa.user_type_id = ty.user_type_id
    WHERE p.type IN (''P'', ''FN'', ''IF'', ''TF'') -- P: Procedure, FN: Scalar Function, IF: Inline Table Function, TF: Table Function
    AND name NOT IN (''master'', ''tempdb'', ''model'', ''msdb'')
    ' + CASE WHEN @DatabaseName IS NULL THEN 'UNION ALL ' ELSE '' END
    FROM sys.databases
    WHERE @DatabaseName IS NULL OR name = @DatabaseName;

    -- Remove last UNION ALL if needed
    IF @DatabaseName IS NULL
        SET @sql = LEFT(@sql, LEN(@sql) - 10);

    -- Execute dynamic SQL
    EXEC sp_executesql @sql;
END

EXEC GetProceduresAndFunctions;

EXEC GetProceduresAndFunctions @DatabaseName = 'TSQLV6';

