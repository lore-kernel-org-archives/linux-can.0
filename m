From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 2/2] can: janz-ican3: fix support for older hardware revisions
Date: Tue, 11 Sep 2012 15:58:15 -0700
Message-ID: <1347404295-7985-3-git-send-email-iws@ovro.caltech.edu>
References: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-can@vger.kernel.org, sameo@linux.intel.com, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: linux-can.vger.kernel.org

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Revision 1.0 Janz CMOD-IO Carrier Board does not have support for
the reset registers. To support older hardware, the code is changed to
use the hardware reset register on the Janz VMOD-ICAN3 hardware itself.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/net/can/janz-ican3.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 98ee438..7edadee 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1391,7 +1391,6 @@ static irqreturn_t ican3_irq(int irq, void *dev_id)
  */
 static int ican3_reset_module(struct ican3_dev *mod)
 {
-	u8 val = 1 << mod->num;
 	unsigned long start;
 	u8 runold, runnew;
 
@@ -1405,8 +1404,7 @@ static int ican3_reset_module(struct ican3_dev *mod)
 	runold = ioread8(mod->dpm + TARGET_RUNNING);
 
 	/* reset the module */
-	iowrite8(val, &mod->ctrl->reset_assert);
-	iowrite8(val, &mod->ctrl->reset_deassert);
+	iowrite8(0x00, &mod->dpmctrl->hwreset);
 
 	/* wait until the module has finished resetting and is running */
 	start = jiffies;
-- 
1.7.8.6
