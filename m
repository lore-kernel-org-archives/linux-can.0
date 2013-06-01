From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: RFC: (optional) software filtering in candump
Date: Sat, 01 Jun 2013 20:35:02 +0200
Message-ID: <51AA3ED6.9010806@sebastianhaas.info>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51AA01F0.8020308@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:57752 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FASip (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Jun 2013 14:38:45 -0400
In-Reply-To: <51AA01F0.8020308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Sandro Anders | CarMediaLab <sandro.anders@carmedialab.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi all,

Am 01.06.2013 16:15, schrieb Oliver Hartkopp:
> Hi all,
>
> On 30.05.2013 17:37, Sebastian Haas wrote:
>> Am 30.05.2013 14:35, schrieb Kurt Van Dijck:
>>> On Thu, May 30, 2013 at 02:07:03PM +0200, Oliver Hartkopp wrote:
>>>> Am 30.05.2013 12:17, schrieb Kurt Van Dijck:
>>>>> On Thu, May 30, 2013 at 11:06:30AM +0200, Sebastian Haas wrote:
>>>>>> Am 30.05.2013 10:49, schrieb Oliver Hartkopp:
>>>>>>>>> On 29.05.2013 22:55, Sebastian Haas wrote:
>>>>>>>>>> If I start candump this way:
>>>>>>>>>> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>>>>>>>>>>    I want to receive any messages except 100h and 101h.
>>>>>>>>>>
>>>>>>>>>> When I send a message which matches the filter, it is received twice:
>>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>>>>>>>>>>     vcan0  1FF   [1]  22
>>>>>>>>>>     vcan0  1FF   [1]  22
>>>>>>>>>>
>>>>>>>>>> When I send a message which should not received at all, it is received:
>>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>>>>>>>>>>     vcan0  100   [1]  22
>>>>>>>>>>
>>>>>>>>>> Did I misunderstood the filter here?
>>>>>>>>>
>>>>>>>>> The filters are independent and therefore "logical OR".
>>>>>>>> Ok. That explain why received 100h even though I tried to filter it
>>>>>>>> out. But
>>>>>>>> why receive a message twice while it was only sent once?
>>>>>>>
>>>>>>> You have defined two(!) filters that let pass the CAN-ID 0x1FF.
>>>>>>>
>>>>>>> So what else would you expect?
>>>>>> This is actually the way it meant to be? Why? Honestly this is a bug
>>>>>> for me! The filter should stop when it matched and not going further
>>>>>> generating ghost messages which were never sent?
>>>>>
>>>>> I had initially the same feeling. The problem here IMHO is
>>>>> what the user expects is different from what the kernel does.
>>>>>
>>>>> What the user expects is a 'socket' based filter.
>>>>> The kernel implements an optimised, socket-agnostic filter.
>>>>> This is even more generic, but the kernel expects a CAN_RAW program
>>>>> to set 'rough' filters and have the fine control in the program.
>>>>>
>>>>> This actually works very good, and is a clever thing to do.
>>>>>
>>>>> However, candump does expose this kernel behaviour to the user. The user,
>>>>> as said, expects something different that what he gets.
>>>>> So the user thinks it is a bug.
>>>>>
>>>>> How to solve this: I think the correct way is to let candump
>>>>> expose the filtering that a user expects, whether in userspace
>>>>> or in kernelspace.
>>>>> Is such approach efficient? no. Does that matter? probably not.
>>>>> candump is, IMO, not an automation tool. It's an administrator/diagnostic
>>>>> tool.
>>>>>
>>>>> Although I have no real code in mind yet, I think the expected
>>>>> filtering is much easier to implement within a single program,
>>>>> than it would be in kernelspace.
>>>>>
>>>>> On the other hand, I have found candump's exposure of kernel work
>>>>> a true friend during development.
>>>>> So I'd vote to have an extra control on candump which filtering to use.
>>>>>
>>>>> Any thoughts?
>
> I used the last days to check different concepts and implementation ideas how
> to integrate another filter policy into the 'socket-agnostic' filters in
> af_can.c Kurt wrote this nice pleading about :-)
>
> It turned out that linked filters would become a mess in implementation and
> configuration (e.g. extensive locking / performance reduction). Additionally
> it would only make sense for a concatenation of inverted filters, like:
>
> 100~7FF,101~7FF,103~7FF
>
> Finally i dropped the idea to fiddle with the really efficient filters in
> af_can.c that follow the original idea of the CAN controller HW filters.
>
> The main drawback of the independent filters is that the user does not expect
> to get the same message several times due to the match of overlapping filters.
>
> Below you will find an approach that does not push this problem into
> userspace but only omits identical frames that had multiple matches.
>
> The idea is to introduce a new socket option CAN_RAW_FILTER_UNIQUE for the
> RAW socket, that catches and omits duplicate frames when it's enabled.
> This is a per-socket option and is active for all configured filters applied
> to this socket.
>
> It's a relatively small and clear change and it fixes your "bug".
>
> Here's the output of candump with and without the 'unique' option when
> invoking "cansend vcan0 1FF#" in another terminal:
>
> $ ./candump vcan0,100~7FF,101~7FF
>    vcan0  1FF   [0]
>    vcan0  1FF   [0]
>
> $ ./candump vcan0,100~7FF,101~7FF,U
>    vcan0  1FF   [0]
>
> I hope this fit your needs ?! :-)
Yes it does. It may not be a "clean" solution, but it fixes the issue.

Sebastian
