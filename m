From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Mon, 14 Nov 2011 16:19:45 +0100
Message-ID: <4EC13191.6070901@grandegger.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>	<4E6271CD.6040407@grandegger.com>	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>	<4E64B6CB.8010505@grandegger.com>	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>	<4E653775.4030503@grandegger.com>	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>	<4EBB8CFD.3050602@grandegger.com>	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>	<4EBEE043.6070601@grandegger.com>
	<4EBEE1D8.7040407@grandegger.com>	<CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>	<CAKvQZ_3anOf1SbE5TK6gvJf4v3gw1MBae0hw5JGr__szt7KoQQ@mail.gmail.com>	<4EC01B12.5050404@grandegger.com>
	<4EC0E4BE.4010101@grandegger.com>
	<CAKvQZ_2GkTqFrp-9quut0f33KL9tdD9NSTZ3btDHLZNP=a2VwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050903090807000507020200"
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <CAKvQZ_2GkTqFrp-9quut0f33KL9tdD9NSTZ3btDHLZNP=a2VwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
--------------050903090807000507020200
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/14/2011 03:51 PM, Willy Lambert wrote:
> 2011/11/14 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>> On 11/13/2011 08:31 PM, Wolfgang Grandegger wrote:
>>> On 11/13/2011 10:15 AM, Willy Lambert wrote:
>>>> 2011/11/13 Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>> 2011/11/12 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>>>>>> On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
>>>>>>> On 11/12/2011 10:55 AM, Willy Lambert wrote:
>>>>>> ...
>>>>>>>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
>>>>>>>
>>>>>>> No, it's for up-to-date *mainline* linux version 3.1.x. Any chanc=
e to
>>>>>>> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm going=
 to
>>>>>>> adapt the patch to 2.6.38.8.
>>>>>>
>>>>>> Well, the patch also applies to 2.6.38.8. Maybe you have some prob=
lems
>>>>>> extracting the patch. Therefore I have attached it as attachment t=
his
>>>>>> time. Good luck.
>>>>>
>>>>> It's ok now :
>>>>> ard@ard-host:~/src/linux-2.6.38.8$ patch -p1 < wg_platform.patch
>>>>> patching file drivers/net/can/sja1000/Kconfig
>>>>> patching file drivers/net/can/sja1000/sja1000_isa.c
>>>>>
>>>>> I must have done something wrong. I am going to test it now
>>>>>
>>>>
>>>> arg, it doesn't compile I had a look a sources but I don't see the e=
rror :
>>>>
>>>>   CC [M]  drivers/xenomai/can/rtcan_raw_dev.o
>>>> drivers/net/can/sja1000/sja1000_isa.c: In function =91sja1000_isa_in=
it=92:
>>>> drivers/net/can/sja1000/sja1000_isa.c:297: error: invalid storage
>>>> class for function =91sja1000_isa_exit=92
>>>> drivers/net/can/sja1000/sja1000_isa.c:296: warning: ISO C90 forbids
>>>> mixed declarations and code
>>>> drivers/net/can/sja1000/sja1000_isa.c:307: error: invalid storage
>>>> class for function =91__inittest=92
>>>> drivers/net/can/sja1000/sja1000_isa.c:307: warning: =91alias=92 attr=
ibute ignored
>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: invalid storage
>>>> class for function =91__exittest=92
>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: ISO C90 forbids
>>>> mixed declarations and code
>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: =91alias=92 attr=
ibute ignored
>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: expected declarati=
on
>>>> or statement at end of input
>>>> make[5]: *** [drivers/net/can/sja1000/sja1000_isa.o] Error 1
>>>
>>> Argh, a "}" is missing, sorry. I will test the patch more carefully
>>> before re-sending.
>>
>> See attachment.
>=20
> Thanks, the compilation is now ok, but when I load them on my target I
> have this in dmesg :
> CAN device driver interface
> sja1000 CAN netdevice driver
> sja1000_isa: insufficient parameters supplied
>=20
> The loading command is :
> modprobe sja1000_isa irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e =
cdr=3D0,0
> And I am sure it is the same than before, so I think there is a
> problem when you read the parameters

Again, my fault., sorry Could you please retry with the attached patch.
Could you please also enable CAN device debugging
(CONFIG_CAN_DEBUG_DEVICES=3Dy).

Thanks,

Wolfgang.

--------------050903090807000507020200
Content-Type: text/x-diff;
 name="sja1000-isa-platform-x86-64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sja1000-isa-platform-x86-64.patch"

[PATCH] can: sja1000_isa: convert to platform driver to support x86_64 systems

This driver is currently not supported on x86_64 systems because the
"isa_driver" interface is used. To overcome this limitation, this
driver is converted to a platform driver, similar to the serial 8250
driver.

