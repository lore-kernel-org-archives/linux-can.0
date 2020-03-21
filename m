From: Robert Barrows <robb.barrows@gmail.com>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Sat, 21 Mar 2020 14:15:17 -0500
Message-ID: <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35723 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUTPb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 15:15:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id u12so10170348ljo.2
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2020 12:15:29 -0700 (PDT)
In-Reply-To: <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

> You don't use sockets from INSIDE the kernel.
> If you want to send CAN frames from inside the kernel you should use the
> can_send() function from af_can.c
Great to know! I Will look at that right away, any example(s) you could point
me towards?

> Is your requirement to send "some content" in a very defined time slot
> OR do you need to send the time as content?
Use case:
I need to send the epoch seconds as close to the zeroth of the second
as possible, there are some legacy cards that use this packet to set their
clocks, and I am attempting a solution to improve their accuracy without
modifying their firmware.
Hence I have a kernel module that can run a function with sub 10uS accuracy,
the function of choice would spit out a CAN packet with the epoch seconds in
it.

> Sending CAN frames in a very precise (hrtimer) manner can be done with
> the broadcast manager (aka CAN_BCM) sockets.
>
> See:
> https://elixir.bootlin.com/linux/latest/source/Documentation/networking/can.rst#L677
>
> 1. You can send fixed CAN frames and also a sequence of up to 256
> (different) CAN frames at a precisely defined time with a CAN_BCM TX job.

struct timeval ival1, ival2;    /* count and subsequent interval */
Unfortunately, this doesn't look like it fits my use case, would have been nice
to do from user space though.  This looks like it can send out evenly spaced
packets. And I need to send one packet at a precise clock time.

> 2. You can generate the timestamp in user space and send it via CAN_RAW
> socket.

This also wont work due to the use case.

> 3. You write your own kernel module o_O :)

Here we are :)
