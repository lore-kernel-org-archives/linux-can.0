From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Mon, 31 Jul 2017 13:33:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:45105 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdGaLdh (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 31 Jul 2017 07:33:37 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id B1DE52800C1
        for <linux-can@vger.kernel.org>; Mon, 31 Jul 2017 13:33:35 +0200 (CEST)
In-Reply-To: <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi,

I tried provoking an error by calling read() with less
than sizeof(struct can_frame) bytes intentionally. The
intention was to corrupt the data this way.

This I did after reading the first 5000 frames properly and than every 300
frames.

I expected to get out of synch after corrupting the reading.

When I read only two bytes no interpretation is done because
two bytes are not a multiple of sizeof(struct can_frame).

During the next read I expected the read to put the remaining
bytes (not red by the previous call to read) in the beginning
of the buffer handed into read. Now the data should be corrupted.

But that is not the case.

The next frame read already seams to be correct.

My question here is if already the socket can driver prevents
corrupting data this way?


Cheers,
Michael



On Fri, 28 Jul 2017, Oliver Hartkopp wrote:

> Hi Michael,
>
> On 07/28/2017 09:01 AM, Michael Dressel wrote:
>
>>  Here is just some code, that is similar to what happens in the
>>  driver we use:
>>
>>  nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
>>       if (nread > 0) {
>>           int i;
>
> If you wanted to check whether only 'correct & complete' struct can_frames 
> have been read from the socket at least this should be done:
>
> 	 if (nread % sizeof(struct can_frame))
> 		 exit(1); // or something like this ;-)
>
>>           nread = nread / sizeof(struct can_frame);
>>               for (i = 0; i < nread; i++) {
>> 
>
> I was really unsure if
>
> 	nread = read(can_fd, &rx[0], sizeof(struct can_frame) * 10);
>
> makes sense at all - and nread would ever be greater than 1 ?!?
>
> I modified https://github.com/linux-can/can-tests/blob/master/tst-raw.c to 
> get a similar setup (diff for tst-raw.c is attached):
>
> while (1) {
>    if ((nbytes = read(s, &frame[0], 10*sizeof(struct can_frame))) < 0) {
>         perror("read");
>         if (!ignore_errors)
>              return 1;
>    } else if (nbytes % sizeof(struct can_frame)) {
>         fprintf(stderr, "read: incomplete CAN frame\n");
>         return 1;
>    } else {
>         for (k=0; k < nbytes / sizeof(struct can_frame); k++) {
>              printf("<%d> ", k);
>
>             if (k) exit(1); // see remark below
>
>              if (frame[0].can_id & CAN_EFF_FLAG)
>                     printf("%8X  ", frame[0].can_id & CAN_EFF_MASK);
>
> (..)
>
> I tested this patch an NEVER got more than ONE single CAN frame per read(). 
> Then I added the brutal
>
> 	if (k) exit(1);
>
> check to not miss any attempt of more than one CAN frame - but it did not 
> occur ...
>
> So I think your provided code does not have the functionality the programmer 
> intended.
>
> If you want to make sure that no frame was dropped in the socket's receive 
> queue take a look at this:
>
> http://marc.info/?l=linux-can&m=147929028915128&w=2
>
> Additionally you might increase the RX buffer size of the socket with the 
> SO_RCVBUF socket option:
>
> https://github.com/linux-can/can-utils/blob/master/candump.c#L525
>
> There are some examples how to use the Linux specific 'multiple read' system 
> calls:
>
> http://rtime.felk.cvut.cz/can/
> http://rtime.felk.cvut.cz/can/can-syscalls.pdf
>
> But finally I would just use recvmsg() and check for the dropcount value to 
> check whether you have a problem at all.
>
> Best,
> Oliver
>
>
>>  I was not able to provoke my issues in a controlled test environment.
>>
>>  And in the productive environment it occurs only about every 3 to 5 weeks.
>>
>>  Cheers,
>>  Michael
>