This patch also fixes some warnings: "comparison is always false due
to limited range of data type".

Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
---
 drivers/net/can/sja1000/Kconfig       |    1 
 drivers/net/can/sja1000/sja1000_isa.c |  110 ++++++++++++++++++++++------------
 2 files changed, 73 insertions(+), 38 deletions(-)

Index: linux-2.6.38.8/drivers/net/can/sja1000/Kconfig
===================================================================
--- linux-2.6.38.8.orig/drivers/net/can/sja1000/Kconfig	2011-11-13 20:24:52.447054533 +0100
+++ linux-2.6.38.8/drivers/net/can/sja1000/Kconfig	2011-11-13 20:24:55.943071866 +0100
@@ -6,7 +6,6 @@
 
 config CAN_SJA1000_ISA
 	tristate "ISA Bus based legacy SJA1000 driver"
-	depends on ISA
 	---help---
 	  This driver adds legacy support for SJA1000 chips connected to
 	  the ISA bus using I/O port, memory mapped or indirect access.
Index: linux-2.6.38.8/drivers/net/can/sja1000/sja1000_isa.c
===================================================================
--- linux-2.6.38.8.orig/drivers/net/can/sja1000/sja1000_isa.c	2011-11-13 20:24:52.431054451 +0100
+++ linux-2.6.38.8/drivers/net/can/sja1000/sja1000_isa.c	2011-11-14 16:18:44.513685553 +0100
@@ -17,7 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/isa.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/delay.h>
@@ -44,9 +44,9 @@
 static unsigned long mem[MAXDEV];
 static int __devinitdata irq[MAXDEV];
 static int __devinitdata clk[MAXDEV];
-static char __devinitdata cdr[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
-static char __devinitdata ocr[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
-static char __devinitdata indirect[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
+static unsigned char __devinitdata cdr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
+static unsigned char __devinitdata ocr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
+static int __devinitdata indirect[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
 
 module_param_array(port, ulong, NULL, S_IRUGO);
 MODULE_PARM_DESC(port, "I/O port number");
@@ -54,7 +54,7 @@
 module_param_array(mem, ulong, NULL, S_IRUGO);
 MODULE_PARM_DESC(mem, "I/O memory address");
 
-module_param_array(indirect, byte, NULL, S_IRUGO);
+module_param_array(indirect, int, NULL, S_IRUGO);
 MODULE_PARM_DESC(indirect, "Indirect access via address and data port");
 
 module_param_array(irq, int, NULL, S_IRUGO);
@@ -75,6 +75,8 @@
 #define SJA1000_IOSIZE          0x20
 #define SJA1000_IOSIZE_INDIRECT 0x02
 
+static struct platform_device *sja1000_isa_devs[MAXDEV];
+
 static u8 sja1000_isa_mem_read_reg(const struct sja1000_priv *priv, int reg)
 {
 	return readb(priv->reg_base + reg);
@@ -115,26 +117,18 @@
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
 
+	dev_dbg(&pdev->dev, "probing idx=%d: port=%#lx, mem=%#lx, irq=%d\n",
+		idx, port[idx], mem[idx], irq[idx]);
+
 	if (mem[idx]) {
 		if (!request_mem_region(mem[idx], iosize, DRV_NAME)) {
 			err = -EBUSY;
@@ -189,31 +183,31 @@
 	else
 		priv->can.clock.freq = CLK_DEFAULT / 2;
 
-	if (ocr[idx] != -1)
+	if (ocr[idx] != 0xff)
 		priv->ocr = ocr[idx] & 0xff;
-	else if (ocr[0] != -1)
+	else if (ocr[0] != 0xff)
 		priv->ocr = ocr[0] & 0xff;
 	else
 		priv->ocr = OCR_DEFAULT;
 
-	if (cdr[idx] != -1)
+	if (cdr[idx] != 0xff)
 		priv->cdr = cdr[idx] & 0xff;
-	else if (cdr[0] != -1)
+	else if (cdr[0] != 0xff)
 		priv->cdr = cdr[0] & 0xff;
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
 
@@ -229,13 +223,14 @@
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
@@ -251,29 +246,70 @@
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
+			pr_debug("%s: platform device %d: port=%#lx, mem=%#lx, "
+				 "irq=%d\n",
+				 DRV_NAME, idx, port[idx], mem[idx], irq[idx]);
+		} else if (idx == 0 || port[idx] || mem[idx]) {
+				pr_err("%s: insufficient parameters supplied\n",
+				       DRV_NAME);
+				err = -EINVAL;
+				goto exit_free_devices;
+		}
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

--------------050903090807000507020200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-users mailing list
Socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-users

--------------050903090807000507020200--
