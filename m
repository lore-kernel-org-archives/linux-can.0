From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: tx/rx LED trigger support
Date: Fri, 14 Dec 2012 13:16:49 +0100
Message-ID: <20121214121649.GA13906@vandijck-laurijssen.be>
References: <50CB1618.3040805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:29934 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753580Ab2LNMQ5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 07:16:57 -0500
Content-Disposition: inline
In-Reply-To: <50CB1618.3040805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


I still have pending comments on my last sent patches.
I must find time to rework some things.

There was a patch to determine if _a_ netdevice is
actually a can_dev based device (i.e. not slcan or vcan),
so one can use can_priv.
That patch is operational and may be usefull for other users
as well.

Kurt

On Fri, Dec 14, 2012 at 01:05:44PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> what's the status of the LED trigger support? Are there any patches that
> I can merge?
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


