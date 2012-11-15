From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 22:19:33 +0100
Message-ID: <50A55C65.2020003@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50191 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab2KOVTf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 16:19:35 -0500
In-Reply-To: <loom.20121115T171319-854@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/15/2012 05:23 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>>>
>>> 3. It turned out that the pch_can controller is created upon the C_CAN
>>> CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
>>> pch_can driver with a PCI-attached C_CAN driver:
>>>
>>> http://thread.gmane.org/gmane.linux.can/815
>>>
>>> I don't know the current state of the tests/replacement.
>>
>> As you can see from this thread, the replacement patch did not yet
>> succesfully run on such a platform. But I definitively would like to get
>> rid of the obsolete pch_can driver. Testers are welcome! Michael, would
>> you be able/willing to test a patch, even with a recent kernel version?
> 
> I would be willing to test a patch, however any fix would need to be back-ported
> to the 3.2.0 kernel to be useful to me.  For the sake of testing though, I would
> be willing to update to a newer kernel.

I need to check first if this driver can be supported with little effort.

> Also, I should warn you that I am not a Linux expert.  Thus, operations like
> updating/recompiling the kernel are new to me and I'll need some help working
> through the process.

Of course! You are welcome. What Linux distribution do you use?

Wolfgang.
