From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Wed, 26 Apr 2017 20:44:08 +0200
Message-ID: <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:27176 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965216AbdDZSoL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Apr 2017 14:44:11 -0400
In-Reply-To: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>, linux-can@vger.kernel.org

Hi Romain,

On 04/26/2017 11:19 AM, Romain Forlot [IoT.bzh] wrote:
> I must miss something because I don't get it BCM socket uses
> canfd_frame. If I use classic can_frame, it works without problems and I
> don't get it.

Can you send your Linux Kernel version?

I just want to make sure that it contains this fix:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=5499a6b22e5508b921c447757685b0a5e40a07ed

> Is there someone use canfd_frame with broadcast manager ? Every example
> or source code I browse just use can_frame, only documentation talks
> about that.

Yes, here:

https://github.com/linux-can/can-tests

Namely:

https://github.com/linux-can/can-tests/blob/master/tst-bcmfd-cycle.c
https://github.com/linux-can/can-tests/blob/master/tst-bcmfd-filter.c
https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_delete.c

>
> Here is the code :
>
>  38         struct {
>  39           struct bcm_msg_head msg_head;
>  40           struct canfd_frame frame[4]; /* just an example */
>  41         } msg;
>  42
>  43         memset(msg.frame, 0, sizeof(msg.frame));
>  44
>  45         msg.msg_head.opcode  = RX_SETUP;
>  46         msg.msg_head.can_id  = 0x620;
>  47         msg.msg_head.flags   = SETTIMER|STARTTIMER|CAN_FD_FRAME;
>  48         msg.msg_head.nframes = 1;
>  49         msg.msg_head.count = 0;
>  50         msg.msg_head.ival1.tv_sec = 0;
>  51         msg.msg_head.ival1.tv_usec = 500000;
>  52 //      msg.msg_head.ival2.tv_sec = 0;
>  53 //      msg.msg_head.ival2.tv_usec = 100000;

This is dangerous!

You set SETTIMER|STARTTIMER but leave these values potentially 
uninitialized.

>  54         msg.frame[0].data[0]   = 0x00;
>  55         msg.frame[0].data[1]   = 0x00;
>  56         msg.frame[0].data[2]   = 0x00;
>  57         msg.frame[0].data[3]   = 0x00;
>  58         msg.frame[0].data[4]   = 0x00;
>  59         msg.frame[0].data[5]   = 0x3C;
>  60         msg.frame[0].data[6]   = 0x00;
>  61         msg.frame[0].data[7]   = 0x00;
>  62
>  63         if(write(s, &msg, sizeof(msg)) < 0)
>  64                 printf("This is the end!\n%s\n", strerror(errno));
>
> Then I use select on socket to read frames. In fact, if I remove
> CAN_FD_FRAME it work even if my concatenated struct after bcm_msg_head
> is canfd_frame structure but it will only read size of can_frame which
> is normal.

You always get the concatenated struct depending on CAN_FD_FRAME:
http://lxr.free-electrons.com/source/Documentation/networking/can.txt?v=4.9#L856

What length do you get back from the read() syscall?

Regards,
Oliver
