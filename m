From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/sja1000: Add miniPCIe/cPCI PC/104Plus PCI/104e PEAK-System
 boards
Date: Tue, 23 Oct 2012 18:56:22 +0200
Message-ID: <5086CC36.8040006@hartkopp.net>
References: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:30202 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230Ab2JWQ4X (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Oct 2012 12:56:23 -0400
In-Reply-To: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

nice to see things are going on :-)

Btw. Marc and Wolfgang mainly should be addressed for this driver.

Maybe Marc should 'tune' the commit message to

can/peak_pci: Add/fix PCI IDs for miniPCIe/cPCI PC/104Plus PCI/104e cards

which hits the point and will generate no remarks - even if it goes into the
netdev tree in the 3.7-rc phase.

Anyway you can get a

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

:-)

Tnx,
Oliver

On 23.10.2012 12:37, Stephane Grosjean wrote:

> This patch adds the support for 4 new PCI boards based on the SJA1000 CAN
> controller, from PEAK-System Technik:
> 
> . PCAN-miniPCIe (PCI-Express Mini slots, available as single or dual-channel)
> . PCAN-cPCI (CompactPCI format, available as single or dual-channel)
> . PCAN-PC/104-Plus (PC/104-Plus system, av. as 1, 2 or 4 channels)
> . PCAN-PCI/104-Express (PCI/104-Express system, av. as 1 or 2 channels)
> 
> This patch also fixes a typo in existing "PEAK_MPCI_DEVICE_ID" identifier
> (missing "E" for Express). Finally, it also adds another author as well as it
> updates the module supported devices list.
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---


