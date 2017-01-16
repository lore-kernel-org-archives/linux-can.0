From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci and DMA
Date: Mon, 16 Jan 2017 10:44:41 +0100
Message-ID: <880086f5-fec7-680a-dc44-888597e59358@peak-system.com>
References: <87527bfb-a1d3-5d3c-2d7b-becd4b82dcba@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:37307 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdAPJou (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2017 04:44:50 -0500
In-Reply-To: <87527bfb-a1d3-5d3c-2d7b-becd4b82dcba@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Selina Schuler <Selina.Schuler@gmx.de>
Cc: linux-can@vger.kernel.org

Hello,


Le 15/01/2017 à 21:39, Selina Schuler a écrit :
> Hello,
>
> as part of my bachelor thesis I've been looking into the peak_pci 
> device driver and socketCan this week. In particular I want to know if 
> the driver uses DMA. To me it seems like the peak_pci and sja1000 
> drivers don't use DMA or at least not the DMA-API. Is this correct or 
> am I missing something?

Nope: the peak_pci driver doesn't use any DMA access, but memory mapped 
IO. I don't know if it does exist any DMA -based implementation of the 
SJA1000 controller...

>
> And while following the list for the last few days this caught my eye 
> in the discussion about the added support for PEAK PCAN-PCIe FD CAN-FD 
> boards:
>
> "Is the DMA mode the only way to write CAN frames to the ucan core - 
> or is there some sja1000-like mode too?"

DMA is used to exchange data between the IP core running the PCAN-PCIe 
FD boards and the host. This is the only way to dialog with. The main 
difference between the SJA100-like controllers based adapters and this 
kind of mechanism is that large memory buffers can be used to exchange 
data, rather than "simple" IO registers.

>
> Is this sja1000-like mode the PeliCAN mode and does this actually 
> mean, that DMA and sja1000 exlude each other?

Basically both are CAN controllers but with some different API. PeliCAN 
mode is a SJA1000 concept only.

>
> I'm sorry if this questions seem too basic but I'm still trying to 
> wrap my head around this and appreciate any feedback.
>

There is no basic question.

>
> Thanks and best regards,

Regards,

Stéphane

> Selina
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
