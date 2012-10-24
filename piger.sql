create table Piger (
	id			Integer PRIMARY KEY,
	navn		text,
	alder		Integer,
	hjemby		text,
	fotograf	text,
	dato	date DEFAULT date('now')
	)