From: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v4 2/6] can: flexcan: adding platform specific details for LS1021A
Date: Fri, 24 Nov 2017 18:52:09 +0530
Message-ID: <1511529733-27942-3-git-send-email-pankaj.bansal@nxp.com>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This patch adds platform specific details for NXP SOC LS1021A to the
flexcan driver code.

Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Zhengxiong Jin <Jason.Jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
  - Merged device tree changes and driver changes in one series
  - Remove obsolete comment about rev2 functional RX FIFO.
Changes in v3:
  - Add LS1021 in FLEXCAN hardware feature flags table
  - Kept LS1021 compatible in one line, even if it's more than 80
    chars.
  - Add PERR_STATE quirk and USE_OFF_TIMESTAMP quirk and
    ENABLE_EACEN_RRS quirk for LS1021A.
  - Tested on LS1021A using "cangen can0 -D 11223344DEADBEEF -L 8 -R"
    and "cangen can0 -D 11223344DEADBEEF -L 8"
Changes in v2:
  - No change.

 drivers/net/can/flexcan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4c873fb..3a370d8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -190,6 +190,7 @@
  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
  *   VF610 FlexCAN3  ?               no       yes         ?      yes       yes?
+ * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -304,6 +305,12 @@ static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
+static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -1248,6 +1255,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
+	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
