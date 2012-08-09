From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: [softing] CAN-AC PCI card
Date: Thu, 9 Aug 2012 23:28:17 +0200
Message-ID: <20120809212817.GA3194@vandijck-laurijssen.be>
References: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:63989 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753544Ab2HIV2W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Aug 2012 17:28:22 -0400
Content-Disposition: inline
In-Reply-To: <trinity-fd24c49d-69e3-4dee-9d03-b9b8ac39f610-1344523228553@3capp-webde-bs20>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernhard Thiele <bernhard-thiele@web.de>
Cc: linux-can@vger.kernel.org

On Thu, Aug 09, 2012 at 04:40:28PM +0200, Bernhard Thiele wrote:
> Hello,
> 
> I wonder if anyone could give me an answer
> whether there is way to get the Softing-AC PCI card
> running with the current code base.

without modification, no.
> 
> The card has an SJA1000 chip that seems to be
> supported by linux-can for some devices.
> However, for Softing devices I've only found support
> for the Softing PCMCIA cards in the source tree.

The softing device is an 'intelligent' CAN device.
They use a CAN chip (mostly SJA1000) connected with a device CPU.
The host CPU must communicate with the device CPU
through dual port RAM.
> 
> Is there are a way to get a Softing-AC PCI card running with linux-can?

The dual port RAM interface is equal for PCI & PCMCIA devices.
The PCMCIA driver (softing_cs.ko) only provides a platform device with the dual port RAM
interface. And the real driver (softing.ko) uses this.
I designed the PCMCIA driver this way to allow for share code
with PCI cards. But I never got to writing the PCI driver
itself since I don't need it.

Adding the PCI driver should not be too hard.
This should be possible without touching existing code.
I may able to assist you with this.
> 
> Best regards,
> 
> Bernhard

Kind regards,
Kurt

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
