#!/usr/bin/perl

binmode(STDOUT, "encoding(UTF-8)");

print "Podaj nazwe pliku html: ";
$filename = <STDIN>;
#stdin wczytuje enter na koncu, dlatego skracam zmienna o jeden znak
$filename = substr $filename, 0, (length $filename) - 1;

unless (-e $filename)
{
	print "Wskazany plik nie istnieje!";
	exit;
}

open(fh, "<:encoding(UTF-8)", $filename) or die "Nie mozna otworzyc pliku!";


@a = split(m/(\\)/, $filename);
$path="";
$tfn = $a[-1];
if($#a!=0)
{
	$path = substr $filename, 0, (length $filename - length $tfn);
}

@a = split('\.',$tfn);
$tfn = substr $tfn, 0, ((length $tfn) - (length $a[-1]));
$newfilename = $path . $tfn . "csv";

open(nfh, '>:encoding(UTF-8)', $newfilename) or die "Nie można utworzyc pliku: $!";


$un = 0;

while (<fh>)
{
	if($_ =~ m/(<tbody>)/)
	{
		$line = $_;
		@tablerows = split(m/(<\/tr>)/, $line);
		foreach $row(@tablerows)
		{
			@tableelements = split(m/(<\/td>)/, $row);
			next if($#tableelements <= 3);
			for($i = 0; $i <=$#tableelements ; $i++)
			{	
				$element=$tableelements[$i];
				next if($element =~ m/(<\/td>)/);
				if($element =~ m/(<a\ href)/)
				{
					if($element =~ m/((>)[\S\ ]{1,50}(<))/){}
					$name = substr $1, 1, (length $1) - 2;
					if($name eq "a hre")
					{
						$temp = "-unknow_user_" . $un . "-";
						$name = $temp;
						$un++;
					}
					$line = "\"" . $name . "\"";					
					
					if($element =~ m/((users\/)[\S]{1,30}(">))/){}
					$user = substr $1, 6, (length $1) - 8;
					$line .= "," ."\"" . $user . "\"";
				}
								
				if($element =~ m/((>)[0-9]{1,2}+\.[0-9]{2}+)/)
				{
					$score = substr $1, 1;
					
					@temp = split('\.', $score);
					$score = $temp[0] . "," . $temp[1];
					
					$line = $line . "," ."\"" . $score . "\"";
				}
				elsif($element =~ m/(>-)/)
				{
					$score = "0,00";
					$line = $line . "," ."\"" . $score . "\"";
				}
				
			}
			
			$line.= "\n";
			print nfh $line;

		}
	}
}

close(fh);
close(nfh);

print "Plik $newfilename zostal wygenerowany! \n";