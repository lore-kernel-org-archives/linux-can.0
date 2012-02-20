From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH v6.1] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Mon, 20 Feb 2012 18:11:32 +0100
Message-ID: <4F427EC4.2010709@volkswagen.de>
References: <1329736262-21095-1-git-send-email-s.grosjean@peak-system.com> <4F423BD8.3090302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:50901 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab2BTRLi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 12:11:38 -0500
In-Reply-To: <4F423BD8.3090302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Am 20.02.2012 13:26, schrieb Marc Kleine-Budde:
> On 02/20/2012 12:11 PM, Stephane Grosjean wrote:
>> This patch adds the support for the following 3x sja1000 based PCI cards
>> from PEAK-System Technik (www.peak-system.com):
>>
>> PCAN-PCI Express (1 or 2 channels)
>> PCAN-ExpressCard (1 or 2 channels)
>> PCAN-miniPCI (1 or 2 channels)
>>
>> The PCAN-ExpressCard card needs I2C bit-banging interface, so it must be
>> explicitly selected. Doing this automatically selects I2C and I2C_ALGOBIT
>> bit-banging kernel configuration options.
>>
>> Signed-off-by: Stephane Grosjean<s.grosjean@peak-system.com>
>> Acked-by: Wolfgang Grandegger<wg@grandegger.com>
> Oliver can you find time to check if the i2c problem is gone? I think
> we've still have time to get this patch into the next kernel release.

I'm currently on a business trip in Bruxelles ... i'll try to test it on 
Wednesday/Thursday ASAP.

Regards,
Oliver

