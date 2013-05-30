From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: RFC: (optional) software filtering in candump
Date: Thu, 30 May 2013 14:07:03 +0200
Message-ID: <51A740E7.3020400@volkswagen.de>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:33885 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3E3MHR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 May 2013 08:07:17 -0400
In-Reply-To: <20130530101719.GB427@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Sebastian Haas <dev@sebastianhaas.info>, linux-can Mailing List <linux-can@vger.kernel.org>

Am 30.05.2013 12:17, schrieb Kurt Van Dijck:
> On Thu, May 30, 2013 at 11:06:30AM +0200, Sebastian Haas wrote:
>> Am 30.05.2013 10:49, schrieb Oliver Hartkopp:
>>>>> On 29.05.2013 22:55, Sebastian Haas wrote:
>>>>>> If I start candump this way:
>>>>>> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>>>>>>   I want to receive any messages except 100h and 101h.
>>>>>>
>>>>>> When I send a message which matches the filter, it is received twice:
>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>>>>>>    vcan0  1FF   [1]  22
>>>>>>    vcan0  1FF   [1]  22
>>>>>>
>>>>>> When I send a message which should not received at all, it is received:
>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>>>>>>    vcan0  100   [1]  22
>>>>>>
>>>>>> Did I misunderstood the filter here?
>>>>>
>>>>> The filters are independent and therefore "logical OR".
>>>> Ok. That explain why received 100h even though I tried to filter it
>>>> out. But
>>>> why receive a message twice while it was only sent once?
>>>
>>> You have defined two(!) filters that let pass the CAN-ID 0x1FF.
>>>
>>> So what else would you expect?
>> This is actually the way it meant to be? Why? Honestly this is a bug
>> for me! The filter should stop when it matched and not going further
>> generating ghost messages which were never sent?
>
> I had initially the same feeling. The problem here IMHO is
> what the user expects is different from what the kernel does.
>
> What the user expects is a 'socket' based filter.
> The kernel implements an optimised, socket-agnostic filter.
> This is even more generic, but the kernel expects a CAN_RAW program
> to set 'rough' filters and have the fine control in the program.
>
> This actually works very good, and is a clever thing to do.
>
> However, candump does expose this kernel behaviour to the user. The user,
> as said, expects something different that what he gets.
> So the user thinks it is a bug.
>
> How to solve this: I think the correct way is to let candump
> expose the filtering that a user expects, whether in userspace
> or in kernelspace.
> Is such approach efficient? no. Does that matter? probably not.
> candump is, IMO, not an automation tool. It's an administrator/diagnostic tool.
>
> Although I have no real code in mind yet, I think the expected
> filtering is much easier to implement within a single program,
> than it would be in kernelspace.
>
> On the other hand, I have found candump's exposure of kernel work
> a true friend during development.
> So I'd vote to have an extra control on candump which filtering to use.
>
> Any thoughts?

Yes :-)

I was thinking about a concatenated filter.

On the commandline it could look like this:

	candump vcan0,100~C00007FF&101~C00007FF,<more filters>

The idea would be to add to the existing functions

	can_rx_register()
	can_rx_unregister()

two new functions to af_can.c :

	can_rxcon_register()
	can_rxcon_unregister()

Which would take an array of filters belonging together (logical AND).

This array of filters is then registered but has a linked list between it's 
elements.

If one element is hit by an incoming CAN ID, all elements of this linked list 
are transversed, ...
... until we get back to the first element -> CAN ID passed all filters
... or the filter killed the CAN ID

Concatenated filters are always treated as a single filter, so it would not be 
possible to remove a single CAN-ID check from the linked list.

Looks possible and comfortable at first sight.
But i have no idea about possible runtime constrains and how we would need to 
limit the maximum number of linked list elements.

And if all this is easy to integrate ;-)

Regards,
Oliver

