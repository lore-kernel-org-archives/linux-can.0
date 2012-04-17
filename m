From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Mon, 16 Apr 2012 21:16:52 -0700
Message-ID: <CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
	<4F51DEF0.9060501@hartkopp.net>
	<CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>
	<4F553BDA.8060106@hartkopp.net>
	<4F553CA5.8080704@hartkopp.net>
	<CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
	<4F56701E.3020104@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35141 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2DQEQx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Apr 2012 00:16:53 -0400
Received: by qcro28 with SMTP id o28so3587769qcr.19
        for <linux-can@vger.kernel.org>; Mon, 16 Apr 2012 21:16:53 -0700 (PDT)
In-Reply-To: <4F56701E.3020104@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

It has been some time since I emailed you about this.  I was put onto
other work, but now I have come back to it.

If you will recall, I was trying to send/receive some CAN frames, but
was not seeing any come into my can test program.  However, on the
oscilloscope I do see CAN activity on the bus....

You suggested:

>
> You can check either
>
> cat /proc/net/dev
>
> and
>
> cat /proc/net/can/stats
>
> to see if really any CAN frame entered your system.


I did this.  Here is the output:

# cat /proc/net/can/stats

        0 transmitted frames (TXF)
        0 received frames (RXF)
        0 matched frames (RXMF)

        0 % total match ratio (RXMR)
        0 frames/s total tx rate (TXR)
        0 frames/s total rx rate (RXR)

        0 % current match ratio (CRXMR)
        0 frames/s current tx rate (CTXR)
        0 frames/s current rx rate (CRXR)

        0 % max match ratio (MRXMR)
        0 frames/s max tx rate (MTXR)
        0 frames/s max rx rate (MRXR)

        0 current receive list entries (CRCV)
        1 maximum receive list entries (MRCV)


and...


# cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed
multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:     988      11    0    0    0     0          0         0
988      11    0    0    0     0       0          0
  eth0:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0
  can0:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0
  can1:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0
  can2:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0
  can3:       0       0    0    0    0     0          0         0
  0       0    0    0    0     0       0          0


>
> I assume there is a CAN bus problem:
>
> - wiring (CAN_L/CAN_H)
> - correct CAN termination (2x 120 Ohms)
> - different bitrate
>

I think you are right, but I have checked that, it looks ok.  I will
check again.

I am using a PCAN USB adapter, and the PCAN software says there is an
"acknowledge error" when it sends a frame to my Linux board.

When the Linux board tries to send a frame to PCAN, the PCAN software
says "form error acknowledge delimiter".

It seems this is the same error in both cases, just worded differently.

In your opinion, is this most likely a hardware issue?  Or is there
still some way I could be doing something wrong at the software level?

I can send you any more info you need, if it would help.

Thanks for all your time...

Regards,

Michael
