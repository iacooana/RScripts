#Checks to see if a Data folder exists and if not, creates the folder called Data;

if (!file.exists("Data"))
{
  dir.create("Data")
}
list.files(getwd())

