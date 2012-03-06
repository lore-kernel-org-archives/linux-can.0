From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Tue, 6 Mar 2012 10:53:48 -0800
Message-ID: <CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
	<4F51DEF0.9060501@hartkopp.net>
	<CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>
	<4F553BDA.8060106@hartkopp.net>
	<4F553CA5.8080704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37905 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965012Ab2CFSxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Mar 2012 13:53:49 -0500
Received: by qcqw6 with SMTP id w6so2683918qcq.19
        for <linux-can@vger.kernel.org>; Tue, 06 Mar 2012 10:53:48 -0800 (PST)
In-Reply-To: <4F553CA5.8080704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, Mar 5, 2012 at 2:22 PM, Oliver Hartkopp <socketcan@hartkopp.net=
> wrote:
> On 05.03.2012 23:19, Oliver Hartkopp wrote:
>
>> On 05.03.2012 18:49, Michael Economides wrote:
>>
>>> On Sat, Mar 3, 2012 at 1:05 AM, Oliver Hartkopp <socketcan@hartkopp=
=2Enet> wrote:
>>>> On 02.03.2012 23:09, Michael Economides wrote:
>>>>
>>>>> I am trying to use the cantest program to read. =A0It just blocks=
 on the
>>>>> read, and stays there forever.
>>>>>
>>>>> =A0I can see on my scope there are can messages coming across the=
 bus (from a
>>>>> different microcontroller attached to the bus).
>>>>>
>>>>> I have already verified I can write using cantest.
>>>>>
>>>>> In other words, this works: =A0./cantest can0 1F334455#1122334455=
667788
>>>>>
>>>>> But this doesn't: =A0./cantest can0
>>>>>
>>>>
>>>>
>>>> Hello Mike,
>>>>
>>>> where is this tool 'cantest' from?
>>>>
>>>> I don't know it either from the SocketCAN utils
>>>>
>>>> https://gitorious.org/linux-can/can-utils
>>>>
>>>> nor from the Pengutronix canutils
>>>>
>>>> http://git.pengutronix.de/?p=3Dtools/canutils.git;a=3Dsummary
>>>>
>>>> Maybe you can alternatively try the SocketCAN utils to test.
>>>>
>>>> Regards,
>>>> Oliver
>>>
>>> Hi Oliver,
>>>
>>> Thanks for your reply.
>>>
>>> "cantest" is a slightly modified version of cansend.c from the link
>>> above. =A0it does a read() as well as a write().
>
>
> Ha, ha - did you read that comment in cansend?
>
> =A0 =A0/* disable default receive filter on this RAW socket */
> =A0 =A0/* This is obsolete as we do not read from the socket at all, =
but for */
> =A0 =A0/* this reason we can remove the receive list in the Kernel to=
 save a */
> =A0 =A0/* little (really a very little!) CPU usage. =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
>
>
>>>
>>> =A0 basically what i'm seeing is CAN frames (standard format) comin=
g
>>> across the bus, but read() call just blocks as if nothing is there.
>>>
>>> A coworker of mine reports that the read() is responding only to
>>> extended frame format.
>>>
>>> Can you provide any insight into this? =A0Specifically, how do we
>>> configure our CAN socket to respond to extended vs. standard frames=
?
>>> We would like to use standard, not extended.
>>
>>
>> Please just type
>>
>> =A0 =A0 =A0 candump any
>>
>> to check whether you really get anything in your system.
>>
>> Using 'candump any' without any additional provided filter definitio=
ns
>> displays anything (EFF&SFF) which is received on the host.
>>
>> Don't know what you've 'slightly modified' :-)
>>
>> Therefore check with a unmodified candump first.
>>
>> Regards,
>> Oliver
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>

Hi Oliver,

Yes, we removed that line of code with the filtering in cansend.c

I ran "candump any", it just sits there, nothing is printed to the
screen.  So it looks like it thinks nothing is coming across on the
CAN bus(?)  But like I already stated, on the scope I can see some CAN
frames being sent to me.

I will be using a Can analyzer tools today, to further my investigation=
=2E

Bascially, all I was asking of you is what could cause read() to wait
forever... or candump to just sit there and wait?

Maybe the CAN data being sent is not valid (garbage)?

Thanks again for your help!

Mike
