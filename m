From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN documentation
Date: Fri, 25 Jul 2014 16:03:47 +0200
Message-ID: <53D263C3.2090602@hartkopp.net>
References: <1406296057.9487.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:61298 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760404AbaGYODu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 10:03:50 -0400
In-Reply-To: <1406296057.9487.1.camel@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Nikita,

indeed the BCM patches have been added to the tree as well as
CAN FD and filter documentation updates, see commit log at:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/Documentation/networking/can.txt

Don't know if it's really useful to split up the file.

Would you like to provide a patch for the timestamping stuff?

Regards,
Oliver


On 25.07.2014 15:47, Nikita Edward Baruzdin wrote:
> Hello, guys,
> 
> I'm looking at linux-can/can-modules tree:
> 
> 2011-06-26 12:47 Oliver Hartkopp
>   minor doc changes ... tbc
> 
> 2011-06-10 19:08 Oliver Hartkopp
>   documentation: rework chapter numbering & references
> 
> ...
> 
> 2010-11-22 19:41 Oliver Hartkopp
>   Added new documentation layout contributed by Daniele Venzano.
> 
> Why are all these changes still not in the kernel? I'm not sure if this
> is a good idea to split the documentation, but the patches introduce
> some new helpful information.
> 
> Hence a little follow-up question:
> 
>> The timestamp on Linux has a resolution of one microsecond and it is
>> set automatically at the reception of a CAN frame.
> 
> It seems to me this is not entirely true as the kernel has a support for
> SO_TIMESTAMPNS socket option for quite a long time. Could you really use
> that option with CAN? Does it make sense to use nanosecond timestamps?
> I'm also a bit confused whether these are only the software timestamps
> or you can somehow get them from a controller too.
> 
