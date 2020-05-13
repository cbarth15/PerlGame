#!/usr/bin/perl -w
use Tk;
use strict;
use Time::HiRes;
use lib '.';
use object;

my $x=150;
my $y=150;
my $velocity=0;
my $below=150;
my @objects=();

my $mw=MainWindow->new;
$mw->Label(-text => "Game 1")->pack;
my $canvas=$mw->Canvas(-height=>300,-width=>300)->pack;
my $ground=$canvas->createRectangle(0,170,300,300, -fill=>'azure');
my $id=$canvas->createBitmap($x,$y, -bitmap=>'@Stick.XBM');
my $test_box=$canvas->createRectangle(250,170,300,120,-fill=>'green');
push @objects, new object(250,170,300,120,$test_box);
print "$test_box\n";
sub redrawIcon{
	$id=$canvas->createBitmap($x,$y, -bitmap=>'@Stick.XBM');
}
sub gravity{
	if($y<$below && ($velocity==0 ||$velocity==-1))
	{

		$canvas->delete($id);
		$velocity=-1;
		$y+=1;
		redrawIcon();
		$canvas->update();
	}
	else
	{
		$velocity==0;
	}
}

$mw->repeat(100, \&gravity);
sub move{
	my ($widget)= @_;
	my $e=$widget->XEvent;
	my ($keysym_text, $keysym_decimal) = ($e->K, $e->N);
	if($keysym_text eq "w" && $y==$below)
	{
		$velocity=1;
		for(1..20)
		{
			$canvas->delete($id);
			$y-=1;
			redrawIcon();
			Time::HiRes::sleep(.015);
			$canvas->update();
		}
		$velocity=0;
	}
	elsif($keysym_text eq "d")
	{
		foreach my $obj (@objects)
		{
			$canvas->delete($obj->{id});
			$obj->{x1}-=10;	$obj->{y1}-=10;
			$obj->{id}=$canvas->createRectangle($obj->{x1},$obj->{x2},$obj->{y1},$obj->{y2},-fill=>'green');

		}

	}
	elsif($keysym_text eq "a")
	{

	}
	elsif($keysym_text eq "s")
	{

	}
}


$mw->bind('<KeyPress>'=> \&move);
MainLoop;
