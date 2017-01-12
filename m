From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Thu, 12 Jan 2017 12:40:48 +0100
Message-ID: <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:58631 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdALLk7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2017 06:40:59 -0500
In-Reply-To: <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 11/01/2017 à 21:11, Oliver Hartkopp a écrit :
>
>
> On 01/11/2017 01:16 PM, Stephane Grosjean wrote:
>> This patch adds the support of the PCAN-PCI Express FD boards made
>> by PEAK-System, for computers using the PCI Express slot.
>>
>> The PCAN-PCI Express FD has one or two CAN FD channels, depending
>> on the model. A galvanic isolation of the CAN ports protects
>> the electronics of the card and the respective computer against
>> disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operated
>> with ambient temperatures in a range of -40 to +85 °C.
>>
>> Such boards run an extented version of the CAN-FD IP running into USB
>> CAN-FD interfaces from PEAK-System, so this patch adds several new 
>> commands
>> and their corresponding data types to the PEAK CAN-FD common definitions
>> header file too.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>  v3:
>>  - remove unused flags field from struct pciefd_can
>>  - use memset() to reset 64-bits area instead of *(u64 *) cast
>>  - use dmam_alloc_coherent() and dmam_free_coheren()
>>  - state handling has been separated from err skb building
>>  - peak_canfd_start_xmit() now stops netif queue when there is not 
>> enough room
>>    left to save one more CANFD msgs in the Tx DMA pages (no CAN msg 
>> lost)
>>  - remove the IFF_ECHO flag from ndev flags (no tx-complete interrupt 
>> available)
>
> This is a really bad decision!
>
> It breaks use-cases where programmers need to know whether the CAN 
> frame really hit the bus. Without IFF_ECHO you fall back to low cost 
> CAN interfaces functionality e.g. with slcan protocol.
>
> Did you ask the CAN IP core designers whether they have a working 
> solution for this? Is the DMA mode the only way to write CAN frames to 
> the ucan core - or is there some sja1000-like mode too?
>
> Regards,
> Oliver

There's one potential fix by setting something like an "ECHO" bit to any 
transmitted frame; The driver rx path will be able to distinguish 
between these "echoed" frames and the - application - "looped back" 
frames, so that the rx stats will be ok.

One question comes to my mind: if I understand well, 'loopback' frames 
are read twice by application: once because of the ECHO mechanism, twice 
because the controller has looped-back it, right?

Regards,

Stéphane


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
