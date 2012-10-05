From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Fri, 05 Oct 2012 11:16:42 +0200
Message-ID: <506EA57A.3020002@gaisler.com>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com> <506DA06D.3070003@pengutronix.de> <506DA769.6090000@pengutronix.de> <506EA200.1040500@gaisler.com> <506EA2F3.2080609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:47820 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754870Ab2JEJQz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 05:16:55 -0400
In-Reply-To: <506EA2F3.2080609@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 10/05/2012 11:05 AM, Marc Kleine-Budde wrote:
> On 10/05/2012 11:01 AM, Andreas Larsson wrote:
>> On 10/04/2012 05:12 PM, Marc Kleine-Budde wrote:
>>> On 10/04/2012 04:42 PM, Marc Kleine-Budde wrote:
>>>> On 10/04/2012 03:59 PM, Andreas Larsson wrote:
>>>>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>>>>
>>>> Looks better. However on sparc and sparc64, I'm seeing this warning.
>>>>   From my point of view a false positive.
>>>>
>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function
>>>>> 'sja1000_ofp_remove':
>>>>> linux/include/linux/ioport.h:165:18: warning: 'res.end' is used
>>>>> uninitialized in this function [-Wuninitialized]
>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note:
>>>>> 'res.end' was declared here
>>>>> linux/include/linux/ioport.h:165:2: warning: 'res.start' is used
>>>>> uninitialized in this function [-Wuninitialized]
>>>>> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note:
>>>>> 'res.start' was declared here
>>>
>>> Looking at the preprocessed code, the compiler is right:
>>>
>>>> # 30
>>>> "/home/frogger/pengutronix/socketcan/linux/include/linux/of_address.h"
>>>> static inline __attribute__((always_inline))
>>>> __attribute__((no_instrument_function)) int
>>>> of_address_to_resource(struct device_node *dev, int index,
>>>>         struct resource *r)
>>>> {
>>>>    return -22;
>>>> }
>>>
>>> http://lxr.free-electrons.com/source/include/linux/of_address.h#L29
>>>
>>> Why is CONFIG_OF_ADDRESS not set in my .config?
>>
>> In drivers/of/Kconfig, OF_ADDRESS depends on !SPARC as sparc handles a
>> bunch of open firmware things differently. There is a sparc-specific
>> implementations of of_address_to_resource.
>>
>> I'll send in a patch changing of_address.h so that
>> of_address_to_resource gets declared extern for sparc instead of an
>> empty inline function. That should solve the problem as far as I see it.
>>
>> There is a similar thing with CONFIG_OF_IRQ, of_irq.h and
>> irq_of_parse_and_map, but there irq_of_parse_and_map is declared outside
>> of #ifdef CONFIG_OF_IRQ because of the sparc specific implementation.
>
> I've noticed that, too. With the patch you posted the driver cannot
> work, as the header files provide just no-ops of the of functions.
> Please test your patch before posting :).

My test branch is pre commit a850a7554442f08d3e910c6eeb4ee216868dda1e 
that introduced the empty functions and the dependency on 
CONFIG_OF_ADDRESS in of_address.h. So there everything worked fine.

Makes it clear that it is time to rebase the set of external patches 
that I need to run my hardware.

> I'm preparing a patch to integrate the OF handling into the existing
> platform driver. I'll send you a note when I have something to test.

Great!

cheers
Andreas

