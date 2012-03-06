From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: read() question from newbie
Date: Tue, 06 Mar 2012 21:14:22 +0100
Message-ID: <4F56701E.3020104@hartkopp.net>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com> <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com> <4F51DEF0.9060501@hartkopp.net> <CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com> <4F553BDA.8060106@hartkopp.net> <4F553CA5.8080704@hartkopp.net> <CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:9659 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030933Ab2CFUOj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Mar 2012 15:14:39 -0500
In-Reply-To: <CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: linux-can@vger.kernel.org

On 06.03.2012 19:53, Michael Economides wrote:


> Yes, we removed that line of code with the filtering in cansend.c


fine.

> I ran "candump any", it just sits there, nothing is printed to the
> screen.  So it looks like it thinks nothing is coming across on the
> CAN bus(?)  But like I already stated, on the scope I can see some CAN
> frames being sent to me.


You can check either

cat /proc/net/dev

and

cat /proc/net/can/stats

to see if really any CAN frame entered your system.

I assume there is a CAN bus problem:

- wiring (CAN_L/CAN_H)
- correct CAN termination (2x 120 Ohms)
- different bitrate

> 
> I will be using a Can analyzer tools today, to further my investigation.


Adding some more CAN nodes can help too - so adding another tool and testing
is always a good idea.

> 
> Bascially, all I was asking of you is what could cause read() to wait
> forever... or candump to just sit there and wait?


Well yes. It does a blocking read to get and print receive CAN frames. What do
you expect?

> Maybe the CAN data being sent is not valid (garbage)?


Yes. Please check the three points mentioned above.

Best regards,
Oliver
