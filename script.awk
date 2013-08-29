BEGIN { 
	FS = "," 
} 
{	for (i=1; i<=30; i++)
{
	split ($i,a,":")
	identi=substr(a[1], 3, length(a[1]) - 3)
	if (identi == "hd")
		print substr(a[2], 3, length(a[2]) - 3)
}
}
