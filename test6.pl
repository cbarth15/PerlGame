#!/usr/bin/perl -w
use Tk;
use strict;
use Time::HiRes;
use lib '.';
use object;

my $x=150;
#y holds the current y value of the character (up and down)
my $y=50;
my $velocity=0;
#below holds the current value for the height of the floor beneath the character
my $below=145;
#onObject determines if the player is on an object or not
my $onObject=0;
#the objects array holds all current visible objects on the screen
#It is used to cycle through for character collision and all the objects need
#to be moved left when the character "moves" right
my @objects=();

my $mw=MainWindow->new;
$mw->Label(-text => "Game 1")->pack;
my $canvas=$mw->Canvas(-height=>300,-width=>300)->pack;
#this is me making the ground
my $ground=$canvas->createRectangle(0,170,300,300, -fill=>'azure');
#this is me making the player
my $id=$canvas->createBitmap($x,$y, -bitmap=>'@Stick.XBM');
my $test_box=$canvas->createRectangle(250,170,300,120,-fill=>'green');
#adding the box to the objects array
push @objects, new object(250,170,300,120,$test_box);

sub redrawIcon{
	$id=$canvas->createBitmap($x,$y, -bitmap=>'@Stick.XBM');
}
sub gravity{
	$onObject=0;
	foreach my $obj (@objects)								#Sets boolean value base on if player is standing on object
	{
		if ($obj->{x1} <=150 && $obj->{y1} >= 150 && ($obj->{y2}-25==$y))
		{
			$onObject=1;
		}
	}
	if ($onObject)
	{
	}
	elsif($y<$below && ($velocity==0 ||$velocity==-1))
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

#putting in gravity, repeat works by executing the function referenced
#every so milisecond.
$mw->repeat(25, \&gravity);
sub move{
	my ($widget)= @_;
	my $e=$widget->XEvent;
	my ($keysym_text, $keysym_decimal) = ($e->K, $e->N);
	if($keysym_text eq "w" && ($y==$below || $onObject==1))
	{
		$velocity=1;
		for(1..60)
		{
			$canvas->delete($id);
			$y-=1;
			redrawIcon();
			Time::HiRes::sleep(.015);
			$canvas->update();
		}
		$velocity=0;
	}
	elsif($keysym_text eq "d" || $keysym_text eq "a")		#horizontal keys
	{
		my $dontMove=0;
		#first check if the player ran into an obstacle without jumping over
		foreach my $obj (@objects)
		{
			if($keysym_text eq "d")
			{
				if($obj->{x1}-5==150 && $obj->{y2}-25<$y)
					{$dontMove=1;}	
			}
			else
			{
				if($obj->{y1}+5==150 && $obj->{y2}-25<$y)
				{$dontMove=1;}
			}
		}
		if ($dontMove==0)
		{
			if($keysym_text eq "d")
			{
				foreach my $obj (@objects)
				{
					$canvas->delete($obj->{id});
					$obj->{x1}-=5;	$obj->{y1}-=5;
					$obj->{id}=$canvas->createRectangle($obj->{x1},$obj->{x2},$obj->{y1},$obj->{y2},-fill=>'green');

				}
			}
			else
			{
				foreach my $obj (@objects)
				{
					$canvas->delete($obj->{id});
					$obj->{x1}+=5;	$obj->{y1}+=5;
					$obj->{id}=$canvas->createRectangle($obj->{x1},$obj->{x2},$obj->{y1},$obj->{y2},-fill=>'green');

				}
			}
		}
	}
}


$mw->bind('<KeyPress>'=> \&move);
MainLoop;
