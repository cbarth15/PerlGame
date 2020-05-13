package object;



	sub new{
		$class=shift;
		$self={
			x1=>shift,
			x2=>shift,
			y1=>shift,
			y2=>shift,
			id=>shift,
		};
	
		bless($self, $class);
		return $self;
		}

	sub getX1{
		my $self =@_;
		return $self->{x1};
	}

	sub getX2{
		my $self=@_;
		return $self->{x2};
	}
	sub getY1{
		my $self =@_;
		return $self->{y1};
	}
	sub getY2{
		my $self =@_;
		return $self->{y2};
	}

	sub getId{
		my $self =@_;
		return $self->{id};
	}
	sub setX1{
		my ($self,$x1)=@_;
		$self->{x1}=$x1 if defined($x1);
		return $self->{x1}
	}

	sub setX2{
		my ($self,$x2)=@_;
		$self->{x2}=$x2 if defined($x2);
		return $self->{x2}
	}
	sub setY1{
		my ($self,$y1)=@_;
		$self->{y1}=$y1 if defined($y1);
		return $self->{y1}
	}
	sub setY2{
		my ($self,$y2)=@_;
		$self->{y2}=$y2 if defined($y2);
		return $self->{y2}
	}
	1;
