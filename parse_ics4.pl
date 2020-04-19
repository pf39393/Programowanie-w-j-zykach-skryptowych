#!/usr/bin/perl

if(!$ARGV[0])
{
	print STDERR "Nie podano nazwy pliku .ics! Nazwa pliku MUSI zostac podana jako argument wywolania skryptu.";
	exit;
}
else
{
	$filename = $ARGV[0];
}

open(fh, "<:encoding(UTF-8)", $filename) or die "Nie mozna otworzyc pliku!";

@hours=();
@names=();
@types=();
@studies=();
$records=0;

while(<fh>)
{
	if($_ =~ m/((SUMMARY)[A-za-z0-9\:\.\,\ \-]+(Sala))/)
	{
		$line = $1;
		
		if($line =~ m/((SUMMARY)[A-za-z0-9\:\.\,\ ]+)/){}
		$name = substr $1, 8;
		
		if($line =~ m/((\_)[LWA])/){}
		$type = substr $1, 1;
		
		if($line =~ m/((Grupa: )[A-Za-z1-9\_\ ]+)/){}
		$study = substr $1, 7;
		$temp = substr $study, 0 , 2;
		if($temp =~ m/([SN][1-9])/) { $study = $temp }
		elsif($temp =~ m/(PO)/)
		{
			if($study =~ m/((PO\ )[A-Z]+)/){}
			$study = $1;
		}
		elsif($temp =~ m/(la)/)
		{
			if($study =~ m/((lato_)[A-Za-z1-9]+)/){}
			$temp = substr $1, 5;
			$study = "lato " . $temp;
		}
		else
		{
			if($study =~ m/([A-Za-z1-9]+)/){}
			$study = $1;
		}
		
		#printf "P: " . $name . " T: " . $type . " S: " . $study . "\n";
		
		$found=-1;
		
		for($i = 0; $i <= $records; $i++)
		{
			if(($names[$i] eq $name) && ($types[$i] eq $type)  && ($studies[$i] eq $study))
			{
				$found = $i;
			}
		}
		
		if($found eq -1)
		{
			$hours[$records+1]=1;
			$names[$records+1]=$name;
			$types[$records+1]=$type;
			$studies[$records+1]=$study;
			$records++;
		}
		else
		{
			$hours[$found]++;
		}
		
	}
}

$label = "Nazwa przedmiotu";
for($i = length $label; $i <= 30; $i++) { $label .= " "; } #30
$label .= "Typ  "; #35
$label .= "Studia";
for($i = length $label; $i <= 50; $i++) { $label .= " "; } #50
$label .= "Ilosc godzin";

printf $label . "\n";

for($i = 0; $i <= $records; $i++)
{
	$record = $names[$i];
	for($j = length $record; $j <= 30; $j++) { $record .= " "; }
	$record .= $types[$i];
	for($j = length $record; $j <= 35; $j++) { $record .= " "; }
	$record .= $studies[$i];
	for($j = length $record; $j <= 50; $j++) { $record .= " "; }
	$record .= $hours[$i];
	printf $record . "\n";
}