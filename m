From: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Subject: Re: TX timestamping
Date: Sun, 30 Mar 2014 21:31:07 +0400
Message-ID: <CAGfq0uuQA7GTssg0GrY34V1AcomWPgPX4zLw42XNUBbhZ3eUwg@mail.gmail.com>
References: <CAGfq0uugZi8+BrF_D1cLXjVZ9nePuKeX2fQ5c9vLGRiYQO0RQg@mail.gmail.com>
	<532DE306.1060302@hartkopp.net>
	<CAGfq0uvZWzNCUq6FtOwU7WAfm8UibqJ-47cD3VPTFSUdxgFLhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:33070 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbaC3RbI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 30 Mar 2014 13:31:08 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so6774457yha.5
        for <linux-can@vger.kernel.org>; Sun, 30 Mar 2014 10:31:07 -0700 (PDT)
In-Reply-To: <CAGfq0uvZWzNCUq6FtOwU7WAfm8UibqJ-47cD3VPTFSUdxgFLhg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Whoops sorry, I messed up msghdr initialization. Of course
msg_controllen would be zero since I provided no buffer for the
control message.
Works now.

On Sun, Mar 30, 2014 at 9:17 PM, Pavel Kirienko
<pavel.kirienko.list@gmail.com> wrote:
> Thanks Oliver!
>
> I'm facing an issue with timestamping (not only TX), I hope someone
> could help me with that.
>
> The problem is that I don't receive control message with timestamp
> from recvmsg(), although SO_TIMESTAMP is enabled.
> Here's how I open the socket and read from it: http://pastebin.com/2iQrQuY3
> Problem is at line 78 - recvmsg() returns no control messages.
>
> $ uname -a
> Linux spym-pc 3.2.0-60-generic #91-Ubuntu SMP Wed Feb 19 03:54:44 UTC
> 2014 x86_64 x86_64 x86_64 GNU/Linux
>
> What I'm doing wrong?
>
> Thanks in advance,
> Pavel.
>
> On Sat, Mar 22, 2014 at 11:22 PM, Oliver Hartkopp
> <socketcan@hartkopp.net> wrote:
>> Hello Pavel,
>>
>> On 20.03.2014 17:28, Pavel Kirienko wrote:
>>> Hi linux-can,
>>>
>>> What are my options to get the hardware TX timestamp of an outgoing
>>> CAN frame? I couldn't find complete manual for that, but here's what I
>>> googled so far:
>>>
>>> 1. Use generic socket timestamping, as described in the network man
>>> (http://os1a.cs.columbia.edu/lxr/source/Documentation/networking/timestamping.txt?a=x86);
>>>
>>> 2. Read my own frames back through CAN_RAW_RECV_OWN_MSGS, supposedly
>>> RX timestamps of the loopbacked frames will be the same as their TX
>>> timestamps.
>>>
>>> Are these the correct methods?
>>
>> Yes.
>>
>> With CAN_RAW_RECV_OWN_MSGS you get the echoed frame on a socket which
>> originally sent the frame.
>>
>> The timestamps are currently only set at RX time.
>>
>> http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#2864
>> http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#1463
>>
>> As you can see in net_timestamp_check()
>>
>> http://os1a.cs.columbia.edu/lxr/source/net/core/dev.c?a=x86#1471
>>
>> the timestamp is only set if it was empty before.
>>
>> E.g. if you forward a CAN frame with can-gw there's an extra option to not
>> clear the timestamp when routing the frame (option -t [preserve src_dev rx
>> timestamp]).
>>
>> As the sent frames are echoed back you are pretty right that the RX timestamp
>> and the TX timestamp are the same.
>>
>> Regards,
>> Oliver
>>
