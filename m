From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: read() question from newbie
Date: Mon, 05 Mar 2012 23:22:29 +0100
Message-ID: <4F553CA5.8080704@hartkopp.net>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com> <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com> <4F51DEF0.9060501@hartkopp.net> <CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com> <4F553BDA.8060106@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:42868 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2CEWWe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Mar 2012 17:22:34 -0500
In-Reply-To: <4F553BDA.8060106@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: linux-can@vger.kernel.org

On 05.03.2012 23:19, Oliver Hartkopp wrote:

> On 05.03.2012 18:49, Michael Economides wrote:
> 
>> On Sat, Mar 3, 2012 at 1:05 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>> On 02.03.2012 23:09, Michael Economides wrote:
>>>
>>>> I am trying to use the cantest program to read.  It just blocks on the
>>>> read, and stays there forever.
>>>>
>>>>  I can see on my scope there are can messages coming across the bus (from a
>>>> different microcontroller attached to the bus).
>>>>
>>>> I have already verified I can write using cantest.
>>>>
>>>> In other words, this works:  ./cantest can0 1F334455#1122334455667788
>>>>
>>>> But this doesn't:  ./cantest can0
>>>>
>>>
>>>
>>> Hello Mike,
>>>
>>> where is this tool 'cantest' from?
>>>
>>> I don't know it either from the SocketCAN utils
>>>
>>> https://gitorious.org/linux-can/can-utils
>>>
>>> nor from the Pengutronix canutils
>>>
>>> http://git.pengutronix.de/?p=tools/canutils.git;a=summary
>>>
>>> Maybe you can alternatively try the SocketCAN utils to test.
>>>
>>> Regards,
>>> Oliver
>>
>> Hi Oliver,
>>
>> Thanks for your reply.
>>
>> "cantest" is a slightly modified version of cansend.c from the link
>> above.  it does a read() as well as a write().


Ha, ha - did you read that comment in cansend?

    /* disable default receive filter on this RAW socket */
    /* This is obsolete as we do not read from the socket at all, but for */
    /* this reason we can remove the receive list in the Kernel to save a */
    /* little (really a very little!) CPU usage.                          */
    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);


>>
>>   basically what i'm seeing is CAN frames (standard format) coming
>> across the bus, but read() call just blocks as if nothing is there.
>>
>> A coworker of mine reports that the read() is responding only to
>> extended frame format.
>>
>> Can you provide any insight into this?  Specifically, how do we
>> configure our CAN socket to respond to extended vs. standard frames?
>> We would like to use standard, not extended.
> 
> 
> Please just type
> 
> 	candump any
> 
> to check whether you really get anything in your system.
> 
> Using 'candump any' without any additional provided filter definitions
> displays anything (EFF&SFF) which is received on the host.
> 
> Don't know what you've 'slightly modified' :-)
> 
> Therefore check with a unmodified candump first.
> 
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


