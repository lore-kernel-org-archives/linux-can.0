From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 16:40:42 +0200
Message-ID: <20120709144042.GA2671@vandijck-laurijssen.be>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
 <4FFAC346.7060201@grandegger.com>
 <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
 <201207091519.04235.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:6576 "EHLO mail.eia.be"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754038Ab2GIOlH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jul 2012 10:41:07 -0400
Content-Disposition: inline
In-Reply-To: <201207091519.04235.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Mohamed HAMZAOUI <requinham@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

On Mon, Jul 09, 2012 at 03:19:04PM +0200, Pavel Pisa wrote:
> Hello Mohamed,
> 
> On Monday 09 July 2012 13:57:11 Mohamed HAMZAOUI wrote:
> > If i have understood you correctly, I think it must change the period
> > if the write function is a synchronous call !
> > if my function is like this :
> >
> > while(1)
> > {
> >     nannosleep(1000000);
> >     write (myFrame in opened CAN socket);
> > }
> 
> You should use some loop which compensates for time spent
> in the loop workload. One solution is to use costruct
> bellow
> 
> #include <time.h>
> 
> const struct timespec period = {/*seconds*/, /*nanoseconds*/};
> struct timespec time_to_wait;
> clock_gettime(CLOCK_MONOTONIC,&time_to_wait);
> 
> while(!Finished)
> {
>   do_work();
>   
>   timespec_add(&time_to_wait,&time_to_wait,&period);
>   clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &time_to_wait,NULL);
> }
> 

I tend to use itimer:
	#include <sys/time.h>

	int sigalrm;

	void hndalrm(int sig)
	{
		sigalrm = 1;
		signal(SIGALRM, hndalrm);
	}

	const struct itimerval itimer = {
		.it_interval = { /* seconds*/, /*useconds*/, },
		.it_value = { 0, 1, }, /* schedule first run quasi immediately */
	};

	main ()
	{
		signal(SIGALRM, hndalrm);

		setitimer(ITIMER_REAL, &itimer, NULL);

		while (1) {
			poll(NULL, 0, -1); /* wait indefinite until signal */
			write(...).
		}
	}

I just realised that this algorithm does not need measuring time spent,
it will automatically skip cycles, at the cost of having to deal with signal's.
I don't know if it is based on hrtimer in kernel too, I assume yes.


-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
