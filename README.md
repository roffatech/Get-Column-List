# Get-Column-List
Given a table name, will produce a list of columns for that table. Especially useful in tables with a lot of columns

In my work I have often had to deal with tables having many columns. Some are over 80 columns!

I am not going to debate the merits of whether or not a table should have so many columns. These tables are created by someone else, I have to use them in my work, and making them have fewer columns is not an option. Maybe you are in a similar situation. 

In my work, I also often find that I have to create statements that are column dependent. Maybe I need to build a statement that lists or assigns values to the columns individually. If this list is lengthy, it woukld also be nice to have a tool that handles wrapping each column name in brackets, separating the column names with commas, adding carriage return/line feeds after each column name and indenting the list with a tab character. 

I intend to setup the code in this repository in the form of a script that you can run in SSMS, a stored procedure with an OUTPUT parm, and other formats as I see fit. 

In a nutshell, the code builds a list of columns for the table provided using the sys.columns and sys.tables meta data tables that define table structure in SQL Server. 

If using the script version of the code, users can run the code in an tool like SSMS, edit the settings for whether or not they want the list indented, to have the names wrapped in brackets, and to have a CR/LF after each column name.
