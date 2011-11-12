From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Sat, 12 Nov 2011 22:15:04 +0100
Message-ID: <4EBEE1D8.7040407@grandegger.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>	<4E4CA945.7080504@hartkopp.net>	<4E4CC9D5.6040708@pengutronix.de>	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>	<4E5CCAA5.4030009@grandegger.com>	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>	<4E6271CD.6040407@grandegger.com>	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>	<4E64B6CB.8010505@grandegger.com>	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>	<4E653775.4030503@grandegger.com>	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>	<4EBB8CFD.3050602@grandegger.com>	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>
	<4EBEE043.6070601@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060003090806050609050806"
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4EBEE043.6070601-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is a multi-part message in MIME format.
--------------060003090806050609050806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
> On 11/12/2011 10:55 AM, Willy Lambert wrote:
...
>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
> 
> No, it's for up-to-date *mainline* linux version 3.1.x. Any chance to
> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm going to
> adapt the patch to 2.6.38.8.

Well, the patch also applies to 2.6.38.8. Maybe you have some problems
extracting the patch. Therefore I have attached it as attachment this
time. Good luck.

Wolfgang.

--------------060003090806050609050806
Content-Type: text/x-diff;
 name="0001-can-sja1000_isa-convert-to-platform-driver-to-suppor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-can-sja1000_isa-convert-to-platform-driver-to-suppor.pa";
 filename*1="tch"

From dd2c8d7cf8f23a20aecd234a6cf7675b59f5779d Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Date: Thu, 10 Nov 2011 09:10:18 +0100
Subject: [PATCH] can: sja1000_isa: convert to platform driver to support x86_64 systems

This driver is currently not supported on x86_64 systems because the
"isa_driver" interface is used. To overcome this limitation, this
driver is converted to a platform driver, similar to the serial 8250
driver.

Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
---
 drivers/net/can/sja1000/Kconfig       |    1 -
 drivers/net/can/sja1000/sja1000_isa.c |   86 ++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index fe9e64d..36e9d59 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -6,7 +6,6 @@ if CAN_SJA1000
 
 config CAN_SJA1000_ISA
 	tristate "ISA Bus based legacy SJA1000 driver"
-	depends on ISA
 	---help---
 	  This driver adds legacy support for SJA1000 chips connected to
 	  the ISA bus using I/O port, memory mapped or indirect access.
diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
index 496223e..3301031 100644
--- a/drivers/net/can/sja1000/sja1000_isa.c
+++ b/drivers/net/can/sja1000/sja1000_isa.c
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/isa.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/delay.h>
@@ -75,6 +75,8 @@ MODULE_PARM_DESC(ocr, "Output control register "
 #define SJA1000_IOSIZE          0x20
 #define SJA1000_IOSIZE_INDIRECT 0x02
 
+static struct platform_device *sja1000_isa_devs[MAXDEV];
+
 static u8 sja1000_isa_mem_read_reg(const struct sja1000_priv *priv, int reg)
 {
 	return readb(priv->reg_base + reg);
@@ -115,24 +117,13 @@ static void sja1000_isa_port_write_reg_indirect(const struct sja1000_priv *priv,
 	outb(val, base + 1);
 }
 
-static int __devinit sja1000_isa_match(struct device *pdev, unsigned int idx)
-{
-	if (port[idx] || mem[idx]) {
-		if (irq[idx])
-			return 1;
-	} else if (idx)
-		return 0;
-
-	dev_err(pdev, "insufficient parameters supplied\n");
-	return 0;
-}
-
-static int __devinit sja1000_isa_probe(struct device *pdev, unsigned int idx)
+static int __devinit sja1000_isa_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct sja1000_priv *priv;
 	void __iomem *base = NULL;
 	int iosize = SJA1000_IOSIZE;
+	int idx = pdev->id;
 	int err;
 
 	if (mem[idx]) {
@@ -203,17 +194,17 @@ static int __devinit sja1000_isa_probe(struct device *pdev, unsigned int idx)
 	else
 		priv->cdr = CDR_DEFAULT;
 
-	dev_set_drvdata(pdev, dev);
-	SET_NETDEV_DEV(dev, pdev);
+	dev_set_drvdata(&pdev->dev, dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	err = register_sja1000dev(dev);
 	if (err) {
-		dev_err(pdev, "registering %s failed (err=%d)\n",
+		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
 			DRV_NAME, err);
 		goto exit_unmap;
 	}
 
-	dev_info(pdev, "%s device registered (reg_base=0x%p, irq=%d)\n",
+	dev_info(&pdev->dev, "%s device registered (reg_base=0x%p, irq=%d)\n",
 		 DRV_NAME, priv->reg_base, dev->irq);
 	return 0;
 
@@ -229,13 +220,14 @@ static int __devinit sja1000_isa_probe(struct device *pdev, unsigned int idx)
 	return err;
 }
 
-static int __devexit sja1000_isa_remove(struct device *pdev, unsigned int idx)
+static int __devexit sja1000_isa_remove(struct platform_device *pdev)
 {
-	struct net_device *dev = dev_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(&pdev->dev);
 	struct sja1000_priv *priv = netdev_priv(dev);
+	int idx = pdev->id;
 
 	unregister_sja1000dev(dev);
-	dev_set_drvdata(pdev, NULL);
+	dev_set_drvdata(&pdev->dev, NULL);
 
 	if (mem[idx]) {
 		iounmap(priv->reg_base);
@@ -251,29 +243,65 @@ static int __devexit sja1000_isa_remove(struct device *pdev, unsigned int idx)
 	return 0;
 }
 
-static struct isa_driver sja1000_isa_driver = {
-	.match = sja1000_isa_match,
+static struct platform_driver sja1000_isa_driver = {
 	.probe = sja1000_isa_probe,
 	.remove = __devexit_p(sja1000_isa_remove),
 	.driver = {
 		.name = DRV_NAME,
+		.owner = THIS_MODULE,
 	},
 };
 
 static int __init sja1000_isa_init(void)
 {
-	int err = isa_register_driver(&sja1000_isa_driver, MAXDEV);
+	int idx, err;
+
+	for (idx = 0; idx < MAXDEV; idx++) {
+		if ((port[idx] || mem[idx]) && irq[idx]) {
+			sja1000_isa_devs[idx] =
+				platform_device_alloc(DRV_NAME, idx);
+			if (!sja1000_isa_devs[idx]) {
+				err = -ENOMEM;
+				goto exit_free_devices;
+			}
+			err = platform_device_add(sja1000_isa_devs[idx]);
+			if (err) {
+				platform_device_put(sja1000_isa_devs[idx]);
+				goto exit_free_devices;
+			}
+		} else {
+			pr_err("%s: insufficient parameters supplied\n",
+			       DRV_NAME);
+			goto exit_free_devices;
+	}
+
+	err = platform_driver_register(&sja1000_isa_driver);
+	if (err)
+		goto exit_free_devices;
+
+	pr_info("Legacy %s driver for max. %d devices registered\n",
+		DRV_NAME, MAXDEV);
+
+	return 0;
+
+exit_free_devices:
+	while (--idx >= 0) {
+		if (sja1000_isa_devs[idx])
+			platform_device_unregister(sja1000_isa_devs[idx]);
+	}
 
-	if (!err)
-		printk(KERN_INFO
-		       "Legacy %s driver for max. %d devices registered\n",
-		       DRV_NAME, MAXDEV);
 	return err;
 }
 
 static void __exit sja1000_isa_exit(void)
 {
-	isa_unregister_driver(&sja1000_isa_driver);
+	int idx;
+
+	platform_driver_unregister(&sja1000_isa_driver);
+	for (idx = 0; idx < MAXDEV; idx++) {
+		if (sja1000_isa_devs[idx])
+			platform_device_unregister(sja1000_isa_devs[idx]);
+	}
 }
 
 module_init(sja1000_isa_init);
-- 
1.7.4.1


--------------060003090806050609050806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-users mailing list
Socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-users

--------------060003090806050609050806--
