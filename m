From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 10:09:30 +0100
Message-ID: <c05c554a-c76c-f6d0-7327-f459d807ab3e@hartkopp.net>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <3117407.TP9DfUe48K@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:19022 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdCPJJf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 05:09:35 -0400
In-Reply-To: <3117407.TP9DfUe48K@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org



On 16.03.2017 10:06, Alexander Stein wrote:
> On Thursday 16 March 2017 09:34:38, Marc Kleine-Budde wrote:
>> On 03/16/2017 09:01 AM, Oliver Hartkopp wrote:
>>> On 13.03.2017 10:47, Marc Kleine-Budde wrote:
>>>> On 03/13/2017 07:54 AM, Alexander Stein wrote:
>>>>>> @Marc: What was the reason to implement NAPI that days? Has it ever
>>>>>> been
>>>>>> proved that NAPI had a remarkable positive effect in opposite to a
>>>>>> direct CAN frame processing in the interrupt context?
>>>>>
>>>>> One reason to use NAPI is out-of-order issues on SMP systems :-( You
>>>>> know the problem: http://marc.info/?l=linux-can&m=143642135416355&w=2
>>>>> If this is not resolved, things get even worse.
>>>>> Well, now that there is generic FIFO-offload feature (drivers may need
>>>>> changes to use it) there is an easy way to read CAN frames with low
>>>>> latency while processing them in non-IRQ context.
>>>>> IMHO reading CAN frames in softirq (NAPI) may be too late in some cases,
>>>>> in RT kernels this may be even worse.
>>>>
>>>> ACK.
>>>
>>> Would then implementing CAN rx-offload on all(!) CAN drivers fix the
>>> NAPI-too-late and the out-of-order issue?
>>
>> Implementing rx-offload on the drivers using NAPI, will fix the
>> NAPI-too-late issue (and turn it into a IRQ too late issue).
>>
>> Implementing rx-offload on the drivers passing skbs in the IRQ handler
>> will probably fix the out-of-order issue.
>>
>> I'm not sure if the USB and SPI drivers are affected by the out-of-order
>> issue.
>
> IMO all drivers using netif_rx (IRQ context) rather han netif_receive_skb
> (NAPI poll context) are suffering from out-of-order issue. And I guess every
> USB CAN driver is using netif_rx in the URB callback function, which is
> essentially IRQ context. MCP2512 uses netif_rx_ni instead, dunno what is the
> actual difference to netif_rx.
>
> Let's see if I get time to cook rx-offload on a USB driver.

That would be highly appreciated :-)

Best regards,
Oliver

