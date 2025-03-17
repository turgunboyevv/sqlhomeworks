use class14

EXEC msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'IndexReportProfile',
    @description = 'Profile for sending index metadata reports';

EXEC msdb.dbo.sysmail_add_account_sp  
    @account_name = 'IndexReportAccount',
    @email_address = 'your_email@example.com',
    @mailserver_name = 'smtp.example.com',
    @username = 'your_username',
    @password = 'your_password',
    @enable_ssl = 1;

EXEC msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'IndexReportProfile',
    @account_name = 'IndexReportAccount',
    @sequence_number = 1;

EXEC msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'IndexReportProfile',
    @principal_name = 'public',
    @is_default = 1;

DECLARE @HTMLBody NVARCHAR(MAX);

SET @HTMLBody = 
    '<html>
    <head>
        <style>
            table { width: 100%; border-collapse: collapse; }
            th, td { border: 1px solid black; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
        <h2>SQL Server Index Metadata Report</h2>
        <table>
            <tr>
                <th>Table Name</th>
                <th>Index Name</th>
                <th>Index Type</th>
                <th>Column Name</th>
            </tr>';

SELECT @HTMLBody = @HTMLBody + 
    '<tr>
        <td>' + t.name + '</td>
        <td>' + i.name + '</td>
        <td>' + i.type_desc + '</td>
        <td>' + c.name + '</td>
    </tr>'
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE t.is_ms_shipped = 0
ORDER BY t.name, i.name, ic.key_ordinal;

SET @HTMLBody = @HTMLBody + 
    '</table>
    </body>
    </html>';

EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = 'IndexReportProfile',
    @recipients = 'recipient@example.com',
    @subject = 'Index Metadata Report',
    @body = @HTMLBody,
    @body_format = 'HTML';
