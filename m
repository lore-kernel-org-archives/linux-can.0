From: =?UTF-8?B?QW5kcmVhcyBHcsO2Z2Vy?= <andreas24groeger@gmail.com>
Subject: Re: [PATCH] can: janz-ican3: add support for CAL/CANopen firmware
Date: Tue, 05 May 2015 20:08:34 +0200
Message-ID: <55490722.3090802@gmail.com>
References: <5543C69C.5060508@gmail.com> <5543E065.6060000@pengutronix.de> <20150502164049.GB31242@gmail.com> <5544FE8C.9020100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36217 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbbEESIh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 May 2015 14:08:37 -0400
Received: by wizk4 with SMTP id k4so172080743wiz.1
        for <linux-can@vger.kernel.org>; Tue, 05 May 2015 11:08:36 -0700 (PDT)
Received: from [192.168.36.20] (p5B0A40C9.dip0.t-ipconnect.de. [91.10.64.201])
        by mx.google.com with ESMTPSA id bg4sm10583544wjc.10.2015.05.05.11.08.35
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 11:08:35 -0700 (PDT)
In-Reply-To: <5544FE8C.9020100@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

sorry, my S-o-b was invalid.
---
Hi Marc, Hi Ira,

thank you very much for the positive and constructive responses, seems =
to be the right way.=20

String comparison for firmware identification: there is another way to =
retrieve the id and version (IDVERS-request), but it is more complicate=
d. You have to await the response and the result is a longer string abo=
ut 200 bytes. Janz recommends this firmware stamp for module identifica=
tion.

Bittiming in ican3_set_bus_state: this affects the driver with ICANOS-f=
irmware. So I asked Janz for the ICANOS-firmware to be able to test. I =
tested both firmware-variants with different baudrates: went as expecte=
d. Hope I met your needs.

Kind regards,
Andreas

Signed-off-by: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci-drivers-janz-cmodio |    8=20
 Documentation/ABI/testing/sysfs-class-net-janz-ican3        |   21 ++
 drivers/mfd/janz-cmodio.c                                   |    4=20
 drivers/net/can/janz-ican3.c                                |  125 +++=
+++++----
 4 files changed, 121 insertions(+), 37 deletions(-)

diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/Document=
ation/ABI/testing/sysfs-bus-pci-drivers-janz-cmodio linux-3.19.me/Docum=
entation/ABI/testing/sysfs-bus-pci-drivers-janz-cmodio
--- linux-3.19.6/Documentation/ABI/testing/sysfs-bus-pci-drivers-janz-c=
modio	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.19.me/Documentation/ABI/testing/sysfs-bus-pci-drivers-janz-=
cmodio	2015-05-04 15:44:33.056595249 +0200
@@ -0,0 +1,8 @@
+What:		/sys/bus/pci/drivers/janz-cmodio/.../modulbus_number
+Date:		May 2010
+KernelVersion:	2.6.35
+Contact:	Ira W. Snyder <ira.snyder@gmail.com>
+Description:
+		Value representing the HEX switch S2 of the janz carrier board CMOD-=
IO or CAN-PCI2
+
+		Read-only: value of the configuration switch (0..15)
diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/Document=
ation/ABI/testing/sysfs-class-net-janz-ican3 linux-3.19.me/Documentatio=
n/ABI/testing/sysfs-class-net-janz-ican3
--- linux-3.19.6/Documentation/ABI/testing/sysfs-class-net-janz-ican3	1=
970-01-01 01:00:00.000000000 +0100
+++ linux-3.19.me/Documentation/ABI/testing/sysfs-class-net-janz-ican3	=
2015-05-04 17:38:38.527615571 +0200
@@ -0,0 +1,21 @@
+What:		/sys/class/net/<iface>/termination
+Date:		May 2010
+KernelVersion:	2.6.35
+Contact:	Ira W. Snyder <ira.snyder@gmail.com>
+Description:
+		Value representing the can bus termination
+
+		Default: 1 (termination active)
+		Reading: get actual termination state
+		Writing: set actual termination state (0=3Dno termination, 1=3Dtermi=
nation active)
+
+What:		/sys/class/net/<iface>/fwinfo
+Date:		May 2015
+KernelVersion:	3.19
+Contact:	Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>
+Description:
+		Firmware stamp of ican3 module
+		Read-only: 32 byte string identification of the ICAN3 module
+		(known values: "JANZ-ICAN3 ICANOS 1.xx", "JANZ-ICAN3 CAL/CANopen 1.x=
x")
+
+
diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/=
mfd/janz-cmodio.c linux-3.19.me/drivers/mfd/janz-cmodio.c
--- linux-3.19.6/drivers/mfd/janz-cmodio.c	2015-04-29 10:30:26.00000000=
0 +0200
+++ linux-3.19.me/drivers/mfd/janz-cmodio.c	2015-05-04 17:34:00.0446353=
84 +0200
@@ -267,6 +267,10 @@
 static const struct pci_device_id cmodio_pci_ids[] =3D {
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x01=
01 },
 	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x01=
00 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x02=
01 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030, PCI_VENDOR_ID_JANZ, 0x02=
02 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x02=
01 },
+	{ PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050, PCI_VENDOR_ID_JANZ, 0x02=
02 },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, cmodio_pci_ids);
diff -uNr -X linux-3.19.me/Documentation/dontdiff linux-3.19.6/drivers/=
net/can/janz-ican3.c linux-3.19.me/drivers/net/can/janz-ican3.c
--- linux-3.19.6/drivers/net/can/janz-ican3.c	2015-04-29 10:30:26.00000=
0000 +0200
+++ linux-3.19.me/drivers/net/can/janz-ican3.c	2015-05-04 17:34:00.0446=
35384 +0200
@@ -40,6 +40,7 @@
 #define MSYNC_PEER		0x00		/* ICAN only */
 #define MSYNC_LOCL		0x01		/* host only */
 #define TARGET_RUNNING		0x02
