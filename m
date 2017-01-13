From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 12:45:11 +0100
Message-ID: <50f5c95a-9978-9b08-8c82-4d3731a6601e@peak-system.com>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
 <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:54527 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdAMLpV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 06:45:21 -0500
In-Reply-To: <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>


Le 12/01/2017 à 17:30, Oliver Hartkopp a écrit :
> On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
>
>> There's one potential fix by setting something like an "ECHO" bit to any
>> transmitted frame; The driver rx path will be able to distinguish
>> between these "echoed" frames and the - application - "looped back"
>> frames, so that the rx stats will be ok.
>
> That would be cool!
> I remember discussing about a good echo functionality with Philipp.
> Can you also pass some extra data along with the CAN frame down to the 
> controller (e.g. to carry an index into the echo skb table?).
>
> Because even when you know that the received frame was echoed, you 
> need to got through your saved echo skb list to pick the oldest skb 
> for this interface/CAN-ID/mtu combination. This stored skb has to be 
> sent back into the system.
>
> Do not create a new skb for echo'ed skbs! See echo skb handling in dev.c
>

We all agree that the echo skbs array should not be a limitation in the 
tx flow, so this should be large enough to save the maximum number of 
CAN frames written, before being obliged to stop the network tx queue, 
right?

In the case of this IP core, I'm able to write ~205 (0 data byte) CAN 
frames in the Tx DMA area. Do you see any problem to allocate such a 
large array in the can device context?

Regards,

Stéphane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
