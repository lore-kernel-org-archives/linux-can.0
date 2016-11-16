From: Austin Hendrix <namniart@gmail.com>
Subject: Re: Count dropped frames on CAN socket
Date: Wed, 16 Nov 2016 09:13:59 -0800
Message-ID: <deb20a42-ad75-18ea-f796-01bbd27c930f@gmail.com>
References: <519e768b-887e-0aad-9043-7b6b44a61122@gmail.com>
 <CAGt3f4kH7K98K6Xda+2t0VXSQR20o0MDRp6cJMpoL+U_cTUeEg@mail.gmail.com>
 <ec9b7a5b-e587-ef2a-d3ab-47929795799e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32888 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcKPROB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2016 12:14:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so15175236pgd.0
        for <linux-can@vger.kernel.org>; Wed, 16 Nov 2016 09:14:01 -0800 (PST)
In-Reply-To: <ec9b7a5b-e587-ef2a-d3ab-47929795799e@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Brian Silverman <brian@peloton-tech.com>
Cc: linux-can@vger.kernel.org

Awesome, that's exactly what I was looking for.


Thanks!

-Austin


On 11/16/2016 01:57 AM, Oliver Hartkopp wrote:
> And here is how the dropcount stuff has been integrated in candump:
>
> https://github.com/linux-can/can-utils/commit/3c019ea61169d7f08d10d1fece95433c629eb4a6 
>
>
> Regards,
> Oliver
>
>
> On 11/16/2016 01:08 AM, Brian Silverman wrote:
>> Hi Austin,
>>
>> If you enable the (SOL_SOCKET, SO_RX_OVFL) option with setsockopt on a
>> CAN socket, you'll get a corresponding (cmsg_level == SOL_SOCKET,
>> cmsg_type == SO_RXQ_OVFL) piece of ancillary data from recvmsg. The
>> value is a uint32_t containing that exact sk_drops value. The
>> semantics for this value documented in socket(7) are wrong, but the
>> commit message adding it (3b885787ea41) gives a reasonable
>> description. In particular, the message doesn't show up at all until
>> at least one frame is dropped, and it's a total counter not a delta.
>>
>> Brian
>>
>> On Tue, Nov 15, 2016 at 6:32 PM, Austin Hendrix <namniart@gmail.com> 
>> wrote:
>>> Hi linux-can,
>>>
>>> I'm writing a program which receives CAN frames over SocketCAN. I've 
>>> found
>>> on a couple of occasions that my program has had bugs that cause it 
>>> not to
>>> empty the CAN socket receive buffer, and the kernel has dropped 
>>> incoming CAN
>>> frames.
>>>
>>> I had a look through the kernel source code, and found that the 
>>> kernel's
>>> socket framework keeps track of dropped frames in the sk_drops field 
>>> of the
>>> sock struct. Is there a way to retrieve that dropped frame counter 
>>> from my
>>> program, so that it's easier for me to detect problems like this in the
>>> future? (I've looked in the docs and in /proc and haven't been able 
>>> to find
>>> a way to retrieve the sk_drops counter, but it's quite possible that I
>>> missed something)
>>>
>>>
>>> Thanks,
>>>
>>> -Austin
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>

