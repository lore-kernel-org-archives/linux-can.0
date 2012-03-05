From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Mon, 5 Mar 2012 09:49:37 -0800
Message-ID: <CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
	<4F51DEF0.9060501@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52818 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab2CERti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Mar 2012 12:49:38 -0500
Received: by qcqw6 with SMTP id w6so1817145qcq.19
        for <linux-can@vger.kernel.org>; Mon, 05 Mar 2012 09:49:37 -0800 (PST)
In-Reply-To: <4F51DEF0.9060501@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Sat, Mar 3, 2012 at 1:05 AM, Oliver Hartkopp <socketcan@hartkopp.net=
> wrote:
> On 02.03.2012 23:09, Michael Economides wrote:
>
>> I am trying to use the cantest program to read. =A0It just blocks on=
 the
>> read, and stays there forever.
>>
>> =A0I can see on my scope there are can messages coming across the bu=
s (from a
>> different microcontroller attached to the bus).
>>
>> I have already verified I can write using cantest.
>>
>> In other words, this works: =A0./cantest can0 1F334455#1122334455667=
788
>>
>> But this doesn't: =A0./cantest can0
>>
>
>
> Hello Mike,
>
> where is this tool 'cantest' from?
>
> I don't know it either from the SocketCAN utils
>
> https://gitorious.org/linux-can/can-utils
>
> nor from the Pengutronix canutils
>
> http://git.pengutronix.de/?p=3Dtools/canutils.git;a=3Dsummary
>
> Maybe you can alternatively try the SocketCAN utils to test.
>
> Regards,
> Oliver

Hi Oliver,

Thanks for your reply.

"cantest" is a slightly modified version of cansend.c from the link
above.  it does a read() as well as a write().

  basically what i'm seeing is CAN frames (standard format) coming
across the bus, but read() call just blocks as if nothing is there.

A coworker of mine reports that the read() is responding only to
extended frame format.

Can you provide any insight into this?  Specifically, how do we
configure our CAN socket to respond to extended vs. standard frames?
We would like to use standard, not extended.

Thanks,

Mike
