From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] CAN FD support
Date: Thu, 03 May 2012 14:43:52 +0200
Message-ID: <4FA27D88.8040401@grandegger.com>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com> <4FA26F65.5020804@hartkopp.net> <4FA275C1.4080905@grandegger.com> <20120503121833.GC416@vandijck-laurijssen.be> <4FA27C3C.8010806@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36059 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab2ECMny (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 08:43:54 -0400
In-Reply-To: <4FA27C3C.8010806@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/03/2012 02:38 PM, Oliver Hartkopp wrote:
> On 03.05.2012 14:18, Kurt Van Dijck wrote:
> 
>> On Thu, May 03, 2012 at 02:10:41PM +0200, Wolfgang Grandegger wrote:
>>> On 05/03/2012 01:43 PM, Oliver Hartkopp wrote:
>>>> On 03.05.2012 13:34, Wolfgang Grandegger wrote:
>>>>
>>>>>> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
>>>>>> index ea2d942..bddbafb 100644
>>>>>> --- a/drivers/net/can/vcan.c
>>>>>> +++ b/drivers/net/can/vcan.c
>>>>>> @@ -74,9 +74,8 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>>>>>>  	struct net_device_stats *stats = &dev->stats;
>>>>>>  
>>>>>>  	stats->rx_packets++;
>>>>>> -	stats->rx_bytes += cf->can_dlc;
>>>>>> +	stats->rx_bytes += can_dlc2len(cf->can_dlc);
>>>>>
>>>>> Hm, I think "cf->can_dlc" should contain the *real* length. That would
>>>>> simplify things a lot. The conversion is done when the corresponding DLC
>>>>> registers are read or written.
>>>>
>>>>
>>>> I thought about this idea some time too.
>>>>
>>>> My problem was that 'can_dlc' says
>>>>
>>>> "CAN data length *code*"
>>>>
>>>> And the dlc for CAN is already well defined.
>>>>
>>>> >From a todays view cf->len would indeed be a better expression :-/
>>>
>>> Yes, definitely.
>>>
>>>>
>>>> We could generally think about a union of 'can_dlc' and 'len' though, where
>>>> can_dlc would not be part of struct canfd_frame but only the len value.
>>>
>>> Well, we do not need dlc in the struct, just len. The conversion
>>> len->dlc needs just to be done once when register is read/written.
>>>
>>>> As you can see here, i also had the idea of providing both values:
>>>>
>>>> https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next/commit/dc730b789cc1a6a3c04aaacde02c6a5a81988869
>>>>
>>>> But is was a bad design, as you have two APIs modifying one value - you
>>>> never know what to trust ... it was a sanity check hell.
>>>
>>> If "cf->can_dlc", or however it is named, does not contain the real
>>> length, we will end up in a dlc2len conversion nightmare. Be aware the
>>
>> I share this.
>> I'd even prefer u16 over u8 even.
>> No legacy issues exist when changing the meaning of can_dlc, since current
>> CAN frames have equal values for DLC & length!
>>
>>> the struct is also used by the app.
> 
> 
> Yes - that's the main problem IMO.

Furthermore, the user should be allowed to specify *any* lenght below
max, als 57 bytes. It's than up to the driver to do the necessary padding.

> 
> What about this binary compatible introduction of cf->len ...

Looks good.

Wolfgang.
