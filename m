From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Thu, 19 Jan 2017 14:03:56 +0100
Message-ID: <e41b06fc-7ef9-48c0-7f9c-8fdc483f134c@peak-system.com>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <f87c4e7d-4e8a-6d0d-9063-86ce9d7347bb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:36418 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdASNEH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2017 08:04:07 -0500
In-Reply-To: <f87c4e7d-4e8a-6d0d-9063-86ce9d7347bb@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hello Marc,

Building my code onto a 32-bits machine:

Le 13/01/2017 à 12:38, Marc Kleine-Budde a écrit :
> On 01/11/2017 01:16 PM, Stephane Grosjean wrote:
>>   - every "#ifdef CONFIG_xxx" has been changed into "IS_ENABLED(CONFIG_xxx)"
>>

This change leads to the following code, as you suggested:

                 lk->laddr_lo = cpu_to_le32(page->lbase);

                 if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
                         lk->laddr_hi = cpu_to_le32(page->lbase >> 32);
                 else
                         lk->laddr_hi = 0;

*WITH*

struct pciefd_page {
         dma_addr_t lbase;               /* page logical address */
};

*BUT* building this code when CONFIG_ARCH_DMA_ADDR_T_64BIT is not 
defined (neither Y nor M), that is, on a 32-bits machine I suppose, 
generates the following warning:

drivers/net/can/peak_canfd/peak_pciefd_main.c:532:43: warning: right 
shift count >= width of type [-Wshift-count-overflow]
     lk->laddr_hi = cpu_to_le32(page->lbase >> 32);

which is obviously true, since "dma_addr_t" is here a 32-bits width type.

So, in that case, I don't see any other way to fix, than using the (old) 
#ifdef CONFIG_xxx style, present in v2.

Your opinion, please?

Stéphane.
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--
