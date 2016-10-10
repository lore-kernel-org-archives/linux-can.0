From: Lukas Resch <l.resch@incubedit.com>
Subject: [PATCH] Add support for Moxa CAN devices
Date: Mon, 10 Oct 2016 08:07:32 +0000
Message-ID: <HE1PR07MB15169CED2D20022B1D433A7EF7DB0@HE1PR07MB1516.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:39424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751702AbcJJNnc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 10 Oct 2016 09:43:32 -0400
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This patch adds support for Moxa CAN devices.

The patch is based on linux-can-next 2d7a892626b5616a00d27a40fa23d70d5e6182=
69

Signed-off-by Lukas Resch <l.resch@incubedit.com>
Signed-off-by: Christoph Zehentner <c.zehentner@incubedit.com>
---
drivers/net/can/sja1000/plx_pci.c | 18 ++++++++++++++++++
1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/pl=
x_pci.c
index 3eb7430..7c27d6f 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -142,6 +142,9 @@ struct plx_pci_card {
 #define CTI_PCI_VENDOR_ID    0x12c4
 #define CTI_PCI_DEVICE_ID_CRG001 0x0900

+#define MOXA_PCI_VENDOR_ID   0x1393
+#define MOXA_PCI_DEVICE_ID   0x0100
+
 static void plx_pci_reset_common(struct pci_dev *pdev);
 static void plx9056_pci_reset_common(struct pci_dev *pdev);
 static void plx_pci_reset_marathon_pci(struct pci_dev *pdev);
@@ -258,6 +261,14 @@ static struct plx_pci_card_info plx_pci_card_info_elcu=
s =3D {
  /* based on PLX9030 */
 };

+static struct plx_pci_card_info plx_pci_card_info_moxa =3D {
+ "MOXA", 2,
+ PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
+ {0, 0x00, 0x00}, { {0, 0x00, 0x80}, {1, 0x00, 0x80} },
+ &plx_pci_reset_common
+ /* based on PLX9052 */
+};
+
 static const struct pci_device_id plx_pci_tbl[] =3D {
  {
    /* Adlink PCI-7841/cPCI-7841 */
@@ -357,6 +368,13 @@ static const struct pci_device_id plx_pci_tbl[] =3D {
    0, 0,
    (kernel_ulong_t)&plx_pci_card_info_elcus
  },
+ {
+   /* moxa */
+   MOXA_PCI_VENDOR_ID, MOXA_PCI_DEVICE_ID,
+   PCI_ANY_ID, PCI_ANY_ID,
+   0, 0,
+   (kernel_ulong_t)&plx_pci_card_info_moxa
+ },
  { 0,}
 };
 MODULE_DEVICE_TABLE(pci, plx_pci_tbl);;
