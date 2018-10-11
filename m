From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] can: xilinx: add can 2.0 support
Date: Thu, 11 Oct 2018 21:56:10 +0530
Message-ID: <1539275171-13252-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: robh+dt@kernel.org, michal.simek@xilinx.com, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-can.vger.kernel.org

Add support for can 2.0.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 045f084..7c4f5ad 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -63,6 +63,7 @@ enum xcan_reg {
        XCAN_FSR_OFFSET         =3D 0x00E8, /* RX FIFO Status */
        XCAN_TXMSG_BASE_OFFSET  =3D 0x0100, /* TX Message Space */
        XCAN_RXMSG_BASE_OFFSET  =3D 0x1100, /* RX Message Space */
+       XCAN_RXMSG_2_BASE_OFFSET        =3D 0x2100, /* RX Message Space */
 };

 #define XCAN_FRAME_ID_OFFSET(frame_base)       ((frame_base) + 0x00)
@@ -75,6 +76,8 @@ enum xcan_reg {
                                         XCAN_CANFD_FRAME_SIZE * (n))
 #define XCAN_RXMSG_FRAME_OFFSET(n)     (XCAN_RXMSG_BASE_OFFSET + \
                                         XCAN_CANFD_FRAME_SIZE * (n))
+#define XCAN_RXMSG_2_FRAME_OFFSET(n)   (XCAN_RXMSG_2_BASE_OFFSET + \
+                                        XCAN_CANFD_FRAME_SIZE * (n))

 /* the single TX mailbox used by this driver on CAN FD HW */
 #define XCAN_TX_MAILBOX_IDX            0
@@ -152,6 +155,7 @@ enum xcan_reg {
  * instead of the regular FIFO at 0x50
  */
 #define XCAN_FLAG_RX_FIFO_MULTI        0x0010
+#define XCAN_FLAG_CANFD_2      0x0020

 struct xcan_devtype_data {
        unsigned int flags;
@@ -221,6 +225,18 @@ static const struct can_bittiming_const xcan_bittiming=
_const_canfd =3D {
        .brp_inc =3D 1,
 };

+static const struct can_bittiming_const xcan_bittiming_const_canfd2 =3D {
+       .name =3D DRIVER_NAME,
+       .tseg1_min =3D 1,
+       .tseg1_max =3D 256,
+       .tseg2_min =3D 1,
+       .tseg2_max =3D 128,
+       .sjw_max =3D 128,
+       .brp_min =3D 1,
+       .brp_max =3D 256,
+       .brp_inc =3D 1,
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:      Driver private data structure
@@ -973,7 +989,10 @@ static int xcan_rx_fifo_get_next_frame(struct xcan_pri=
v *priv)
                if (!(fsr & XCAN_FSR_FL_MASK))
                        return -ENOENT;

-               offset =3D XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
+               if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
+                       offset =3D XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_FSR=
_RI_MASK);
+               else
+                       offset =3D XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_R=
I_MASK);

        } else {
                /* check if RX FIFO is empty */
@@ -1430,11 +1449,24 @@ static const struct xcan_devtype_data xcan_canfd_da=
ta =3D {
        .bus_clk_name =3D "s_axi_aclk",
 };

+static const struct xcan_devtype_data xcan_canfd2_data =3D {
+       .flags =3D XCAN_FLAG_EXT_FILTERS |
+                XCAN_FLAG_RXMNF |
+                XCAN_FLAG_TX_MAILBOXES |
+                XCAN_FLAG_CANFD_2 |
+                XCAN_FLAG_RX_FIFO_MULTI,
+       .bittiming_const =3D &xcan_bittiming_const_canfd2,
+       .btr_ts2_shift =3D XCAN_BTR_TS2_SHIFT_CANFD,
+       .btr_sjw_shift =3D XCAN_BTR_SJW_SHIFT_CANFD,
+       .bus_clk_name =3D "s_axi_aclk",
+};
+
 /* Match table for OF platform binding */
 static const struct of_device_id xcan_of_match[] =3D {
        { .compatible =3D "xlnx,zynq-can-1.0", .data =3D &xcan_zynq_data },
        { .compatible =3D "xlnx,axi-can-1.00.a", .data =3D &xcan_axi_data }=
,
        { .compatible =3D "xlnx,canfd-1.0", .data =3D &xcan_canfd_data },
+       { .compatible =3D "xlnx,canfd-2.0", .data =3D &xcan_canfd2_data },
        { /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, xcan_of_match);
