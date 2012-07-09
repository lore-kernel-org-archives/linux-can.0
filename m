From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 15:19:04 +0200
Message-ID: <201207091519.04235.pisa@cmp.felk.cvut.cz>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FFAC346.7060201@grandegger.com> <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:21583 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab2GINx3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 09:53:29 -0400
In-Reply-To: <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>

Hello Mohamed,

On Monday 09 July 2012 13:57:11 Mohamed HAMZAOUI wrote:
> If i have understood you correctly, I think it must change the period
> if the write function is a synchronous call !
> if my function is like this :
>
> while(1)
> {
>     nannosleep(1000000);
>     write (myFrame in opened CAN socket);
> }

You should use some loop which compensates for time spent
in the loop workload. One solution is to use costruct
bellow

#include <time.h>

const struct timespec period = {/*seconds*/, /*nanoseconds*/};
struct timespec time_to_wait;
clock_gettime(CLOCK_MONOTONIC,&time_to_wait);

while(!Finished)
{
  do_work();
  
  timespec_add(&time_to_wait,&time_to_wait,&period);
  clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &time_to_wait,NULL);
}

and link with librt (i.e. -lrt). You can take timespec_add()
and timespec_sub() sources from our Computers for Control course page

http://support.dce.felk.cvut.cz/pos/hlavni_uloha/timespec_routines.h

The solution can result in infinite/busy loop if the work activity
is longer than period. There should be some check for that situation
and skip of some sampling intervals or error reporting and switching
to emergency/safe stop mode.

Best wishes,

                Pavel

