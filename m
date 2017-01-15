From: Selina Schuler <Selina.Schuler@gmx.de>
Subject: peak_pci and DMA
Date: Sun, 15 Jan 2017 21:39:00 +0100
Message-ID: <87527bfb-a1d3-5d3c-2d7b-becd4b82dcba@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56232 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdAOUjE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 15 Jan 2017 15:39:04 -0500
Received: from [192.168.178.30] ([92.212.20.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mfn88-1c7sFl0oZI-00NAYh for
 <linux-can@vger.kernel.org>; Sun, 15 Jan 2017 21:39:01 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

as part of my bachelor thesis I've been looking into the peak_pci device 
driver and socketCan this week. In particular I want to know if the 
driver uses DMA. To me it seems like the peak_pci and sja1000 drivers 
don't use DMA or at least not the DMA-API. Is this correct or am I 
missing something?

And while following the list for the last few days this caught my eye in 
the discussion about the added support for PEAK PCAN-PCIe FD CAN-FD boards:

"Is the DMA mode the only way to write CAN frames to the ucan core - or 
is there some sja1000-like mode too?"

Is this sja1000-like mode the PeliCAN mode and does this actually mean, 
that DMA and sja1000 exlude each other?

I'm sorry if this questions seem too basic but I'm still trying to wrap 
my head around this and appreciate any feedback.


Thanks and best regards,
Selina
