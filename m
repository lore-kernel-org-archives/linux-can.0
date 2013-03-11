From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Mon, 11 Mar 2013 16:34:37 +0100
Message-ID: <20130311153437.GD5114@vandijck-laurijssen.be>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
 <20130307124012.GC603@vandijck-laurijssen.be>
 <5139A78D.9060005@pengutronix.de>
 <20130308100548.GA496@vandijck-laurijssen.be>
 <20130308125123.GA28383@pengutronix.de>
 <20130311092923.GA5114@vandijck-laurijssen.be>
 <513DF3D4.6090605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:2420 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab3CKPen (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 11:34:43 -0400
Content-Disposition: inline
In-Reply-To: <513DF3D4.6090605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, Mar 11, 2013 at 04:10:12PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2013 10:29 AM, Kurt Van Dijck wrote:
> > 
> > 
> > On Fri, Mar 08, 2013 at 01:51:23PM +0100, Robert Schwebel wrote:
> >> Hi Kurt,
> >>
> >> On Fri, Mar 08, 2013 at 11:05:48AM +0100, Kurt Van Dijck wrote:
> >>> Could I just mark j1939 as "EXPERIMENTAL" in Kconfig.
> >>> I think that is what I've seen most for 'unstable concepts'.
> >>
> >> EXPERIMENTAL is considered to be deprecated and might be removed from
> >> the kernel, so I wouldn't go down that road. Staging sounds right.
> > 
> > I see.
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/CodingStyle?id=v3.9-rc2#n549
> > 
> > Is such thing then appropriate?
> 
> Does j1939 have a protocol number? Probably.
Yes. 7.

> If so, we shouldn't use the
> "next free" one for an experimental protocol.
That's another reason to have J1939 merged.
I would have alerted anyhow when the protocol number 7 got allocated...

Kurt
> 
> Marc
> 
> > 
> > --
> > diff --git a/net/can/j1939/Kconfig b/net/can/j1939/Kconfig
> > index 74d2a86..0db6545 100644
> > --- a/net/can/j1939/Kconfig
> > +++ b/net/can/j1939/Kconfig
> > @@ -3,7 +3,7 @@
> >  #
> >  
> >  config CAN_J1939
> > -	tristate "SAE J1939"
> > +	tristate "SAE J1939 (unstable API)"
> >  	depends on CAN
> >  	---help---
> >  	  SAE J1939
> > @@ -12,6 +12,7 @@ config CAN_J1939
> >  	  The relevant parts in kernel are
> >  	  SAE j1939-21 (datalink & transport protocol)
> >  	  & SAE j1939-81 (network management).
> > +	  Big fat warning: The API is yet unstable!
> >  
> >  config CAN_J1939_DEBUG
> >  	bool "debug SAE J1939"
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
