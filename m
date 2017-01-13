From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 15:27:40 +0100
Message-ID: <4df716fe-9b72-e2c4-1067-f72586d71502@hartkopp.net>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
 <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:20597 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbdAMO15 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 09:27:57 -0500
In-Reply-To: <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>



On 01/13/2017 12:45 PM, Stephane Grosjean wrote:
>
> Le 12/01/2017 à 17:30, Oliver Hartkopp a écrit :
>> On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
>>
>>> There's one potential fix by setting something like an "ECHO" bit to any
>>> transmitted frame; The driver rx path will be able to distinguish
>>> between these "echoed" frames and the - application - "looped back"
>>> frames, so that the rx stats will be ok.
>>
>> That would be cool!
>> I remember discussing about a good echo functionality with Philipp.
>> Can you also pass some extra data along with the CAN frame down to the
>> controller (e.g. to carry an index into the echo skb table?).
>>
>> Because even when you know that the received frame was echoed, you
>> need to got through your saved echo skb list to pick the oldest skb
>> for this interface/CAN-ID/mtu combination. This stored skb has to be
>> sent back into the system.
>>
>> Do not create a new skb for echo'ed skbs! See echo skb handling in dev.c
>>
>
> We all agree that the echo skbs array should not be a limitation in the
> tx flow, so this should be large enough to save the maximum number of
> CAN frames written, before being obliged to stop the network tx queue,
> right?
>
> In the case of this IP core, I'm able to write ~205 (0 data byte) CAN
> frames in the Tx DMA area. Do you see any problem to allocate such a
> large array in the can device context?

No. It's just a table of skb pointers. So it should be ok.

Regards,
Oliver

