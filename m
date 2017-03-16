From: Efim Monjak <emonjak@lipowsky.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 11:06:20 +0100
Message-ID: <c7299ea9-3651-1519-f067-2792fe02b63c@lipowsky.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
 <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server1.railshosting.de ([5.45.177.35]:33382 "EHLO
        server1.railshosting.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdCPKIC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 06:08:02 -0400
In-Reply-To: <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

Am 16.03.2017 um 10:32 schrieb Marc Kleine-Budde:
> On 03/16/2017 10:24 AM, Efim Monjak wrote:
>>>> Would then implementing CAN rx-offload on all(!) CAN drivers fix the
>>>> NAPI-too-late and the out-of-order issue?
>>> Implementing rx-offload on the drivers using NAPI, will fix the
>>> NAPI-too-late issue (and turn it into a IRQ too late issue).
>> It seems the napi in AT91 driver is called from CAN ISR. In this case
>> here are both issues.
> NAPI is supposed to be activated once you get an interrupt. But the
> actual read of the messages and putting it into the networking stack is
> done in NAPI, which comes after the IRQ.

Yes using of napi contains both issues NAPI-too-late and IRQ-too-late.

>
>>> Implementing rx-offload on the drivers passing skbs in the IRQ handler
>>> will probably fix the out-of-order issue.
>> Were possible by rx-offload implementing make skbs no such memory
>> wasting for CAN data?
> I'm not sure if I understand your question correctly. In CAN you need
> still one skb for each CAN frame.
>
> Marc
>

Yes an skb contains one CAN frame. As I have written early socket show 
me receive buffer
is about 163000 bytes. After overflow 320 CAN frames are read from 
socket. I think
receive buffer is full in this case. If no place in receive buffer is 
used for other proposes
163000bytes/320 skbs with CAN frames make about 500 bytes/skb.
Linux show CAN MTU is 16 byte big.
What I mean: need an skb about a half of kbyte to contain 16 bytes?
Sure skbs are parts of list but do they need this all memory?


Regards,
Efim

