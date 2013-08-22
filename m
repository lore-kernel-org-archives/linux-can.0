From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Thu, 22 Aug 2013 09:56:13 +0200
Message-ID: <20130822075613.GA1831@vandijck-laurijssen.be>
References: <9522AFA707AD744DA5CF5DF53E30277430EEDB1B86@WEICSUS1.weics.local>
 <52151DCA.3000606@pengutronix.de>
 <521520CA.5080700@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:17560 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753843Ab3HVH4R (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Aug 2013 03:56:17 -0400
Content-Disposition: inline
In-Reply-To: <521520CA.5080700@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Brent Sink <Brent.Sink@we-ics.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

I have a git repository on git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git

I added a complete j1939 stack, including 'BAM'.

You will need the associated can-utils with j1939 support
to activate the j1939 processing for a specific CAN device:
$ ip link set can0 j1939 on

If you only need to receive j1939 packets, then that's all you need to do.

The associated can-utils provide some example programs. You will
need to take a look as the API for j1939 sockets is different than
for raw CAN.

Kind regards,
Kurt

On Wed, Aug 21, 2013 at 10:19:22PM +0200, Marc Kleine-Budde wrote:
> On 08/21/2013 08:43 PM, Brent Sink wrote:
> > How do I read J1939 messages that use the BAM format?  Some of the
> > diagnostic messages that are on the DM01 message have a DLC that is
> > often larger than 8 bytes when the message contains more than one
> > error.  Is there something special that I need to do to enable reading
> > these messages?  Thanks!
> 
> With mainline linux you just receive raw CAN frames. I'm not a j1939
> expert, as far as I can see, BAM is a transport protocol for CAN.
> 
> There are two options:
> 1) You have to implement the BAM protocol yourself either,
>    a) inside the kernel or
>    b) inside userspace.
> 2) Talk to Kurt (Cc'ed) if his j1939 patches support BAM.
> 
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
