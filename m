From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [Socketcan-users] back to back can frames.
Date: Thu, 5 Jul 2012 15:57:26 +0200
Message-ID: <20120705135726.GB417@vandijck-laurijssen.be>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
 <1341488146.2416.9.camel@slaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:38443 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932530Ab2GEN5x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 09:57:53 -0400
Content-Disposition: inline
In-Reply-To: <1341488146.2416.9.camel@slaptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <king@greatfreeworld.org>
Cc: linux-can@vger.kernel.org

Max,

(please switch using linux-can@vger.kernel.org, as Oliver suggested)

to answer your question, see below

On Thu, Jul 05, 2012 at 11:35:46AM +0000, Max S. wrote:
> Hello,
> 
> While trying to test a can device I wrote a short program to
> continuously send can frames... However after a short while I get a
> buffer overflow error. Seems the internal queue is filled and overrun...
> 
> How can I send can frames at maximum throughput? simply one after the
> other, back to back.
> 
> what i have now is something like this:
> 
> 
> do{
> 	//prepare next frame...
> }while(write( sfd, frame, sizeof(*arguments.frame) ) == sizeof(*frame));
> //print error message...

> 
> since the write simply pushes the frame into the queue, it is logical
> that the queue would fill up quickly and get overflown?overrun?full.

my core loop would look like this:

	int ret;
	while (1) {
		ret = write(sfd, frame, sizeof(*frame));
		if ((ret < 0) && (errno == ENOBUFS)) {
			usleep(1000);
		} else
			break;
	}
	if (ret < 0)
		/* print error message */

> 
> Thanks,
> Max S.
> 
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
