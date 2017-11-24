From: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v4 3/6] Documentation : can : flexcan : Add big-endian property to device tree
Date: Fri, 24 Nov 2017 18:52:10 +0530
Message-ID: <1511529733-27942-4-git-send-email-pankaj.bansal@nxp.com>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: V.Sethi-3arQi8VN3Tc@public.gmane.org, poonam.aggrwal-3arQi8VN3Tc@public.gmane.org, Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-can.vger.kernel.org

The FlexCAN controller can be modelled as little or big endian depending
on SOC design. This device tree property identifies the controller
endianness and the driver reads/writes controller registers based on
that.

This is optional property. i.e. if this property is not present in
device tree node then controller is assumed to be little endian. if this
property is present then controller is assumed to be big endian.

Signed-off-by: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
---
Changes in v4:
  - document the default behaviour in the bindings if the big-endian property
    is missing.
  - Merged device tree changes and driver changes in one series
Changes in v3:
  - No change.
Changes in v2:
  - No change.
  - Added one more patch in series.

 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..bfc0c43 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -18,6 +18,12 @@ Optional properties:
 
 - xceiver-supply: Regulator that powers the CAN transceiver
 
+- big-endian: This means the registers of FlexCAN controller are big endian.
+              This is optional property.i.e. if this property is not present in
+              device tree node then controller is assumed to be little endian.
+              if this property is present then controller is assumed to be big
+              endian.
+
 Example:
 
 	can@1c000 {
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
