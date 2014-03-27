// MIT OpenCourseWare - Offline JS file

function clearSearchBox()
{
	if(document.getElementById("terms").value == "Search")
	{
		document.getElementById("terms").value = "";	
	}
}

function fillSearchBox()
{
	if(document.getElementById("terms").value == "")
	{
		document.getElementById("terms").value = "Search";	
	}
}

function clearEmailBox()
{
	if(document.getElementById("email").value == "Enter Email")
	{
		document.getElementById("email").value = "";	
	}	
} 

function fillEmailBox()
{
	if(document.getElementById("email").value == "")
	{
		document.getElementById("email").value = "Enter Email";	
	}
}

function OnTranslatedCoursesChange(url)
{
	if(url !="")
	{
		location = "http://ocw.mit.edu"+url;
	}
}