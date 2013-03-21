From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939 - first steps
Date: Thu, 21 Mar 2013 07:50:42 +0100
Message-ID: <514AADC2.3030504@hartkopp.net>
References: <5147756D.1060203@hartkopp.net> <20130318214145.GA8685@vandijck-laurijssen.be> <51480B13.8030102@hartkopp.net> <20130320192415.GA4636@vandijck-laurijssen.be> <514A1FA2.3050501@pengutronix.de> <20130321055313.GA1419@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:15559 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3CUGuo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Mar 2013 02:50:44 -0400
In-Reply-To: <20130321055313.GA1419@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 21.03.2013 06:53, Kurt Van Dijck wrote:

> On Wed, Mar 20, 2013 at 09:44:18PM +0100, Marc Kleine-Budde wrote:

>> What do you use to parse these numbers?
> strtoul(str, &endp, 16);
> 		   ^^^^
> 
> The use is very similar to cansend, I believe, where a can_id of exactly 8 hex chars long
> means 29bit, and shorter means 11bit.
> Implicitely, everything is told to be in hex, without 0x.
> 
> And because this was not clear, Oliver got himself a 64bit nodename as strlen(0x22) > 2 :-)


Yes that was my trap. I've seen the strlen but it didn't help me %-)

>>>>> The format is: 'IFACE:<NAME>[,<ADDR>]'
> And my first attempt to help him, out of the head, was a 'legacy thought', not good either.
> always check the code :-)


Regards,
Oliver
