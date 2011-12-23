From: Grosjean Stephane <s.grosjean@peak-system.com>
Subject: peak_pci: device channels chained list issue
Date: Fri, 23 Dec 2011 12:32:18 +0100
Message-ID: <4EF466C2.9070204@peak-system.com>
References: <1322214204-1121-1-git-send-email-wg@grandegger.com> <1322214204-1121-3-git-send-email-wg@grandegger.com> <4ED0FEC5.3070108@hartkopp.net> <4ED34CAD.7040000@essax.com> <4ED351A8.8000102@grandegger.com> <4ED37885.8080909@essax.com> <4ED3B198.2040308@hartkopp.net> <4ED4A2EC.40103@grandegger.com> <4EDBC05D.8070109@essax.com> <4EDBC25D.50405@grandegger.com> <4EDE8435.5080100@essax.com> <4EDF6D54.2060503@grandegger.com> <4EE1E26B.6090308@grandegger.com> <4EE4F76E.3000506@essax.com> <4EE5C824.2050704@grandegger.com> <4EE5E321.8050104@essax.com> <4EE5EBBF.6080007@grandegger.com> <4EF22625.5000109@essax.com> <4EF2FA3F.3010308@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-4d.bbox.fr ([194.158.122.134]:46434 "EHLO mail-4d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323Ab1LWLcZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Dec 2011 06:32:25 -0500
In-Reply-To: <4EF2FA3F.3010308@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hi Wolfgang,

I think the way the device channels are chained in peak_pci_probe() is=20
buggy in the linux-can-next driver, and will lead to some Kernel Oops i=
f=20
the sja1000 module is removed. I fixed it by handling that list in the=20
same manner than I handle channels in the PCAN-USB Pro adapter. Side=20
effect is that the channels net devices are removed from the last to th=
e=20
first one...

Please have a look to the following patch.

Regards,

St=E9phane

diff --git a/drivers/net/can/sja1000/peak_pci.c=20
b/drivers/net/can/sja1000/peak_pci.c
index 2c7f503..7b5a4ab 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -40,7 +40,7 @@ MODULE_LICENSE("GPL v2");

  struct peak_pci_chan {
      void __iomem *cfg_base;         /* Common for all channels */
-    struct net_device *next_dev; /* Chain of network devices */
+    struct net_device *prev_dev; /* Chain of network devices */
      u16 icr_mask;             /* Interrupt mask for fast ack */
  };

@@ -98,7 +98,7 @@ static int __devinit peak_pci_probe(struct pci_dev *p=
dev,
  {
      struct sja1000_priv *priv;
      struct peak_pci_chan *chan;
-    struct net_device *dev, *dev0 =3D NULL;
+    struct net_device *dev, *prev_dev;
      void __iomem *cfg_base, *reg_base;
      u16 sub_sys_id, icr;
      int i, err, channels;
@@ -196,18 +196,16 @@ static int __devinit peak_pci_probe(struct pci_de=
v=20
*pdev,
          }

          /* Create chain of SJA1000 devices */
-        if (i =3D=3D 0)
-            dev0 =3D dev;
-        else
-            chan->next_dev =3D dev;
+        prev_dev =3D pci_get_drvdata(pdev);
+        if (prev_dev)
+            chan->prev_dev =3D prev_dev;
+        pci_set_drvdata(pdev, dev);

          dev_info(&pdev->dev,
               "%s at reg_base=3D0x%p cfg_base=3D0x%p irq=3D%d\n",
               dev->name, priv->reg_base, chan->cfg_base, dev->irq);
      }

-    pci_set_drvdata(pdev, dev0);
-
      /* Enable interrupts */
      writew(icr, cfg_base + PITA_ICR + 2);

@@ -217,12 +215,12 @@ failure_remove_channels:
      /* Disable interrupts */
      writew(0x0, cfg_base + PITA_ICR + 2);

-    for (dev =3D dev0; dev; dev =3D chan->next_dev) {
+    for (dev =3D pci_get_drvdata(pdev); dev; dev =3D chan->prev_dev) {
          unregister_sja1000dev(dev);
          free_sja1000dev(dev);
          priv =3D netdev_priv(dev);
          chan =3D priv->priv;
-        dev =3D chan->next_dev;
+        dev =3D chan->prev_dev;
      }

      pci_iounmap(pdev, reg_base);
@@ -241,7 +239,7 @@ failure_disable_pci:

  static void __devexit peak_pci_remove(struct pci_dev *pdev)
  {
-    struct net_device *dev =3D pci_get_drvdata(pdev); /* First device =
*/
+    struct net_device *dev =3D pci_get_drvdata(pdev); /* Last device *=
/
      struct sja1000_priv *priv =3D netdev_priv(dev);
      struct peak_pci_chan *chan =3D priv->priv;
      void __iomem *cfg_base =3D chan->cfg_base;
@@ -255,7 +253,7 @@ static void __devexit peak_pci_remove(struct pci_de=
v=20
*pdev)
          dev_info(&pdev->dev, "removing device %s\n", dev->name);
          unregister_sja1000dev(dev);
          free_sja1000dev(dev);
-        dev =3D chan->next_dev;
+        dev =3D chan->prev_dev;
          if (!dev)
              break;
          priv =3D netdev_priv(dev);

