From: Efim Monjak <emonjak@lipowsky.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 10:24:18 +0100
Message-ID: <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server1.railshosting.de ([5.45.177.35]:47791 "EHLO
        server1.railshosting.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdCPJ0V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 05:26:21 -0400
In-Reply-To: <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Am 16.03.2017 um 09:34 schrieb Marc Kleine-Budde:
> On 03/16/2017 09:01 AM, Oliver Hartkopp wrote:
>> On 13.03.2017 10:47, Marc Kleine-Budde wrote:
>>> On 03/13/2017 07:54 AM, Alexander Stein wrote:
>>>>> @Marc: What was the reason to implement NAPI that days? Has it ever been
>>>>> proved that NAPI had a remarkable positive effect in opposite to a
>>>>> direct CAN frame processing in the interrupt context?
>>>> One reason to use NAPI is out-of-order issues on SMP systems :-( You know the
>>>> problem: http://marc.info/?l=linux-can&m=143642135416355&w=2
>>>> If this is not resolved, things get even worse.
>>>> Well, now that there is generic FIFO-offload feature (drivers may need changes
>>>> to use it) there is an easy way to read CAN frames with low latency while
>>>> processing them in non-IRQ context.
>>>> IMHO reading CAN frames in softirq (NAPI) may be too late in some cases, in RT
>>>> kernels this may be even worse.
>>> ACK.
>> Would then implementing CAN rx-offload on all(!) CAN drivers fix the
>> NAPI-too-late and the out-of-order issue?
> Implementing rx-offload on the drivers using NAPI, will fix the
> NAPI-too-late issue (and turn it into a IRQ too late issue).

It seems the napi in AT91 driver is called from CAN ISR. In this case 
here are
both issues.

> Implementing rx-offload on the drivers passing skbs in the IRQ handler
> will probably fix the out-of-order issue.

Were possible by rx-offload implementing make skbs no such memory 
wasting for CAN
data?


> I'm not sure if the USB and SPI drivers are affected by the out-of-order
> issue.
>
> Marc
>

Regards,
Efim

