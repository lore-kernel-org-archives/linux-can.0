From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Sat, 5 Jul 2014 11:38:38 -0700
Message-ID: <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
 <53B7D63B.2060108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:41565 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaGESi7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Jul 2014 14:38:59 -0400
Received: by mail-ig0-f177.google.com with SMTP id c1so3149492igq.16
        for <linux-can@vger.kernel.org>; Sat, 05 Jul 2014 11:38:59 -0700 (PDT)
In-Reply-To: <53B7D63B.2060108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Sat, Jul 5, 2014 at 3:40 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 04.07.2014 01:03, Austin Schuh wrote:
>> I'm seeing the following panic.  I've seen it on multiple kernel
>> versions (3.10.24 patched, and 3.14.3).
>>
>> uname -a
>> Linux vpc5 3.14.3-rt4abs+ #16 SMP PREEMPT RT Tue Jul 1 16:28:26 PDT
>> 2014 x86_64 GNU/Linux
>>
>> Jul  3 12:18:28 vpc7 kernel: [   16.691928] skbuff: skb_under_panic:
>> text:ffffffff814fb64d len:-65447 put:-65463 head:ffff880407415080
>> data:ffff88030742507f tail:0x58 end:0x80 dev:can0
>> Jul  3 12:18:28 vpc7 kernel: [   16.692207] ------------[ cut here ]------------
>> Jul  3 12:18:28 vpc7 kernel: [   16.692209] kernel BUG at net/core/skbuff.c:100!
> (..)
>> Jul  3 12:18:28 vpc7 kernel: [   16.692330] Call Trace:
>> Jul  3 12:18:28 vpc7 kernel: [   16.692340]  [<ffffffff8143e142>]
>> skb_push+0x38/0x39
>> Jul  3 12:18:28 vpc7 kernel: [   16.692348]  [<ffffffff814fb64d>]
>> packet_rcv_spkt+0x98/0xdf
>> Jul  3 12:18:28 vpc7 kernel: [   16.692357]  [<ffffffff8144b8f8>]
>> __netif_receive_skb_core+0x459/0x4dc
>
>>
>> Any ideas what is causing it?  The issue seems to be that the data
>> pointer is less than the head pointer, from reading the code.  It only
>> happens right at startup.
>
> Hi Austin,
>
> as you are using the PF_PACKET socket here - where packet_rcv_spkt() is using
> skb_push() - the things are slightly different to the PF_CAN handling.
>
> Are these kernel panics related to the reception of CAN frames - or do they
> only show up when you send CAN frames (via PF_PACKET socket)??
>
> Can you tell something more about how you send and receive CAN frames in your
> setup?
>
> Best regards,
> Oliver

Hi Oliver,

I'm opening the socket with the following calls:

int socket_ = socket(PF_CAN, SOCK_RAW, CAN_RAW);
struct ifreq ifr;
ioctl(socket_, SIOCGIFINDEX, &ifr);
struct sockaddr_can addr;
addr.can_family = AF_CAN;
addr.can_ifindex = ifr.ifr_ifindex;
bind(socket_, (struct sockaddr *)&addr, sizeof(addr));

And sending with:

struct can_frame frame
write(socket_, &frame, sizeof(struct can_frame))

These panics only show up at startup time.  As you can see from the
syslog entries at the various times, they all happen within the first
20 seconds of the machine coming up, and I only get a max of 1 problem
frame per boot per interface.  My logs show that the frame that
triggers the problem comes in within 1 second of the CAN interface
being initialized.

Jul  3 09:32:46 vpc6 kernel: [    5.310067] loop: module loaded
Jul  3 09:32:46 vpc6 kernel: [    5.347914] vcan: Virtual CAN interface driver
Jul  3 09:32:46 vpc6 kernel: [    6.635362] XFS (sda6): Mounting Filesystem
Jul  3 09:32:46 vpc6 kernel: [    6.659463] XFS (sda6): Starting
recovery (logdev: internal)
Jul  3 09:32:46 vpc6 kernel: [    6.670430] XFS (sda6): Ending
recovery (logdev: internal)
Jul  3 09:32:46 vpc6 kernel: [    6.680831] XFS (sda7): Mounting Filesystem
Jul  3 09:32:46 vpc6 kernel: [    6.847411] XFS (sda7): Starting
recovery (logdev: internal)
Jul  3 09:32:46 vpc6 kernel: [    6.852927] XFS (sda7): Ending
recovery (logdev: internal)
Jul  3 09:32:46 vpc6 kernel: [    7.489861] peak_pci 0000:04:00.0
can0: setting BTR0=0x01 BTR1=0x9c
Jul  3 09:32:46 vpc6 kernel: [    7.564411] peak_pci 0000:04:00.0
can1: setting BTR0=0x00 BTR1=0x9c
Jul  3 09:32:46 vpc6 kernel: [    7.863569] r8169 0000:05:00.0 eth0:
unable to load firmware patch rtl_nic/rtl8168e-3.fw (-2)
Jul  3 09:32:46 vpc6 kernel: [    7.873102] r8169 0000:05:00.0 eth0: link down
Jul  3 09:32:46 vpc6 kernel: [    7.873169] IPv6: ADDRCONF(NETDEV_UP):
eth0: link is not ready
Jul  3 09:32:46 vpc6 kernel: [    7.873212] r8169 0000:05:00.0 eth0: link down
Jul  3 09:32:46 vpc6 kernel: [    7.887542] skbuff: skb_under_panic:
text:ffffffff81492274 len:89 put:73 head:ffff8802176a9a40
data:ffff8802176a9a3f tail:0x58 end:0x80 dev:can1
Jul  3 09:32:46 vpc6 kernel: [    7.887665] ------------[ cut here ]------------
Jul  3 09:32:46 vpc6 kernel: [    7.887666] kernel BUG at net/core/skbuff.c:127!

I think the problem is related to reception and startup.  I don't have
logs to conclusively show it, but I'm pretty certain that my sending
or reading applications haven't been started up by the time the panic
triggers.  I'll try to grab better evidence of that next time I
observe it.

Thanks!
  Austin
