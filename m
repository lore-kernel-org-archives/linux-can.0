From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: How to send a CAN message while in a kernel module?
Date: Sat, 21 Mar 2020 17:46:04 +0100
Message-ID: <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:18509 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCUQqM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 12:46:12 -0400
In-Reply-To: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Barrows <robb.barrows@gmail.com>, linux-can@vger.kernel.org

Hi Robert,

On 21/03/2020 15.50, Robert Barrows wrote:
> I have attempted to write a kernel module that sends a message via CAN but I am
> having trouble understanding which level of the socket api I should be using,
> and where there may be some documentation or examples of how to use it?
> 
> I am on a much older embedded 2.6.31 imx arm kernel, and eventually I
> would like to
> send this message from within a high res timer triggered ISR.

You can probably use the CAN_BCM sockets for your use-case which uses 
high-res timers too - even in the 2.6.31 kernel. But I'll come to that 
later ...

> This is my code, which is hobbled together from internet examples, and kernel
> oops is during sock_sendmsg, for now I am just trying to get it do run as part
> of the init of the module:
> 
> int SendCanTime(struct timespec *tsCurrentTime) {
>    int s;
>    struct sockaddr_can addr;
>    struct can_frame frame;
>    struct socket *sock;
>    int thetime = tsCurrentTime->tv_sec;
>    mm_segment_t oldfs;
> 
>    oldfs = get_fs();
>    set_fs(KERNEL_DS);
> 
>    printk("cantime.ko: Socket 10\n");
>    if ((s = sock_create(PF_CAN, SOCK_RAW, CAN_RAW, &sock)) < 0) {
>      printk("cantime.ko: Socket failure\n");
>      return 1;
>    }

Argh - No!

You don't use sockets from INSIDE the kernel.
If you want to send CAN frames from inside the kernel you should use the 
can_send() function from af_can.c

> 
>    printk("cantime.ko: Socket 20\n");
>    memset(&addr, 0, sizeof(addr));
>    addr.can_family = PF_CAN;
>    addr.can_ifindex = 2; // This is bad how do I dynamically find it?
> 
>    printk("cantime.ko: Socket 30");
>    if (sock->ops->bind(sock, (struct sockaddr *)&addr, sizeof(struct
> sockaddr) ) < 0) {
>      printk("cantime.ko: Bind failure\n");
>      return 1;
>    }
> 
>    printk("cantime.ko: Socket 40\n");
>    frame.can_id = 0x00050F93 | CAN_EFF_FLAG;
>    frame.can_dlc = 6;
>    frame.data[0] = 0x00;
>    frame.data[1] = 0x02;
> 
>    memcpy(frame.data+2, &thetime, sizeof(int));

Is your requirement to send "some content" in a very defined time slot 
OR do you need to send the time as content?

> 
>    printk("cantime.ko: Socket 50\n");
>    if (sock_sendmsg(sock,(struct msghdr*)&frame,sizeof(struct
> can_frame)) !=  sizeof(struct can_frame)) {
>      printk("cantime.ko: Write failure");
>      return 1;
>    }
> 
>    sock_release(sock);
>    set_fs(oldfs);
> 
>    return 0;
> 
> }
> 
> Output:
> cantime.ko: Socket 10
> cantime.ko: Socket 20
> cantime.ko: Socket 30cantime.ko: Socket 40
> cantime.ko: Socket 50
> Unable to handle kernel paging request at virtual address 80050f93
> pgd = d14c8000
> [80050f93] *pgd=00000000
> Internal error: Oops: 1 [#1] PREEMPT
> Modules linked in: cantime(+) g_ether arcotg_udc

Funny thing :-)

> I also have the user space code that works perfectly that I was trying to model
> my kernel module code after:

Ok - but we need to check your use-case.

Sending CAN frames in a very precise (hrtimer) manner can be done with 
the broadcast manager (aka CAN_BCM) sockets.

See:
https://elixir.bootlin.com/linux/latest/source/Documentation/networking/can.rst#L677

1. You can send fixed CAN frames and also a sequence of up to 256 
(different) CAN frames at a precisely defined time with a CAN_BCM TX job.

2. You can generate the timestamp in user space and send it via CAN_RAW 
socket.

3. You write your own kernel module o_O :)

Regards,
Oliver
