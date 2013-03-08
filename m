From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 8 Mar 2013 11:05:48 +0100
Message-ID: <20130308100548.GA496@vandijck-laurijssen.be>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
 <20130307124012.GC603@vandijck-laurijssen.be>
 <5139A78D.9060005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:65067 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752684Ab3CHKF4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 05:05:56 -0500
Content-Disposition: inline
In-Reply-To: <5139A78D.9060005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Mar 08, 2013 at 09:55:41AM +0100, Marc Kleine-Budde wrote:
> Hello Kurt,
> 
> On 03/07/2013 01:40 PM, Kurt Van Dijck wrote:
> > On Wed, Mar 06, 2013 at 04:42:04PM +0100, Marc Kleine-Budde wrote:
> >> On 03/06/2013 03:51 PM, Sako Youssouf wrote:
> >>> I'm an engineer of a French company, Renault Trucks Defense. We are 
> >>> Militaries cars makers. We are currently testing the CAN API of 
> >>> Linux. I found your article "SocketCAN - The official CAN API of the 
> >>> Linux kernel" on internet and after reading it I have some 
> >>> questions.
> >>
> >>
> > [...]
> >>> And a last question, do you have information about when the Linux
> >>> API for SAE J1939 will be available?
> >>
> >> Kurt (Cc'ed) can probably comment on this.
> > 
> > The J1939 API that is available on gitorious[1] is waiting for acceptance.
> > The API has not changed for almost a year now, and is working.
> > The J1939 API is quite different from raw CAN, since J1939 adds an
> > addressing scheme. This makes it hard for non-J1939 users to
> > judge about the usefullness of the API.
> > Therefore, it's important that users of the J1939 stack share their
> > opinion about it.
> > Therefore, also your opinion matters and may contribute to the acceptance.
> > If you find the J1939 stack usefull of course :-)
> 
> Would it be possible to add the j1939 support to staging? I mean from
> the technical and from the political (is staging reserved for drivers
> only?) point of view.

That is a good idea.
Technically, staging is underneath drivers/, which answers the political
question: yes, it's for drivers probably.

Could I just mark j1939 as "EXPERIMENTAL" in Kconfig.
I think that is what I've seen most for 'unstable concepts'.
AFAIK this means that you should take care yourself of API changes.
This is probably fine for the current (few) users of the stack,
and warns new users enough?

Oliver, do you feel allright with such approach?

Kind regards,
Kurt

> 
> regards,
> Marc
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
