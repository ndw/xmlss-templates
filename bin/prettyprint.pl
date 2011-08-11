#!/usr/bin/perl -w

use strict;
use Getopt::Std;
use vars qw($opt_r);

my $usage = "Usage: $0 [-r role] file.xml";

die $usage if ! getopts('r:');

my $file = shift @ARGV || die "$usage\n";

my $role = $opt_r ? " role='$opt_r'" : "";

open (F, $file);
read (F, $_, -s $file);
close (F);

# Trim the last newline off the source
$_ =~ s/\n$//i;

print "<programlisting$role xmlns='http://docbook.org/ns/docbook'>";

if (/<!DOCTYPE/) {
    &prettyprint($`); # `
    $_ = $& . $'; # '

    if (/<!DOCTYPE\s*\S+\s*\[.*?\]>/s) {
	print &charescape($&);
	&prettyprint($'); # '
    } elsif (/<!DOCTYPE.*>/) {
	print &charescape($&);
	&prettyprint($'); # '
    } else {
	die "Unparseable !DOCTYPE declaration.\n";
    }
} else {
    &prettyprint($_);
}

print "</programlisting>\n";

sub prettyprint {
    local $_ = shift;

    while (/<(.*?)>/s) {
	my $post = $'; # '
	$_ = $1;

	print &escape($`);

	if (/^\?(.*)\?$/s) {
	    print &pi($1);
	} elsif (/^\!--(.*)--$/s) {
	    print &comment($1);
	} elsif (/^\/(.*)$/s) {
	    print &endtag($1);
	} else {
	    print &starttag($_);
	}

	$_ = $post;
    }

    print &escape($_);
}

sub escape {
    local $_ = shift;
    my $ret = "";

    while (/&(\S+?);/) {
	my $pre = $`;
	my $ent = $1;
	my $post = $'; # '

	$ret .= &charescape($pre);
	if ($ent =~ /^\#/) {
	    $ret .= &sgmltag('numcharref', $ent);
	} else {
	    $ret .= &sgmltag('genentity', $ent);
	}

	$_ = $post;
    }

    return $ret . &charescape($_);
}

sub charescape {
    local $_ = shift;

    s/&/&amp;/sg;
    s/</&lt;/sg;
    s/>/&gt;/sg;

    return $_;
}

sub sgmltag {
    my $class = shift;
    my $content = shift;

#    my $tagname = "???";
#    $tagname = $1 if $content =~ s/^(\S+)/$1/s;
#    $tagname =~ s/:/-/sg;

    return "<tag class=\"$class\">$content</tag>"
}

sub pi {
    return &sgmltag('xmlpi', $_[0]);
}

sub comment {
    return &sgmltag('sgmlcomment', $_[0]);
}

sub starttag {
    my $content = shift;
    my $class = "starttag";
    local $_ = "";

    if ($content =~ /\/$/) {
        $content = $`;
        $class = "emptytag";
    }

    if ($content =~ /(\S+\s+)(\S.*)/s) {
        $content = $1 . &attr($2);
    }

    $_ .= &sgmltag($class, $content);
    return $_;
}

sub endtag {
    my $content = shift;
    local $_ = &sgmltag('endtag', $content);

    return $_;
}

sub attr {
    my $content = shift;
    local $_ = "";

    while ($content =~ /^(\S+)(\s*=\s*)([\'\"])(.*?)\3(\s*)(.*?)$/s) {
        $_ .= "<tag class='attribute'>$1</tag>$2<tag class='attvalue'>$3$4$3</tag>$5";
        $content = $6;
    }

    return $_ . $content;
}
