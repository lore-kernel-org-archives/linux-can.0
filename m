From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RFC: (optional) software filtering in candump
Date: Thu, 30 May 2013 17:55:03 +0200
Message-ID: <51A77657.5060004@hartkopp.net>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:21081 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab3E3PzH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 May 2013 11:55:07 -0400
In-Reply-To: <51A77250.8070907@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 30.05.2013 17:37, Sebastian Haas wrote:
> Am 30.05.2013 14:35, schrieb Kurt Van Dijck:
>> On Thu, May 30, 2013 at 02:07:03PM +0200, Oliver Hartkopp wrote:
>>> Am 30.05.2013 12:17, schrieb Kurt Van Dijck:
>>>> On Thu, May 30, 2013 at 11:06:30AM +0200, Sebastian Haas wrote:
>>>>> Am 30.05.2013 10:49, schrieb Oliver Hartkopp:
>>>>>>>> On 29.05.2013 22:55, Sebastian Haas wrote:
>>>>>>>>> If I start candump this way:
>>>>>>>>> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>>>>>>>>>   I want to receive any messages except 100h and 101h.
>>>>>>>>>
>>>>>>>>> When I send a message which matches the filter, it is received twice:
>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>>>>>>>>>    vcan0  1FF   [1]  22
>>>>>>>>>    vcan0  1FF   [1]  22
>>>>>>>>>
>>>>>>>>> When I send a message which should not received at all, it is received:
>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>>>>>>>>>    vcan0  100   [1]  22
>>>>>>>>>
>>>>>>>>> Did I misunderstood the filter here?
>>>>>>>>
>>>>>>>> The filters are independent and therefore "logical OR".
>>>>>>> Ok. That explain why received 100h even though I tried to filter it
>>>>>>> out. But
>>>>>>> why receive a message twice while it was only sent once?
>>>>>>
>>>>>> You have defined two(!) filters that let pass the CAN-ID 0x1FF.
>>>>>>
>>>>>> So what else would you expect?
>>>>> This is actually the way it meant to be? Why? Honestly this is a bug
>>>>> for me! The filter should stop when it matched and not going further
>>>>> generating ghost messages which were never sent?
>>>>
>>>> I had initially the same feeling. The problem here IMHO is
>>>> what the user expects is different from what the kernel does.
>>>>
>>>> What the user expects is a 'socket' based filter.
>>>> The kernel implements an optimised, socket-agnostic filter.
>>>> This is even more generic, but the kernel expects a CAN_RAW program
>>>> to set 'rough' filters and have the fine control in the program.
>>>>
>>>> This actually works very good, and is a clever thing to do.
>>>>
>>>> However, candump does expose this kernel behaviour to the user. The user,
>>>> as said, expects something different that what he gets.
>>>> So the user thinks it is a bug.
>>>>
>>>> How to solve this: I think the correct way is to let candump
>>>> expose the filtering that a user expects, whether in userspace
>>>> or in kernelspace.
>>>> Is such approach efficient? no. Does that matter? probably not.
>>>> candump is, IMO, not an automation tool. It's an administrator/diagnostic
>>>> tool.
>>>>
>>>> Although I have no real code in mind yet, I think the expected
>>>> filtering is much easier to implement within a single program,
>>>> than it would be in kernelspace.
>>>>
>>>> On the other hand, I have found candump's exposure of kernel work
>>>> a true friend during development.
>>>> So I'd vote to have an extra control on candump which filtering to use.
>>>>
>>>> Any thoughts?
>>>
>>> Yes :-)
>>>
>>> I was thinking about a concatenated filter.
>>>
>>> On the commandline it could look like this:
>>>
>>>     candump vcan0,100~C00007FF&101~C00007FF,<more filters>
>>>
>>> The idea would be to add to the existing functions
>>>
>>>     can_rx_register()
>>>     can_rx_unregister()
>>>
>>> two new functions to af_can.c :
>>>
>>>     can_rxcon_register()
>>>     can_rxcon_unregister()
>>>
>>> Which would take an array of filters belonging together (logical AND).
>>>
>>> This array of filters is then registered but has a linked list
>>> between it's elements.
>>>
>>> If one element is hit by an incoming CAN ID, all elements of this
>>> linked list are transversed, ...
>>> ... until we get back to the first element -> CAN ID passed all filters
>>> ... or the filter killed the CAN ID
>>>
>>> Concatenated filters are always treated as a single filter, so it
>>> would not be possible to remove a single CAN-ID check from the
>>> linked list.
>>>
>>> Looks possible and comfortable at first sight.
>>> But i have no idea about possible runtime constrains and how we
>>> would need to limit the maximum number of linked list elements.
>>>
>>> And if all this is easy to integrate ;-)
>>
>> Why would you put this in kernel? The code will (AFAIK) only serve
>> candump. That's why I proposed to put it there in the first place.
> There is more in the world than just candump! In fact my Node extension for
> SocketCAN (https://github.com/sebi2k1/node-can) exposes the filter interface
> to the user as well. It is simply not fast enough to do it in Javascript.
> Furthermore I think filtering the message already in the kernel has also an
> performance advantage (especially on low-budget embedded Linux system).
> 
> IMHO the current implementation is just broken. I don't care for the internals
> of the filter mechanism but generating ghost message is simply wrong.
> 
> I like the proposal of Oliver, just because I can then also use AND filters
> and not just OR now.

Probably we can reduce the changes by providing AND concatenations of inverted
filters only.

This is a requirement i've seen more often so far.

> 
> I still dont understand why I receive the same CAN message twice just because
> the filter matched? Can someone explain the logic behind that?
> 

You added two independent filters, both matching 0x1FF.

When you invoke this:

candump vcan0,100~7ff,101~7ff,000:000

you will get the CAN frame with the CAN ID 1FF three times.

Clearly now?

Regards,
Oliver

