From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 16:29:13 +0200
Message-ID: <CABMxt4jtO5Sjc7RyMs85VwCWzMDH8t1Nh5Ef+tKwXv8vWWKkeQ@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<4FFAC346.7060201@grandegger.com>
	<CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
	<201207091519.04235.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:38106 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2GIO3N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 10:29:13 -0400
Received: by ghrr11 with SMTP id r11so10117535ghr.19
        for <linux-can@vger.kernel.org>; Mon, 09 Jul 2012 07:29:13 -0700 (PDT)
In-Reply-To: <201207091519.04235.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

My loop code is there :

 /*change the scheduler politic for this process */
    err = sched_setscheduler(0, SCHED_FIFO, &p);
    if (err)
          fprintf(stderr, "ret %d\n", err);
       ...
       ...

i open the socket and :

 while (i < loop_nbr)
 {
        /* send frame */
        if ((nbytes = write(s, &frame, sizeof(frame))) != sizeof(frame)) {
                perror("write frame on bus");
                return 1;
        }
        /* go to sleep */
        clock_nanosleep(CLOCK_REALTIME, 0,
                                   &ts,
                                   NULL);
        i++;
}


On Mon, Jul 9, 2012 at 3:19 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> Hello Mohamed,
>
> On Monday 09 July 2012 13:57:11 Mohamed HAMZAOUI wrote:
>> If i have understood you correctly, I think it must change the period
>> if the write function is a synchronous call !
>> if my function is like this :
>>
>> while(1)
>> {
>>     nannosleep(1000000);
>>     write (myFrame in opened CAN socket);
>> }
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
> and link with librt (i.e. -lrt). You can take timespec_add()
> and timespec_sub() sources from our Computers for Control course page
>
> http://support.dce.felk.cvut.cz/pos/hlavni_uloha/timespec_routines.h
>
> The solution can result in infinite/busy loop if the work activity
> is longer than period. There should be some check for that situation
> and skip of some sampling intervals or error reporting and switching
> to emergency/safe stop mode.
>
> Best wishes,
>
>                 Pavel
>
