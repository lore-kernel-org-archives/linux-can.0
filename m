From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 16:57:55 +0200
Message-ID: <23562188.349Ls0e8RT@ws-stein>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <201207091519.04235.pisa@cmp.felk.cvut.cz> <20120709144042.GA2671@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33429 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754482Ab2GIPGU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 11:06:20 -0400
In-Reply-To: <20120709144042.GA2671@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Mohamed HAMZAOUI <requinham@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

Am Montag, 9. Juli 2012, 16:40:42 schrieb Kurt Van Dijck:
> I tend to use itimer:
> 	#include <sys/time.h>
> 
> 	int sigalrm;
> 
> 	void hndalrm(int sig)
> 	{
> 		sigalrm = 1;
> 		signal(SIGALRM, hndalrm);
> 	}
> 
> 	const struct itimerval itimer = {
> 		.it_interval = { /* seconds*/, /*useconds*/, },
> 		.it_value = { 0, 1, }, /* schedule first run quasi immediately */
> 	};
> 
> 	main ()
> 	{
> 		signal(SIGALRM, hndalrm);
> 
> 		setitimer(ITIMER_REAL, &itimer, NULL);
> 
> 		while (1) {
> 			poll(NULL, 0, -1); /* wait indefinite until signal */
> 			write(...).
> 		}
> 	}
>
> I just realised that this algorithm does not need measuring time spent,
> it will automatically skip cycles, at the cost of having to deal with
> signal's.
> I don't know if it is based on hrtimer in kernel too, I assume yes.

I compared itimer with clock_nanosleep on an ARM board and noticed the signal 
overhead of itimer is much bigger, resulting in a higher CPU usage, than 
clock_nanosleep upon hrtimer.
So I ended up using clock_nanosleep adding a constant to the last timeout.
itimer should also be based on hrtimer.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
