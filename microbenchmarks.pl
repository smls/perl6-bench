[
 # empty test MUST appear first, so that --ignore-startup will work
 {
  name  => 'empty',
  summarize => 0,
  expected => '',
  perl5 => '',
  perl6 => '',
  nqp   => '',
 },
 {
  name  => 'zero',
  summarize => 0,
  expected => '',
  perl5 => '0',
  perl6 => '0',
  nqp   => '0',
 },
 {
  name  => 'hello',
  summarize => 0,
  expected => "Hello, World!\n",
  perl5 => 'say "Hello, World!"',
  perl6 => 'say "Hello, World!"',
  nqp   => 'say("Hello, World!")',
 },
 {
  name  => 'while_empty',
  tags  => [qw( while )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { ($_[0] + 1) . "\n" },
  perl5 => 'my $i = 0; while (++$i <= SCALE) { }; say $i;',
  perl6 => 'my $i = 0; while (++$i <= SCALE) { }; say $i;',
  nqp   => 'my $i := 0; while ($i := $i + 1) <= SCALE { }; say($i);',
 },
 {
  name  => 'while_empty_native',
  tags  => [qw( while native )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { ($_[0] + 1) . "\n" },
  perl5 => 'use integer; my $i = 0; while (++$i <= SCALE) { }; say $i;',
  perl6 => 'my int $i = 0; while ($i = $i + 1) <= SCALE { }; say $i;',
  nqp   => 'my int $i := 0; while ($i := $i + 1) <= SCALE { }; say($i);',
 },
 {
  name  => 'while_bind',
  tags  => [qw( while bind )],
  scale => 1 << 10,
  expected => sub { $_[0] ? "1\n" : "0\n" },
  perl5 => 'use Data::Alias; alias my $a = 0; alias my $b = 1; my $i = 0; while (++$i <= SCALE) { alias $a = $b }; say $a;',
  perl6 => 'my $a := 0; my $b := 1; my $i = 0; while (++$i <= SCALE) { $a := $b }; say $a;',
  nqp   => 'my $a := 0; my $b := 1; my $i := 0; while ($i := $i + 1) <= SCALE { $a := $b }; say($a);',
 },
 {
  name  => 'while_concat',
  tags  => [qw( while string )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $s = ""; my $i = 0; while (++$i <= SCALE) { $s .= "x" }; say length($s);',
  perl6 => 'my $s = ""; my $i = 0; while (++$i <= SCALE) { $s ~= "x" }; say $s.chars;',
  nqp   => 'my $s := ""; my $i := 0; while ($i := $i + 1) <= SCALE { $s := $s ~ "x" }; say(nqp::chars($s));',
 },
 {
  name  => 'while_concat_native',
  tags  => [qw( while string native )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'use integer; my $s = ""; my $i = 0; while (++$i <= SCALE) { $s .= "x" }; say length($s);',
  perl6 => 'my str $s = ""; my int $i = 0; while ($i = $i + 1) <= SCALE { $s = $s ~ "x" }; say $s.chars;',
  nqp   => 'my str $s := ""; my int $i := 0; while ($i := $i + 1) <= SCALE { $s := $s ~ "x" }; say(nqp::chars($s));',
 },
 {
  name  => 'while_int2str',
  tags  => [qw( while string int2str )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $i = 0; my $s = "$i"; while (++$i <= SCALE) { $s = "$i" }; say $s;',
  perl6 => 'my $i = 0; my $s = ~$i; while (++$i <= SCALE) { $s = ~$i }; say $s;',
  nqp   => 'my $i := 0; my $s := ~$i; while ($i := $i + 1) <= SCALE { $s := ~$i }; say($s);',
 },
 {
  name  => 'while_int2str_native',
  tags  => [qw( while string int2str native )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'use integer; my $i = 0; my $s = "$i"; while (++$i <= SCALE) { $s = "$i" }; say $s;',
  perl6 => 'my int $i = 0; my str $s = ~$i; while ($i = $i + 1) <= SCALE { $s = ~$i }; say $s;',
  nqp   => 'my int $i := 0; my str $s := ~$i; while ($i := $i + 1) <= SCALE { $s := ~$i }; say($s);',
 },
 {
  name  => 'while_int2str_concat',
  tags  => [qw( while string int2str )],
  scale => 1 << 10,
  perl5 => 'my $s = ""; my $i = 0; while (++$i <= SCALE) { $s .= $i }',
  perl6 => 'my $s = ""; my $i = 0; while (++$i <= SCALE) { $s ~= $i }',
  nqp   => 'my $s := ""; my $i := 0; while ($i := $i + 1) <= SCALE { $s := $s ~ $i }',
 },
 {
  name  => 'while_int2str_concat_native',
  tags  => [qw( while string int2str native )],
  scale => 1 << 10,
  perl5 => 'use integer; my $s = ""; my $i = 0; while (++$i <= SCALE) { $s .= $i }',
  perl6 => 'my str $s = ""; my int $i = 0; while ($i = $i + 1) <= SCALE { $s = $s ~ $i }',
  nqp   => 'my str $s := ""; my int $i := 0; while ($i := $i + 1) <= SCALE { $s := $s ~ $i }',
 },
 {
  name  => 'while_push_join',
  tags  => [qw( while array string )],
  scale => 1 << 7,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a; my $i = 0; while (++$i <= SCALE) { push @a, "x" }; my $s = join "" => @a; say length($s);',
  perl6 => 'my @a; my $i = 0; while (++$i <= SCALE) { @a.push("x") }; my $s = @a.join; say $s.chars;',
  nqp   => 'my @a; my $i := 0; while ($i := $i + 1) <= SCALE { nqp::push(@a, "x"); }; my $s := nqp::join("",@a); say(nqp::chars($s));',
 },
 {
  name  => 'while_push',
  tags  => [qw( while array )],
  scale => 1 << 7,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a; my $i = 0; while (++$i <= SCALE) { push @a, 1 }; say scalar @a;',
  perl6 => 'my @a; my $i = 0; while (++$i <= SCALE) { push @a, 1 }; say +@a;',
  nqp   => 'my @a; my $i := 0; while ($i := $i + 1) <= SCALE { nqp::push(@a, 1) }; say(+@a);',
 },
 {
  name  => 'while_pushme',
  tags  => [qw( while array )],
  scale => 1,
  scaling => 'linear',
  work  => sub { 1 << $_[0] },
  expected => sub { (1 << $_[0]) . "\n" },
  perl5 => 'my @a; push @a, 42; my $i = 0; while (++$i <= SCALE) { push @a, @a }; say scalar @a;',
  perl6 => 'my @a; @a.push(42); my $i = 0; while (++$i <= SCALE) { @a.push(@a) }; say +@a;',
  nqp   => 'my @a; nqp::push(@a,42); my $i := 0; while ($i := $i + 1) <= SCALE { nqp::push(@a, @a) }; say(+@a);',
 },
 {
  name  => 'while_array_set',
  tags  => [qw( while array )],
  scale => 1 << 7,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a; my $i = 0; $a[$i] = $i; while (++$i <= SCALE) { $a[ $i ] = $i }; say $a[-1];',
  perl6 => 'my @a; my $i = 0; @a[$i] = $i; while (++$i <= SCALE) { @a[ $i ] = $i }; say @a[*-1];',
  nqp   => 'my @a; my $i := 0; @a[$i] := $i; while ($i := $i + 1) <= SCALE { @a[ $i ] := $i }; say(@a[@a - 1]);',
 },
 {
  name  => 'while_hash_set',
  tags  => [qw( while hash )],
  scale => 1 << 7,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my %h; my $i = 0; $h{$i} = $i; while (++$i <= SCALE) { $h{ $i } = $i }; say $h{$i - 1};',
  perl6 => 'my %h; my $i = 0; %h{$i} = $i; while (++$i <= SCALE) { %h{ $i } = $i }; say %h{$i - 1};',
  nqp   => 'my %h; my $i := 0; %h{$i} := $i; while ($i := $i + 1) <= SCALE { %h{ $i } := $i }; say(%h{$i - 1});',
 },
 {
  name  => 'postwhile_nil',
  tags  => [qw( while )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { $_[0] ? "0\n" : '' },
  perl5 => 'my $i = -SCALE || exit(0); ()  while ++$i; say $i;',
  perl6 => 'my $i = -SCALE || exit(0); Nil while ++$i; say $i;',
  nqp   => 'my $i := -SCALE || nqp::exit(0); () while $i := $i + 1; say($i);',
 },
 {
  name  => 'postwhile_nil_native',
  tags  => [qw( while native )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { $_[0] ? "0\n" : '' },
  perl5 => 'use integer; my $i = -SCALE || exit(0); () while ++$i; say $i;',
  perl6 => 'my int $i = -SCALE || exit(0); Nil while $i = $i + 1; say $i;',
  nqp   => 'my int $i := -SCALE || nqp::exit(0); () while $i := $i + 1; say($i);',
 },
 {
  name  => 'loop_empty',
  tags  => [qw( loop )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { ($_[0] + 1) . "\n" },
  perl5 => 'for  (my $i = 1; $i <= SCALE; ++$i) { }; say $i;',
  perl6 => 'loop (my $i = 1; $i <= SCALE; ++$i) { }; say $i;',
  nqp   => undef,
 },
 {
  name  => 'loop_empty_native',
  tags  => [qw( loop native )],
  scale => 1 << 10,
  summarize => 0,
  expected => sub { ($_[0] + 1) . "\n" },
  perl5 => 'use integer; for (my $i = 1; $i <= SCALE; ++$i) { }; say $i;',
  perl6 => 'loop (my int $i = 1; $i <= SCALE; $i = $i + 1) { }; say $i;',
  nqp   => undef,
 },
 {
  name  => 'for_empty',
  tags  => [qw( for )],
  scale => 1 << 10,
  summarize => 0,
  perl5 => 'for (1 .. SCALE) { }; 1',
  perl6 => 'for (1 .. SCALE) { }; 1',
  nqp   => undef,
 },
 {
  name  => 'for_bind',
  tags  => [qw( for bind )],
  scale => 1 << 10,
  expected => sub { $_[0] ? "1\n" : "0\n" },
  perl5 => 'use Data::Alias; alias my $a = 0; alias my $b = 1; for (1 .. SCALE) { alias $a = $b; }; say $a;',
  perl6 => 'my $a := 0; my $b := 1; for (1 .. SCALE) { $a := $b; }; say $a;',
  nqp   => undef,
 },
 {
  name  => 'for_assign',
  tags  => [qw( for )],
  scale => 1 << 10,
  expected => sub { $_[0] ? "1\n" : "0\n" },
  perl5 => 'my $a = 0; my $b = 1; for (1 .. SCALE) { $a = $b; }; say $a;',
  perl6 => 'my $a = 0; my $b = 1; for (1 .. SCALE) { $a = $b; }; say $a;',
  nqp   => undef,
 },
 {
  name  => 'for_assign_native',
  tags  => [qw( for native )],
  scale => 1 << 10,
  expected => sub { $_[0] ? "1\n" : "0\n" },
  perl5 => 'use integer; my $a = 0; my $b = 1; for (1 .. SCALE) { $a = $b; }; say $a;',
  perl6 => 'my int $a = 0; my int $b = 1; for (1 .. SCALE) { $a = $b; }; say $a;',
  nqp   => undef,
 },
 {
  name  => 'for_postinc',
  tags  => [qw( for )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $i = 0; for (1 .. SCALE) { $i++ }; say $i;',
  perl6 => 'my $i = 0; for (1 .. SCALE) { $i++ }; say $i;',
  nqp   => undef,
 },
 {
  name  => 'for_postinc_native',
  tags  => [qw( for native )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'use integer; my $i = 0; for (1 .. SCALE) { $i++ }; say $i;',
  perl6 => 'my int $i = 0; for (1 .. SCALE) { $i = $i + 1 }; say $i;',
  nqp   => undef,
 },
 {
  name  => 'for_concat',
  tags  => [qw( for string )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $s = ""; for (1 .. SCALE) { $s .= "x" }; say length($s);',
  perl6 => 'my $s = ""; for (1 .. SCALE) { $s ~= "x" }; say $s.chars;',
  nqp   => undef,
 },
 {
  name  => 'for_concat_native',
  tags  => [qw( for string native )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'use integer; my $s = ""; for (1 .. SCALE) { $s .= "x" }; say length($s);',
  perl6 => 'my str $s = ""; for (1 .. SCALE) { $s = $s ~ "x" }; say $s.chars;',
  nqp   => undef,
 },
 {
  name  => 'for_concat_2',
  tags  => [qw( for string )],
  scale => 1 << 10,
  expected => sub { ($_[0] * 2) . "\n" },
  perl5 => 'my $x = "a"; my $y = ""; for (1 .. SCALE) { $y .= ($x . $x) }; say length($y);',
  perl6 => 'my $x = "a"; my $y = ""; for (1 .. SCALE) { $y ~= ($x ~ $x) }; say $y.chars;',
  nqp   => undef,
 },
 {
  name  => 'for_concat_2_native',
  tags  => [qw( for string native )],
  scale => 1 << 10,
  expected => sub { ($_[0] * 2) . "\n" },
  perl5 => 'use integer; my $x = "a"; my $y = ""; for (1 .. SCALE) { $y .= ($x . $x) }; say length($y);',
  perl6 => 'my str $x = "a"; my str $y = ""; for (1 .. SCALE) { $y = $y ~ $x ~ $x }; say $y.chars;',
  nqp   => undef,
 },
 {
  name  => 'for_push',
  tags  => [qw( for array )],
  scale => 1 << 7,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a; for (1 .. SCALE) { push @a, 1 }; say scalar @a;',
  perl6 => 'my @a; for (1 .. SCALE) { push @a, 1 }; say +@a;',
  nqp   => undef,
 },
 {
  name  => 'for_array_set',
  tags  => [qw( for array )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a; $a[ $_ ] = $_ for 0 .. SCALE; say @a[SCALE];',
  perl6 => 'my @a; @a[ $_ ] = $_ for 0 .. SCALE; say @a[SCALE];',
  nqp   => undef,
 },
 {
  name  => 'for_hash_set',
  tags  => [qw( for hash )],
  scale => 1 << 10,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my %h; $h{ $_ } = $_ for 0 .. SCALE; say %h<SCALE>;',
  perl6 => 'my %h; %h{ $_ } = $_ for 0 .. SCALE; say %h<SCALE>;',
  nqp   => undef,
 },
 {
  name  => 'reduce_range',
  tags  => [qw( reduce )],
  scale => 1 << 10,
  expected => sub { (($_[0] + 1) * $_[0] / 2) . "\n" },
  perl5 => 'use List::Util "reduce"; say reduce { $a + $b } 1 .. SCALE;',
  perl6 => 'say [+] 1 .. SCALE;',
  nqp   => undef,
 },
 {
  name  => 'reduce_int_comb_range',
  tags  => [qw( reduce )],
  scale => 1 << 7,
  perl5 => 'use List::Util "reduce"; say reduce { $a + $b } map { 0+$_ } map { split "" } 1 .. SCALE; ',
  perl6 => 'say [+] (1 .. SCALE).comb>>.Int;',
  nqp   => undef,
 },
 {
  name  => 'any_equals',
  tags  => [qw( junctions forest-fire )],
  scale => 1 << 7,
  expected => sub { $_[0] ? "1 0\n" : "0 0\n" },
  perl5 => 'my $match = grep { 1 == $_ } 1 .. SCALE; my $fail = grep { 0 == $_ } 1 .. SCALE; say "$match $fail"',
  perl6 => 'my $match = 1 == any(1 .. SCALE); my $fail = 0 == any(1 .. SCALE); say "{+?$match} {+?$fail}"',
  nqp   => undef,
 },
 {
  name  => 'trim_string',
  tags  => [qw( for string )],
  scale => 1 << 7,
  work  => sub { $_[0] * $_[0] },
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $s = " " x SCALE . "x" x SCALE . " " x SCALE; my $result = ""; ($result) = $s =~ /^\s*(.*?)\s*$/s for 1 .. SCALE; say length($result);',
  perl6 => 'my $s = " " x SCALE ~ "x" x SCALE ~ " " x SCALE; my $result = ""; $result = $s.trim for 1 .. SCALE; say $result.chars;',
  nqp   => undef,
 },
 {
  name  => 'split_string_constant',
  tags  => [qw( while string )],
  scale => 1 << 7,
  work  => sub { $_[0] * $_[0] },
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $s = join ", " => 1 .. SCALE; my $i; my @s = split ", " => $s while ++$i <= SCALE; say scalar @s;',
  perl6 => 'my $s = (1 .. SCALE).join: ", "; my $i; my @s = $s.split(", ") while ++$i <= SCALE; say +@s;',
  nqp   => 'my @i; my $i := 0; while ($i := $i + 1) <= SCALE { nqp::push(@i, ~$i); }; my $s := nqp::join(", ", @i); $i := 0; my @s; while ($i := $i + 1) <= SCALE { @s := nqp::split(", ", $s) }; say(+@s);',
 },
 {
  name  => 'split_string_regex',
  tags  => [qw( for string regex )],
  scale => 1 << 7,
  work  => sub { $_[0] * $_[0] },
  expected => sub { $_[0] . "\n" },
  perl5 => 'my $s = join ", " => 1 .. SCALE; my @s = split /\s*,\s*/ => $s for 1 .. SCALE; say scalar @s;',
  perl6 => 'my $s = (1 .. SCALE).join: ", "; my @s = $s.split(/\s*\,\s*/) for 1 .. SCALE; say +@s;',
  nqp   => undef,
 },
 {
  name  => 'charrange',
  tags  => [qw( while string regex cclass )],
  scale => 1 << 7,
  perl5 => 'my $y = chr(SCALE); my $n = chr(SCALE + 1); my $c = sprintf("%x",SCALE); my $reg="[\\x00-\\x{$c}]"; my $i = 0; while (++$i <= SCALE) { $y ~~ /$reg/; $n ~~ /$reg/; }',
  perl6 => 'my $y = chr(SCALE); my $n = chr(SCALE + 1); my $i = 0; while (++$i <= SCALE) {$y ~~ /<[\c0..\c[SCALE]]>/; $n ~~ /<[\c0..\c[SCALE]]>/ }',
  nqp   => 'my $y := nqp::chr(SCALE); my $n := nqp::chr(SCALE + 1); my $i := 0; while ($i := $i + 1) <= SCALE { $y ~~ /<[\c0..\c[SCALE]]>/; $n ~~ /<[\c0..\c[SCALE]]>/ }',
 },
 {
  name  => 'charrange_ignorecase',
  tags  => [qw( while string regex cclass )],
  scale => 1 << 7,
  perl5 => 'my $y = chr(SCALE); my $n = chr(SCALE + 1); my $c = sprintf("%x",SCALE); my $reg="[\\x00-\\x{$c}]"; my $i = 0; while (++$i <= SCALE) { $y ~~ /$reg/i; $n ~~ /$reg/i; }',
  perl6 => 'my $y = chr(SCALE); my $n = chr(SCALE + 1); my $i = 0; while (++$i <= SCALE) {$y ~~ /:i<[\c0..\c[SCALE]]>/; $n ~~ /:i<[\c0..\c[SCALE]]>/ }',
  nqp   => 'my $y := nqp::chr(SCALE); my $n := nqp::chr(SCALE + 1); my $i := 0; while ($i := $i + 1) <= SCALE { $y ~~ /:i<[\c0..\c[SCALE]]>/; $n ~~ /:i<[\c0..\c[SCALE]]>/ }',
 },
 {
  name  => 'visit_2d_indices_while',
  tags  => [qw( while )],
  scale => 1 << 3,
  work  => sub { $_[0] * $_[0] },
  expected => sub { ($_[0] + $_[0]) . "\n" },
  perl5 => 'my $k = 0; my $i = 1; while ($i <= SCALE) { my $j = 1; while ($j <= SCALE) { $k = $i + $j; ++$j }; ++$i }; say $k',
  perl6 => 'my $k = 0; my $i = 1; while ($i <= SCALE) { my $j = 1; while ($j <= SCALE) { $k = $i + $j; ++$j }; ++$i }; say $k',
  nqp   => 'my $k := 0; my $i := 1; while ($i <= SCALE) { my $j := 1; while ($j <= SCALE) { $k := $i + $j; $j := $j + 1 }; $i := $i + 1 }; say($k)',
 },
 {
  name  => 'visit_2d_indices_while_native',
  tags  => [qw( while native )],
  scale => 1 << 3,
  work  => sub { $_[0] * $_[0] },
  expected => sub { ($_[0] + $_[0]) . "\n" },
  perl5 => 'use integer; my $k = 0; my $i = 1; while ($i <= SCALE) { my $j = 1; while ($j <= SCALE) { $k = $i + $j; ++$j }; ++$i }; say $k',
  perl6 => 'my int $k = 0; my int $i = 1; while ($i <= SCALE) { my int $j = 1; while ($j <= SCALE) { $k = $i + $j; $j = $j + 1 }; $i = $i + 1 }; say $k',
  nqp   => 'my int $k := 0; my int $i := 1; while ($i <= SCALE) { my int $j := 1; while ($j <= SCALE) { $k += $i + $j; $j := $j + 1 }; $i := $i + 1 }; say($k)',
 },
 {
  name  => 'visit_2d_indices_loop',
  tags  => [qw( loop )],
  scale => 1 << 3,
  work  => sub { $_[0] * $_[0] },
  expected => sub { ($_[0] + $_[0]) . "\n" },
  perl5 => 'my $k = 0; for  (my $i = 1; $i <= SCALE; ++$i) { for  (my $j = 1; $j <= SCALE; ++$j) { $k = $i + $j } }; say $k;',
  perl6 => 'my $k = 0; loop (my $i = 1; $i <= SCALE; ++$i) { loop (my $j = 1; $j <= SCALE; ++$j) { $k = $i + $j } }; say $k;',
  nqp   => undef,
 },
 {
  name  => 'visit_2d_indices_loop_native',
  tags  => [qw( loop native )],
  scale => 1 << 3,
  work  => sub { $_[0] * $_[0] },
  expected => sub { ($_[0] + $_[0]) . "\n" },
  perl5 => 'use integer; my $k = 0; for (my $i = 1; $i <= SCALE; ++$i) { for (my $j = 1; $j <= SCALE; ++$j) { $k = $i + $j } }; say $k;',
  perl6 => 'my int $k = 0; loop (my int $i = 1; $i <= SCALE; $i = $i + 1) { loop (my int $j = 1; $j <= SCALE; $j = $j + 1) { $k = $i + $j } }; say $k;',
  nqp   => undef,
 },
 {
  name  => 'visit_2d_indices_for',
  tags  => [qw( for )],
  scale => 1 << 3,
  work  => sub { $_[0] * $_[0] },
  expected => sub { ($_[0] + $_[0]) . "\n" },
  perl5 => 'my $k = 0; for my $i (1 .. SCALE) { for my $j (1 .. SCALE) { $k = $i + $j }; 1 }; say $k;',
  perl6 => 'my $k = 0; for 1 .. SCALE -> $i { for 1 .. SCALE -> $j { $k = $i + $j }; 1 }; say $k;',
  nqp   => undef,
 },
 {
  name  => 'visit_2d_indices_cross',
  tags  => [qw( for cross )],
  scale => 1 << 7,
  work  => sub { $_[0] * $_[0] },
  perl5 => 'sub mk2d { my ($h, $w) = @_; my $x = 0; my $y = 0; sub { return if $y >= $h; my @c = ($y, $x); if (++$x >= $w) { $x = 0; ++$y; }; @c } }; my $it = mk2d(SCALE, SCALE); while (my ($i, $j) = $it->()) { $i + $j }; 1',
  perl6 => 'for ^SCALE X ^SCALE -> $i, $j { $i + $j }; 1',
  nqp   => 'sub mk2d($h, $w) { my $x := 0; my $y := 0; sub () { return () if $y >= $h; my @c := ($y, $x); if ++$x >= $w { $x := 0; ++$y; }; @c } }; my $it := mk2d(SCALE, SCALE); while $it() -> @c { @c[0] + @c[1] }; 1',
 },
 {
  name  => 'create_and_copy_2d_grid_cross',
  tags  => [qw( for cross array forest-fire )],
  scale => 1 << 7,
  work  => sub { $_[0] * $_[0] },
  perl5 => 'sub mk2d { my ($h, $w) = @_; my $x = 0; my $y = 0; sub { return if $y >= $h; my @c = ($y, $x); if (++$x >= $w) { $x = 0; ++$y; }; @c } }; my (@src, @dst); my $it = mk2d(SCALE, SCALE); while (my ($i, $j) = $it->()) { $src[$i][$j] = $i + $j }; $it = mk2d(SCALE, SCALE); while (my ($i, $j) = $it->()) { $dst[$i][$j] = $src[$i][$j] }; 1',
  perl6 => 'my (@src, @dst); for ^SCALE X ^SCALE -> $i, $j { @src[$i][$j] = $i + $j }; for ^SCALE X ^SCALE -> $i, $j { @dst[$i][$j] = @src[$i][$j] }; 1',
  nqp   => 'sub mk2d($h, $w) { my $x := 0; my $y := 0; sub () { return () if $y >= $h; my @c := ($y, $x); if ++$x >= $w { $x := 0; ++$y; }; @c } }; my @src; my @dst; my $it := mk2d(SCALE, SCALE); while $it() -> @c { @src[@c[0]] := [] unless @src[@c[0]]; @src[@c[0]][@c[1]] := @c[0] + @c[1] }; $it := mk2d(SCALE, SCALE); while $it() -> @c { @dst[@c[0]] := [] unless @dst[@c[0]]; @dst[@c[0]][@c[1]] := @src[@c[0]][@c[1]] }; 1',
 },
 {
  name => 'create_and_iterate_hash_kv',
  tags  => [qw( for while hash hash_kv )],
  scale => 1 << 3,
  perl5 => 'my %h; for (0 .. (SCALE - 1)) { %h{$_} = $_ }; while (my ($k, $v) = each %h) { $k == $v }; 1',
  perl6 => 'my %h; for ^SCALE { %h{$_} = $_ }; for %h.kv -> $k, $v { $k == $v }; 1',
  nqp   => undef,
 },
 {
  name  => 'rat_mul_div_cancel',
  tags  => [qw( for rat )],
  scale => 1 << 10,
  expected => sub { "1/" . ($_[0] + 1) . "\n" },
  perl5 => 'use Math::BigRat; my $r = Math::BigRat->new(1); for (1 .. SCALE) { $r *= $_; $r /= $_ + 1 }; say $r.numerator . "/" . $r.denominator;',
  perl6 => 'my $r = 1.0; for 1 .. SCALE { $r *= $_; $r /= $_ + 1 }; say $r.numerator ~ "/" ~ $r.denominator;',
  nqp   => undef,
 },
 {
  name  => 'rat_harmonic',
  tags  => [qw( for rat fatrat )],
  scale => 1 << 7,
  perl5 => 'use Math::BigRat; my $r = Math::BigRat->new(0); for (1 .. SCALE) { $r += Math::BigRat->new(Math::BigInt->new(1), Math::BigInt->new($_)) }; say $r',
  perl6 => 'my $r = FatRat.new(0, 1); for 1 .. SCALE { $r += 1 / $_ }; say $r.perl',
  nqp   => undef,
 },
 {
  name  => 'rand',
  tags  => [qw( for random forest-fire )],
  scale => 1 << 20,
  perl5 => 'my $total = 0; for (1 .. SCALE) { $total += rand }; say $total',
  perl6 => 'my $total = 0; for ^SCALE { $total += rand }; say $total',
  nqp   => 'my $total := 0; my $i := 0; while $i++ < SCALE { $total := $total + nqp::rand_n(1) }; say($total)',
 },
 {
  name  => 'array_set_xx',
  tags  => [qw( array xx forest-fire )],
  scale => 1 << 17,
  expected => sub { $_[0] . "\n" },
  perl5 => 'my @a = (0) x SCALE; say scalar @a',
  perl6 => 'my @a = 0 xx SCALE; say +@a',
  nqp   => undef,
 },
 {
  name => 'deep_scan_for_interpolated_string_var',
  tags  => [qw( for regex scan interpolated variable )],
  scale => 1 << 4,
  perl5 => '$_ = ("0" x 100) . "foo bar baz"; my $s = "foo bar baz"; for (my $i = 0; $i < SCALE; $i++) { /\Q$s\E/ }',
  perl6 => '$_ = "0" x 100 ~ "foo bar baz"; my $s = "foo bar baz"; loop (my $i = 0; $i < SCALE; $i++) { /$s/ }',
  nqp   => undef,
 },
]
