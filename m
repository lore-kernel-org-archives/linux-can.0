From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/2] can/peak_pci: add support of some new PEAK-System
 PCI cards
Date: Thu, 01 Mar 2012 18:18:22 +0100
Message-ID: <4F4FAF5E.3070605@hartkopp.net>
References: <1330357923-14080-1-git-send-email-s.grosjean@peak-system.com> <4F4FADF0.3070401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:56742 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab2CARSd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Mar 2012 12:18:33 -0500
In-Reply-To: <4F4FADF0.3070401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

On 01.03.2012 18:12, Marc Kleine-Budde wrote:

> On 02/27/2012 04:52 PM, Stephane Grosjean wrote:
>> This patch adds the support of some new PEAK-System PCI cards in the CAN
>> network sub-system. These are:
>>
>> PCAN-PCIeC (PCI-ExpressCard)
>> PCAN-mminiPCI (mini-PCI)
>> PCAN-PCI (PCI next-gen)
>>
>> This patch also adds the control of the blinking leds of the PCAN-PCIeC.
>>
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>  Note: that patch contains modifications tested and approved in
>>        peak_pci v6.1 but also includes Kconfig and Makefile modifications
>>        from peak_pcmcia v4.1
>>

> 
> Sorry, that series is not bisectable. At least if you switch on the
> CONFIG_CAN_PEAK_PCMCIA option.
> 


Is this due to the fact that the both Kconfig entries are placed in the first
file?

I asked myself, why this was optimized in this way. IMO adding

1. PCIEC support
2. PCMCIA support

within two patches would be better, right?

Regards,
Oliver
