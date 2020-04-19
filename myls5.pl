#!/usr/bin/perl

use Cwd;
$dirname=cwd();
$lopt=0;
$Lopt=0;

sub rwx
{
	$rwx="";
	if($_[0]==7) {$rwx = "rwx";}
	elsif($_[0]==6) {$rwx = "rw-";}
	elsif($_[0]==5) {$rwx = "r-x";}
	elsif($_[0]==4) {$rwx = "r--";}
	elsif($_[0]==3) {$rwx = "-wx";}
	elsif($_[0]==2) {$rwx = "-w-";}
	elsif($_[0]==1) {$rwx = "--x";}
	else {$rwx = "---";}
	return $rwx;
}

for($i=0;$i<=$#ARGV;$i++)
{
	if($ARGV[$i] eq '-l')
	{
		$lopt=1;
	}
	elsif($ARGV[$i] eq '-L')
	{
		$Lopt=1;
	}
	else
	{
		$dirname=$ARGV[$i];
	}
}

opendir $dir,$dirname or die "Nie znaleziono folderu!\n";
@files = readdir $dir;
closedir $dir;

for($i=2;$i<=$#files;$i++)
{
	$line=$files[$i];
	
	if($lopt)
	{
		for($j=length $line;$j<30;$j++)
		{
			$line .= "-";
		}
		$line .= " ";
		
		$size = (stat($files[$i]))[7];
		$line .= $size;
		for($j=length $line;$j<40;$j++)
		{
			$line .= "-";
		}
		$line .= " ";
		
		$line .= localtime((stat($files[$i]))[9]);
		$line .= " ";
		
		$mode = (stat($files[$i]))[2];
		$permissions = "";
		
		use Fcntl ':mode';
		
		#jest katalogiem
		if(S_ISDIR($mode)) {$permissions .= "d";}
		else {$permissions .= "-";}
		
		$user_rwx      = ($mode & S_IRWXU) >> 6;
		$permissions .= rwx($user_rwx);
		
		$group_rwx    = ($mode & S_IRWXG) >> 3;
		$permissions .= rwx($group_rwx);
		
		$other_rwx =  $mode & S_IRWXO;
		$permissions .= rwx($other_rwx);

		$line .= $permissions;
		
	}
	
	if($Lopt)
	{
		if(!$lopt)
		{
			for($j=length $line;$j<30;$j++)
			{
				$line .= "-";
			}
			$line .= " ";
		}
		else
		{
			$line .= " ";
		}
		
		$uid = (stat($files[$i]))[4];
		$name  = getpwuid($uid);
		$line .= $name;
	}
	
	printf $line . "\n";
}
