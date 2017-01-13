From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 15:29:19 +0100
Message-ID: <5614d323-5047-b2d6-592a-0f8a09963e73@peak-system.com>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
 <db248428-c8e8-17ea-20fe-4b8a6548a120@pengutronix.de>
 <bb5c202b-2b8e-8f58-78e0-0027d127b0c1@peak-system.com>
 <b08748c4-ff55-2d7f-ae60-2534e4ac1c0c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:60796 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbdAMO3a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 09:29:30 -0500
In-Reply-To: <b08748c4-ff55-2d7f-ae60-2534e4ac1c0c@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 13/01/2017 à 15:25, Marc Kleine-Budde a écrit :
> On 01/13/2017 03:08 PM, Stephane Grosjean wrote:
>> Le 13/01/2017 à 14:15, Marc Kleine-Budde a écrit :
>>> On 01/13/2017 12:45 PM, Stephane Grosjean wrote:
>>>> Le 12/01/2017 à 17:30, Oliver Hartkopp a écrit :
>>>>> On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
>>>>>
>>>>>> There's one potential fix by setting something like an "ECHO" bit to any
>>>>>> transmitted frame; The driver rx path will be able to distinguish
>>>>>> between these "echoed" frames and the - application - "looped back"
>>>>>> frames, so that the rx stats will be ok.
>>>>> That would be cool!
>>>>> I remember discussing about a good echo functionality with Philipp.
>>>>> Can you also pass some extra data along with the CAN frame down to the
>>>>> controller (e.g. to carry an index into the echo skb table?).
>>>>>
>>>>> Because even when you know that the received frame was echoed, you
>>>>> need to got through your saved echo skb list to pick the oldest skb
>>>>> for this interface/CAN-ID/mtu combination. This stored skb has to be
>>>>> sent back into the system.
>>>>>
>>>>> Do not create a new skb for echo'ed skbs! See echo skb handling in dev.c
>>>>>
>>>> We all agree that the echo skbs array should not be a limitation in the
>>>> tx flow, so this should be large enough to save the maximum number of
>>>> CAN frames written, before being obliged to stop the network tx queue,
>>>> right?
>>>>
>>>> In the case of this IP core, I'm able to write ~205 (0 data byte) CAN
>>>> frames in the Tx DMA area. Do you see any problem to allocate such a
>>>> large array in the can device context?
>>> You probably want to limit the on-the-fly TX frames to a sensible
>>> number, as it may introduce latencies.
>> I first certainly want to set some correct and acceptable value! ;-)
>>
>> IMHO, the question is "how many frames can be written before getting the
>> Rx interrupt corresponding to the 1st echoed frame". And since this is
>> cpu dependent, I haven't got any other indication for this number than
>> the above (and too large) estimated maximum value. Any suggestion would
>> be welcome...
> Something between like 16 or 32? That's what SoC typically have.

Doh! We both had the same ones! ;-)

Thanks!

Stéphane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
