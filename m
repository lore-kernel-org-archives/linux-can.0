From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: RFC: (optional) software filtering in candump
Date: Thu, 30 May 2013 12:17:19 +0200
Message-ID: <20130530101719.GB427@vandijck-laurijssen.be>
References: <51A66B55.6080506@sebastianhaas.info>
 <51A6DC6A.7020609@hartkopp.net>
 <51A70F0E.1010902@sebastianhaas.info>
 <51A71298.1070202@volkswagen.de>
 <51A71696.8030609@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:15460 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967706Ab3E3KRZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 May 2013 06:17:25 -0400
Content-Disposition: inline
In-Reply-To: <51A71696.8030609@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On Thu, May 30, 2013 at 11:06:30AM +0200, Sebastian Haas wrote:
> Am 30.05.2013 10:49, schrieb Oliver Hartkopp:
> >>>On 29.05.2013 22:55, Sebastian Haas wrote:
> >>>>If I start candump this way:
> >>>>sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
> >>>>  I want to receive any messages except 100h and 101h.
> >>>>
> >>>>When I send a message which matches the filter, it is received twice:
> >>>>sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
> >>>>   vcan0  1FF   [1]  22
> >>>>   vcan0  1FF   [1]  22
> >>>>
> >>>>When I send a message which should not received at all, it is received:
> >>>>sh@helios:~/workspace/node-can$ cansend vcan0 100#22
> >>>>   vcan0  100   [1]  22
> >>>>
> >>>>Did I misunderstood the filter here?
> >>>
> >>>The filters are independent and therefore "logical OR".
> >>Ok. That explain why received 100h even though I tried to filter it
> >>out. But
> >>why receive a message twice while it was only sent once?
> >
> >You have defined two(!) filters that let pass the CAN-ID 0x1FF.
> >
> >So what else would you expect?
> This is actually the way it meant to be? Why? Honestly this is a bug
> for me! The filter should stop when it matched and not going further
> generating ghost messages which were never sent?

I had initially the same feeling. The problem here IMHO is
what the user expects is different from what the kernel does.

What the user expects is a 'socket' based filter.
The kernel implements an optimised, socket-agnostic filter.
This is even more generic, but the kernel expects a CAN_RAW program
to set 'rough' filters and have the fine control in the program.

This actually works very good, and is a clever thing to do.

However, candump does expose this kernel behaviour to the user. The user,
as said, expects something different that what he gets.
So the user thinks it is a bug.

How to solve this: I think the correct way is to let candump
expose the filtering that a user expects, whether in userspace
or in kernelspace.
Is such approach efficient? no. Does that matter? probably not.
candump is, IMO, not an automation tool. It's an administrator/diagnostic tool.

Although I have no real code in mind yet, I think the expected
filtering is much easier to implement within a single program,
than it would be in kernelspace.

On the other hand, I have found candump's exposure of kernel work
a true friend during development.
So I'd vote to have an extra control on candump which filtering to use.

Any thoughts?

Kurt
