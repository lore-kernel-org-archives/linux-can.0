From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: j1939 - first steps
Date: Thu, 21 Mar 2013 06:53:13 +0100
Message-ID: <20130321055313.GA1419@vandijck-laurijssen.be>
References: <5147756D.1060203@hartkopp.net>
 <20130318214145.GA8685@vandijck-laurijssen.be>
 <51480B13.8030102@hartkopp.net>
 <20130320192415.GA4636@vandijck-laurijssen.be>
 <514A1FA2.3050501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:21405 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515Ab3CUFxT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Mar 2013 01:53:19 -0400
Content-Disposition: inline
In-Reply-To: <514A1FA2.3050501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Mar 20, 2013 at 09:44:18PM +0100, Marc Kleine-Budde wrote:
> On 03/20/2013 08:24 PM, Kurt Van Dijck wrote:
> > On Tue, Mar 19, 2013 at 07:52:03AM +0100, Oliver Hartkopp wrote:
> >> On 18.03.2013 22:41, Kurt Van Dijck wrote:
> >>
> >>> On Mon, Mar 18, 2013 at 09:13:33PM +0100, Oliver Hartkopp wrote:
> >>
> >>
> >>>> And this (as user):
> >>>>
> >>>> ./jsr -v vcan0:0x22
> >>> you should use 'vcan0:,0x22'.
> >>>
> >>
> >>
> >> ./jsr -?
> >> jsr: An SAE J1939 send/recv utility
> >> Usage: jsr [OPTION...] SOURCE [DEST]
> >>
> >>   -v, --verbose		Increase verbosity
> >>   -p, --priority=VAL	J1939 priority (0..7, default 6)
> >>   -S, --serialize	Strictly serialize outgoing packets
> >>   -s, --size		Packet size, default autodetected
> >>
> >>   SOURCE	[IFACE:][NAME|SA][,PGN]
> >>   DEST			[NAME|SA]
> >>
> >> Tells me something else ;-)
> > 
> > Oliver, how about this change in the docs.
> > Would that have avoided this confusion (on both sides).
> > 
> > diff --git a/jacd.c b/jacd.c
> > index 1358918..088b72c 100644
> > --- a/jacd.c
> > +++ b/jacd.c
> > @@ -39,7 +39,8 @@ static const char help_msg[] =
> >  	"NAME is the 64bit nodename" "\n"
> >  	"\n"
> >  	"Example:" "\n"
> > -	"jacd -r 100,80-120 -c /tmp/1122334455667788.jacd 1122334455667788" "\n"
> > +	"	$ jacd -r 100,80-120 -c /tmp/0123456789abcdef.jacd"
> > +			" 0123456789abcdef" "\n"
> >  	;
> >  
> >  #ifdef _GNU_SOURCE
> > diff --git a/jspy.c b/jspy.c
> > index b48fea1..6b7a215 100644
> > --- a/jspy.c
> > +++ b/jspy.c
> > @@ -37,6 +37,10 @@ static const char help_msg[] =
> >  	"			(= receive traffic not for this ECU)" "\n"
> >  	"  -b, --block=SIZE	Use a receive buffer of SIZE (default 1024)" "\n"
> >  	"  -t, --time[=a|d|z|A]	Show time: (a)bsolute, (d)elta, (z)ero, (A)bsolute w date" "\n"
> > +	"\n"
> > +	"	NAME, SA & PGN are in hex, without 0x prefix.\n"
> 
> What do you use to parse these numbers?
strtoul(str, &endp, 16);
		   ^^^^

The use is very similar to cansend, I believe, where a can_id of exactly 8 hex chars long
means 29bit, and shorter means 11bit.
Implicitely, everything is told to be in hex, without 0x.

And because this was not clear, Oliver got himself a 64bit nodename as strlen(0x22) > 2 :-)
> >>> The format is: 'IFACE:<NAME>[,<ADDR>]'
And my first attempt to help him, out of the head, was a 'legacy thought', not good either.
always check the code :-)

Kurt
