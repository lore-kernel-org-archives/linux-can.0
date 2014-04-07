From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 16:27:30 +0200
Message-ID: <1589068.2zsYHU9sGb@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <8704553.bJQG1oassy@ws-stein> <alpine.DEB.2.02.1404071524550.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:43363 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754760AbaDGO2n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 10:28:43 -0400
In-Reply-To: <alpine.DEB.2.02.1404071524550.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 07 April 2014 15:31:20, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
> > On Monday 07 April 2014 14:56:19, Thomas Gleixner wrote:
> > > On Mon, 7 Apr 2014, Alexander Stein wrote:
> > > 
> > > > Hello Thomas,
> > > > 
> > > > On Monday 07 April 2014 14:34:17, Thomas Gleixner wrote:
> > > > > > I'm currently trying to locate problem causes. Using your new set of patches on the tag linux-can-fixes-for-3.15-20140401 I lot of lost messages.
> > > > > > Using bisect it seems that c0a9f4d39 "can: c_can: Reduce register access" introduced this problem on my hardware. Before that I only see switched messages occasionally.
> > > > > > 
> > > > > 
> > > > > Does the last patch which disables the RX buffer split still have that
> > > > > issue?
> > > > 
> > > > Regardless of CAN_C_CAN_STRICT_FRAME_ORDERING I'm still losing messages.
> > > > BTW: I need the following patch to be able to use CAN_C_CAN_STRICT_FRAME_ORDERING:
> > > 
> > > Grr. True.
> > > 
> > > So if you disable CAN_C_CAN_STRICT_FRAME_ORDERING you still lose frames?
> > 
> > Yep, even on the commits before. But not from commit c0a9f4d39 on backwards.
> 
> That's weird. With c0a9f4d39 and the CAN_C_CAN_STRICT_FRAME_ORDERING=n
> we use the message buffers as recommended by the C_CAN spec. i.e.:
> 
> We transfer the message object to the buffer and clear intpnd/newdat
> right away.
> 
> What other patches do you have applied?

I have shrinked them a bit to the absolute necessity. In general these are patches for the current hardware to make them working.

$ git diff --stat linux-can-fixes-for-3.15-20140401..
 drivers/i2c/busses/i2c-eg20t.c                          |   2 +-
 drivers/net/can/c_can/Kconfig                           |   7 +++++
 drivers/net/can/c_can/c_can.c                           | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------
 drivers/net/can/c_can/c_can.h                           |   3 +-
 drivers/net/can/c_can/c_can_pci.c                       |  57 +++++++++++++++++++++++++++++++++++--
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h         |   1 +
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_api.c     |   6 ++--
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_ethtool.c |   9 ------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c    |  52 +++++++++++++++++++---------------
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.c     |   5 ++--
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_phy.h     |   1 -
 11 files changed, 234 insertions(+), 179 deletions(-)

$ git log --pretty=oneline linux-can-fixes-for-3.15-20140401..
40e2d2611b1341b26da5d0737668149609cc4ee3 Fix for can: c_can: Disable rx buffer split to prevent packet loss
45bf957f441fba3e424df59e2b5509fea13962d2 can: c_can: Disable rx buffer split to prevent packet loss
307678e593427826a4861109d0660989c024311f can: c_can: Get rid of pointless interrupts
3bef0e7bd01061899b906eade6d48499c63fb1c6 can: c_can: Avoid status register update for D_CAN
7ba15b9b59dc4d054e2344bee21707de3ee02bac can: c_can: Simplify buffer reenabling
0bb9ed221ed66787cbe9cecfa3eca394ddaf9548 can: c_can: Always update error stats
747462543ce1df21412e05f2daf86a8b68c36d3b can: c_can: Fix berr reporting
d60f488923998eb8e250260323e63438ab465cf9 can: c_can: Handle state change correctly
4c2030a6a955ae530ea32ce1e0ef3fdc8acbc445 can: c_can: Do not access skb after net_receive_skb()
144829bcfbbe97f4eab4b17f922d6d4b39027540 can: c_can: Make bus off interrupt disable logic work
8449454bf4a33ea5bf5aca2e896717459e428c2b can: c_can: Fix startup logic
fcbd69d2d869cb0c55c035d36cd6795251fd01da c_can_pci: enable PCI bus master only for MSI
53b385c37e4eb155cf9d515913ddf76750e2ac24 c_can: Add support for eg20t (pch_can)
95bf9c0f276925e401ac7d3c6ff47185b9badd2f pch_gbe: remove shutdown and restart of interface after PHY settings change
7229aafbce39e22c82544d7021dccd6b0c23f881 pch_gbe: reset PHY before first configuration
9fd3c55d07a41bc18931ec6a51176cbf667dbe21 pch_gbe: remove unnecessary PHY resets
c80898c56b575baa1ce2dcfbcaa6c654194f5cf8 pch_gbe: change order of PHY address discovering
c97bfddb0cf93c3ca0cb79490ab602b4ab24a740 pch_gbe: Add module parameter for RGMII/GMII PHY mode selection
f09f76391c8a90814fd78cfced35fceb616ea7e3 pch_gbe: print invalid MAC address during probe
14ab44191d17390be4fa2683092b8913a8b34a17 i2c-eg20t: Try to add busses starting from bus number 1

Regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

