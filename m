From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Thu, 7 Mar 2013 13:40:12 +0100
Message-ID: <20130307124012.GC603@vandijck-laurijssen.be>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:23285 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751787Ab3CGMkR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Mar 2013 07:40:17 -0500
Content-Disposition: inline
In-Reply-To: <513763CC.1070507@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, Mar 06, 2013 at 04:42:04PM +0100, Marc Kleine-Budde wrote:
> On 03/06/2013 03:51 PM, Sako Youssouf wrote:
> > I'm an engineer of a French company, Renault Trucks Defense. We are 
> > Militaries cars makers. We are currently testing the CAN API of 
> > Linux. I found your article "SocketCAN - The official CAN API of the 
> > Linux kernel" on internet and after reading it I have some 
> > questions.
> 
> 
[...]
> > And a last question, do you have information about when the Linux
> > API for SAE J1939 will be available?
> 
> Kurt (Cc'ed) can probably comment on this.

The J1939 API that is available on gitorious[1] is waiting for acceptance.
The API has not changed for almost a year now, and is working.
The J1939 API is quite different from raw CAN, since J1939 adds an
addressing scheme. This makes it hard for non-J1939 users to
judge about the usefullness of the API.
Therefore, it's important that users of the J1939 stack share their
opinion about it.
Therefore, also your opinion matters and may contribute to the acceptance.
If you find the J1939 stack usefull of course :-)

Kind regards,
Kurt

[1]:  http://gitorious.org/~kurt-vd/linux-can/linux-can-j1939

> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 
> 



-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
