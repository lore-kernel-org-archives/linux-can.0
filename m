From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 1/2] mfd/janz-cmodio: fix MODULBus number sysfs entry
Date: Tue, 11 Sep 2012 15:58:14 -0700
Message-ID: <1347404295-7985-2-git-send-email-iws@ovro.caltech.edu>
References: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-can@vger.kernel.org, sameo@linux.intel.com, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: linux-can.vger.kernel.org

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

Revision 1.0 of the Janz CMOD-IO Carrier Board does not contain zeroes
in the top 4 bits of the modulbus_num (int_enable) register. Mask off
the unused bits so that the correct value is displayed in sysfs.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/mfd/janz-cmodio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/janz-cmodio.c b/drivers/mfd/janz-cmodio.c
index 2ea9998..32d0efd 100644
--- a/drivers/mfd/janz-cmodio.c
+++ b/drivers/mfd/janz-cmodio.c
@@ -216,7 +216,7 @@ static int __devinit cmodio_pci_probe(struct pci_dev *dev,
 	}
 
 	/* Read the hex switch on the carrier board */
-	priv->hex = ioread8(&priv->ctrl->int_enable);
+	priv->hex = ioread8(&priv->ctrl->int_enable) & 0x0f;
 
 	/* Add the MODULbus number (hex switch value) to the device's sysfs */
 	ret = sysfs_create_group(&dev->dev.kobj, &cmodio_sysfs_attr_group);
-- 
1.7.8.6
