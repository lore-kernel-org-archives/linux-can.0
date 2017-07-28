From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Fri, 28 Jul 2017 09:01:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:38012 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdG1HB2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 28 Jul 2017 03:01:28 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id D5506280168
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2017 09:01:26 +0200 (CEST)
In-Reply-To: <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

thank you very much for the quick reply.


On Thu, 27 Jul 2017, Oliver Hartkopp wrote:

>>  is it guaranteed that a read on a SOCK_RAW  socket will always
>>  return complete can_frames, if it returns data at all?
>
> Yes.
>
> I double checked the code in net/can/raw.c which uses sock_queue_rcv_skb() in 
> net/core/sock.c which completely fails when it's not possible to to place the 
> skb content (the CAN frame) in the socket receive buffer.
>
> In this case the dropcount counter is increased which can be monitored by 
> recvmsg() (see dropcount example in candump.c)

I'm not familiar enough with drivers to really understand that. But is
the read an atomic action? Even if it returns bytes from an completely
filled buffer. Could this read action be interrupted?

Well, anyway I guess I will introduce some messaging to see if I run in
that problem at all.

>>  And, having some very
>>  rare issues not understood yet, I wonder if an error in reading
>>  from the socket may cause this issues.
>
> Don't know. Can you post some code?
>

Here is just some code, that is similar to what happens in the
driver we use:

nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
     if (nread > 0) {
         int i;
         nread = nread / sizeof(struct can_frame);
             for (i = 0; i < nread; i++) {

I was not able to provoke my issues in a controlled test environment.

And in the productive environment it occurs only about every 3 to 5 weeks.

Cheers,
Michael
