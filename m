From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Re: Using CAN_FD_FRAME with BCM socket
Date: Thu, 4 May 2017 20:04:51 +0200
Message-ID: <7d495447-8785-9c2b-b2ce-850dcdeaf174@iot.bzh>
References: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
 <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36551 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdEDSE4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2017 14:04:56 -0400
Received: by mail-wm0-f44.google.com with SMTP id u65so4083996wmu.1
        for <linux-can@vger.kernel.org>; Thu, 04 May 2017 11:04:55 -0700 (PDT)
In-Reply-To: <a05f4636-3fa1-1d3f-4daf-e0173120609d@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi here,

Testing with can-tests, tst-bcmfd-filter, I got the following output :

<*>Writing RX_SETUP with RX_FILTER_ID for can_id <042>
<*>Writing RX_DELETE for can_id <042>
<*>Writing RX_SETUP with RX_FILTER_ID for can_id <042>
<2>Writing TX_SEND with wrong can_id <043>
write: Message too long
<3>Writing TX_SEND with correct can_id <042>
write: Message too long

tst-bcm-filter with classic CAN frame, it is running fine.

I check that patch your pointed out is applied at my kernel, do you have 
an idea what could be the problem ? Thanks you.

I continue investigation and let you know if i found anything else.

Best regards.

On 04/26/2017 08:44 PM, Oliver Hartkopp wrote:
> Hi Romain,
>
> On 04/26/2017 11:19 AM, Romain Forlot [IoT.bzh] wrote:
>> I must miss something because I don't get it BCM socket uses
>> canfd_frame. If I use classic can_frame, it works without problems and I
>> don't get it.
>
> Can you send your Linux Kernel version?
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
>
> Regards,
> Oliver

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298

