From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Wed, 05 Dec 2012 13:09 +0100
Message-ID: <2955657.EIGT0HjrVV@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:45140 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752351Ab2LEMJF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 07:09:05 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang and others,

On Thursday 29 November 2012 15:39:40, Wolfgang Grandegger wrote:
> here is v2 of my patches for the C_CAN drivers.
> 
> For Michael I have prepared out-of-tree driver sources allowing to
> easily build the drivers also for older 3.x kernel versions. More
> tester are welcome.
> 
> Changes since v1:
> 
> - use init callback after renaming it from initram
> - use different sets of interface registers for rx and tx (like PCH_CAN)
> - use spin_[un]lock_bh to protect the tx objects
> 
> Wolfgang Grandegger (7):
>   pch_can: add spinlocks to protect tx objects
>   c_can: rename callback "initram" to "init" to more general usage
>   c_can: use different sets of interface registers for rx and tx
>   c_can_pci: introduce board specific PCI bar
>   c_can_pci: enable PCI bus master only for MSI
>   c_can_pci: add support for PCH CAN on Intel EG20T PCH
>   c_can: add spinlock to protect tx and  objects
> 
>  drivers/net/can/c_can/c_can.c          |   66 
+++++++++++++++++++++-----------
>  drivers/net/can/c_can/c_can.h          |    3 +-
>  drivers/net/can/c_can/c_can_pci.c      |   56 +++++++++++++++++++++++++--
>  drivers/net/can/c_can/c_can_platform.c |    2 +-
>  drivers/net/can/pch_can.c              |    9 +++++
>  5 files changed, 108 insertions(+), 28 deletions(-)

I backported the c_can patches incl. your patchset to v3.0.31 and tested this 
driver on our own custom atom board using the eg20t pch. CAN in general works, 
but if I run my heavy CAN load testcase I get errors sometimes.
This test works as follows: I send a CAN message to 2 other CAN nodes 
configuring some timings (like burst length or time between each can frame) 
and they send 250000 messages each containing a counter. This way I can detect 
any missing or switched message with a high bus load.
If I use the described software state alone it works, but if I run 'watch 
sensors' in a different ssh session, CAN start to misbehave like missing CAN 
frames or switched order. It seems that I2C usage on the PCH influences the 
CAN part also:(
Even worse, if I use the following patch to check if PCI writes were 
successfully, I notices that some writes (or the consecutive read) don't 
succeed. And I also get lots of I2C timeouts waiting for a xfer complete.

Does anybody have an idea what's going wrong here? Is somebody able to see the 
same problems on their hardware?

Wolfgang: Compared to your v8 c_can drivers for Michael, I'm just missing the 
const bitrate table and don't use pci_register_driver, as I have cherry-picked 
the module_pci_driver patches.

Best regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can_pci.c 
b/drivers/net/can/c_can/c_can_pci.c
index 2516ea9..b124ea5 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -80,7 +80,13 @@ static u16 c_can_pci_read_reg_32bit(struct c_can_priv 
*priv,
 static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
                                      enum reg index, u16 val)
 {
+       u16 reg;
        iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+       reg = c_can_pci_read_reg_32bit(priv, index);
+       if (reg != val)
+       {
+               netdev_err(priv->dev, "write 0x%x to offset 0x%x failed. got: 
0x%x\n", val, 2 * priv->regs[index], reg);
+       }
 }
 
 static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)
