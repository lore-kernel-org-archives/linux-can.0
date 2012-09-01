From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Truncate DLC to 8 instead of dropping?
Date: Sat, 01 Sep 2012 21:27:48 +0200
Message-ID: <504261B4.4090107@hartkopp.net>
References: <20120831115904.GB2624@pengutronix.de> <20120831125021.GB1191@vandijck-laurijssen.be> <5040E7C2.4040305@hartkopp.net> <20120901173313.GA9656@pengutronix.de> <20120901181106.GA425@vandijck-laurijssen.be> <20120901181757.GC9656@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:54660 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab2IAT1w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Sep 2012 15:27:52 -0400
In-Reply-To: <20120901181757.GC9656@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kurt Van Dijck <kurt.van.dijck@eia.be>

On 01.09.2012 20:17, Wolfram Sang wrote:

> On Sat, Sep 01, 2012 at 08:11:06PM +0200, Kurt Van Dijck wrote:
>> On Sat, Sep 01, 2012 at 07:33:13PM +0200, Wolfram Sang wrote:
>>> On Fri, Aug 31, 2012 at 06:35:14PM +0200, Oliver Hartkopp wrote:
>>>> Hello Kurt and Wolfram,
>>>>
>>>> On 31.08.2012 14:50, Kurt Van Dijck wrote:
>>>>
>>>>> On Fri, Aug 31, 2012 at 01:59:04PM +0200, Wolfram Sang wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I just noticed today that commit c7cd606f60e7679c7f9eee7010f02a6f000209c1
>>>>>> ("can: Fix data length code handling in rx path") says regarding
>>>>>> overlong packets:
>>>>>>
>>>>>> ===
>>>>>>
>>>>>> The ISO 11898-1 Chapter 8.4.2.3 (DLC field) says that register values > 8
>>>>>> should be reduced to 8 without any error reporting or frame drop.
>>>>>>
>>>>>> ===
>>>>>>
>>>>>> and this is why get_can_dlc() came into existance.
>>>>>>
>>>>>> However, functions like can_dropped_invalid_skb() from dev.h or can_rcv() from
>>>>>> af_can.c do check for a correct length, but drop the packet in the error case.
>>>>>> Don't those need to be fixed?
>>>>>>
>>>>>
>>>>> Interesting point. My first idea is to acknowledge your thinking, BUT:
>>>>> * ISO 11898-1 is about the wire format, whereas your issues address
>>>>>   higher level interfaces. Higher level interfaces may IMHO use a stricter
>>>>>   format that the wire format.
>>>>
>>>>
>>>> Pointing to the wire format is a good idea.
>>>> To me this "dlc error ignoring" requirement is implemented by the CAN
>>>> controller. And when the dlc value in the controller register is not sanitized
>>>> we should do it on driver level.
>>>
>>> If I understand both of you correctly, that means the checks in the
>>> functions I mentioned should be removed then?
>>
>> Not completely IMHO. The check in the recv path should not be necessary.
> 
> OK. I only meant the rx path.
> 


The check on driver level should not be removed. Both the driver and the
network layer should do it's own checks.

Think about people using PF_PACKET sockets to access CAN netdevices.
When you are able to put "userspace garbage" directly into CAN netdevices via
PF_PACKET you need checks for rx/tx sanity in the driver.

Regards,
Oliver