+#define FIRMWARE_STAMP		0x60		/* big endian firmware stamp */
=20
 #define MSYNC_RB0		0x01
 #define MSYNC_RB1		0x02
@@ -83,6 +84,7 @@
 #define MSG_COFFREQ		0x42
 #define MSG_CONREQ		0x43
 #define MSG_CCONFREQ		0x47
+#define MSG_LMTS		0xb4
=20
 /*
  * Janz ICAN3 CAN Inquiry Message Types
@@ -165,6 +167,12 @@
 /* SJA1000 Clock Input */
 #define ICAN3_CAN_CLOCK		8000000
=20
+/* Janz ICAN3 firmware types */
+enum ican3_fwtype {
+	ICAN3_FWTYPE_ICANOS,
+	ICAN3_FWTYPE_CAL_CANOPEN
+};
+
 /* Driver Name */
 #define DRV_NAME "janz-ican3"
=20
@@ -215,6 +223,10 @@
 	struct completion buserror_comp;
 	struct can_berr_counter bec;
=20
+	/* firmware type */
+	enum ican3_fwtype fwtype;
+	char fwinfo[32];
+
 	/* old and new style host interface */
 	unsigned int iftype;
=20
@@ -750,13 +762,61 @@
  */
 static int ican3_set_bus_state(struct ican3_dev *mod, bool on)
 {
+	struct can_bittiming *bt =3D &mod->can.bittiming;
 	struct ican3_msg msg;
+	u8 btr0, btr1;
+	int res;
=20
-	memset(&msg, 0, sizeof(msg));
-	msg.spec =3D on ? MSG_CONREQ : MSG_COFFREQ;
-	msg.len =3D cpu_to_le16(0);
+	/* This algorithm was stolen from drivers/net/can/sja1000/sja1000.c  =
    */
+	/* The bittiming register command for the ICAN3 just sets the bit tim=
ing */
+	/* registers on the SJA1000 chip directly                            =
    */
+	btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
+		(((bt->phase_seg2 - 1) & 0x7) << 4);
+	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btr1 |=3D 0x80;
=20
-	return ican3_send_msg(mod, &msg);
+	if (mod->fwtype =3D=3D ICAN3_FWTYPE_ICANOS) {
+		if (on) {
+			/* set bittiming */
+			memset(&msg, 0, sizeof(msg));
+			msg.spec =3D MSG_CBTRREQ;
+			msg.len =3D cpu_to_le16(4);
+			msg.data[0] =3D 0x00;
+			msg.data[1] =3D 0x00;
+			msg.data[2] =3D btr0;
+			msg.data[3] =3D btr1;
+
+			res =3D ican3_send_msg(mod, &msg);
+			if (res)
+				return res;
+		}
+
+		/* can-on/off request */
+		memset(&msg, 0, sizeof(msg));
+		msg.spec =3D on ? MSG_CONREQ : MSG_COFFREQ;
+		msg.len =3D cpu_to_le16(0);
+
+		return ican3_send_msg(mod, &msg);
+
+	} else if (mod->fwtype =3D=3D ICAN3_FWTYPE_CAL_CANOPEN) {
+		memset(&msg, 0, sizeof(msg));
+		msg.spec =3D MSG_LMTS;
+		if (on) {
+			msg.len =3D cpu_to_le16(4);
+			msg.data[0] =3D 0;
+			msg.data[1] =3D 0;
+			msg.data[2] =3D btr0;
+			msg.data[3] =3D btr1;
+		} else {
+			msg.len =3D cpu_to_le16(2);
+			msg.data[0] =3D 1;
+			msg.data[1] =3D 0;
+		}
+
+		return ican3_send_msg(mod, &msg);
+	}
+	return -ENOTSUPP;
 }
