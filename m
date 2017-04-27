From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Thu, 27 Apr 2017 10:23:59 +0200
Message-ID: <e450a73d-33e2-f273-ea84-4b056df270d6@iot.bzh>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34907 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967248AbdD0IYQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Apr 2017 04:24:16 -0400
Received: by mail-wr0-f175.google.com with SMTP id z52so12640629wrc.2
        for <linux-can@vger.kernel.org>; Thu, 27 Apr 2017 01:24:15 -0700 (PDT)
In-Reply-To: <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Oliver,

On 04/26/2017 08:44 PM, Oliver Hartkopp wrote:
> Hi Romain,
>
> On 04/26/2017 11:19 AM, Romain Forlot [IoT.bzh] wrote:
>> I must miss something because I don't get it BCM socket uses
>> canfd_frame. If I use classic can_frame, it works without problems and I
>> don't get it.
>
> Can you send your Linux Kernel version?
Yes, I'm running  4.10.11-200.fc25.x86_64. This patch has been applied 
to the kernel ?
>
> I just want to make sure that it contains this fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=5499a6b22e5508b921c447757685b0a5e40a07ed 
>
>
>> Is there someone use canfd_frame with broadcast manager ? Every example
>> or source code I browse just use can_frame, only documentation talks
>> about that.
>
> Yes, here:
>
> https://github.com/linux-can/can-tests
>
> Namely:
>
> https://github.com/linux-can/can-tests/blob/master/tst-bcmfd-cycle.c
> https://github.com/linux-can/can-tests/blob/master/tst-bcmfd-filter.c
> https://github.com/linux-can/can-tests/blob/master/tst-bcm-tx_delete.c
>
Damned, I pass over them... Thanks you !
>>
>> Here is the code :
>>
>>  38         struct {
>>  39           struct bcm_msg_head msg_head;
>>  40           struct canfd_frame frame[4]; /* just an example */
>>  41         } msg;
>>  42
>>  43         memset(msg.frame, 0, sizeof(msg.frame));
>>  44
>>  45         msg.msg_head.opcode  = RX_SETUP;
>>  46         msg.msg_head.can_id  = 0x620;
>>  47         msg.msg_head.flags   = SETTIMER|STARTTIMER|CAN_FD_FRAME;
>>  48         msg.msg_head.nframes = 1;
>>  49         msg.msg_head.count = 0;
>>  50         msg.msg_head.ival1.tv_sec = 0;
>>  51         msg.msg_head.ival1.tv_usec = 500000;
>>  52 //      msg.msg_head.ival2.tv_sec = 0;
>>  53 //      msg.msg_head.ival2.tv_usec = 100000;
>
> This is dangerous!
>
> You set SETTIMER|STARTTIMER but leave these values potentially 
> uninitialized.
This was just a sandbox piece of code, I do a memset before to 
initialize my struct :)
>
>>  54         msg.frame[0].data[0]   = 0x00;
>>  55         msg.frame[0].data[1]   = 0x00;
>>  56         msg.frame[0].data[2]   = 0x00;
>>  57         msg.frame[0].data[3]   = 0x00;
>>  58         msg.frame[0].data[4]   = 0x00;
>>  59         msg.frame[0].data[5]   = 0x3C;
>>  60         msg.frame[0].data[6]   = 0x00;
>>  61         msg.frame[0].data[7]   = 0x00;
>>  62
>>  63         if(write(s, &msg, sizeof(msg)) < 0)
>>  64                 printf("This is the end!\n%s\n", strerror(errno));
>>
>> Then I use select on socket to read frames. In fact, if I remove
>> CAN_FD_FRAME it work even if my concatenated struct after bcm_msg_head
>> is canfd_frame structure but it will only read size of can_frame which
>> is normal.
>
> You always get the concatenated struct depending on CAN_FD_FRAME:
> http://lxr.free-electrons.com/source/Documentation/networking/can.txt?v=4.9#L856 
>
>
> What length do you get back from the read() syscall?
It's the heck, I don't get anything :) I'm stuck at select but I'll just 
take a look at the code you send me before and see what I'm doing wrong.
>
> Regards,
> Oliver

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298