=20
 static int ican3_set_termination(struct ican3_dev *mod, bool on)
@@ -1401,7 +1461,7 @@
 			return 0;
=20
 		msleep(10);
-	} while (time_before(jiffies, start + HZ / 4));
+	} while (time_before(jiffies, start + HZ / 2));
=20
 	netdev_err(mod->ndev, "failed to reset CAN module\n");
 	return -ETIMEDOUT;
@@ -1426,6 +1486,17 @@
 		return ret;
 	}
=20
+	/* detect firmware */
+	memcpy_fromio(mod->fwinfo, mod->dpm + FIRMWARE_STAMP, sizeof(mod->fwi=
nfo) - 1);
+	if (strncmp(mod->fwinfo, "JANZ-ICAN3", 10)) {
+		netdev_err(mod->ndev, "ICAN3 not detected (found %s)\n", mod->fwinfo=
);
+		return -ENODEV;
+	}
+	if (strstr(mod->fwinfo, "CAL/CANopen"))
+		mod->fwtype =3D ICAN3_FWTYPE_CAL_CANOPEN;
+	else
+		mod->fwtype =3D ICAN3_FWTYPE_ICANOS;
+
 	/* re-enable interrupts so we can send messages */
 	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
=20
@@ -1614,36 +1685,6 @@
 	.brp_inc =3D 1,
 };
=20
-/*
- * This routine was stolen from drivers/net/can/sja1000/sja1000.c
- *
- * The bittiming register command for the ICAN3 just sets the bit timi=
ng
- * registers on the SJA1000 chip directly
- */
-static int ican3_set_bittiming(struct net_device *ndev)
-{
-	struct ican3_dev *mod =3D netdev_priv(ndev);
-	struct can_bittiming *bt =3D &mod->can.bittiming;
-	struct ican3_msg msg;
-	u8 btr0, btr1;
-
-	btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
-	btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
-		(((bt->phase_seg2 - 1) & 0x7) << 4);
-	if (mod->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		btr1 |=3D 0x80;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.spec =3D MSG_CBTRREQ;
-	msg.len =3D cpu_to_le16(4);
-	msg.data[0] =3D 0x00;
-	msg.data[1] =3D 0x00;
-	msg.data[2] =3D btr0;
-	msg.data[3] =3D btr1;
-
-	return ican3_send_msg(mod, &msg);
-}
-
 static int ican3_set_mode(struct net_device *ndev, enum can_mode mode)
 {
 	struct ican3_dev *mod =3D netdev_priv(ndev);
@@ -1731,11 +1772,22 @@
 	return count;
 }
=20
+static ssize_t ican3_sysfs_show_fwinfo(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct ican3_dev *mod =3D netdev_priv(to_net_dev(dev));
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", mod->fwinfo);
+}
+
 static DEVICE_ATTR(termination, S_IWUSR | S_IRUGO, ican3_sysfs_show_te=
rm,
 						   ican3_sysfs_set_term);
+static DEVICE_ATTR(fwinfo, S_IRUSR | S_IRUGO, ican3_sysfs_show_fwinfo,=
 NULL);
=20
 static struct attribute *ican3_sysfs_attrs[] =3D {
 	&dev_attr_termination.attr,
+	&dev_attr_fwinfo.attr,
 	NULL,
 };
=20
@@ -1795,7 +1847,6 @@
=20
 	mod->can.clock.freq =3D ICAN3_CAN_CLOCK;
 	mod->can.bittiming_const =3D &ican3_bittiming_const;
-	mod->can.do_set_bittiming =3D ican3_set_bittiming;
 	mod->can.do_set_mode =3D ican3_set_mode;
 	mod->can.do_get_berr_counter =3D ican3_get_berr_counter;
 	mod->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES
@@ -1867,7 +1918,7 @@
 		goto out_free_irq;
 	}
=20
-	dev_info(dev, "module %d: registered CAN device\n", pdata->modno);
+	netdev_info(mod->ndev, "module %d: registered CAN device\n", pdata->m=
odno);
 	return 0;
=20
 out_free_irq:
