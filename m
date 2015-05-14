From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH v2 1/5] doc/bindings: Add 'endianess' optional-property for
 FlexCAN controller
Date: Thu, 14 May 2015 17:03:31 +0530
Message-ID: <1431603215-25546-2-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: bhupesh.sharma@freescale.com, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org, Sakar.Arora@freescale.com
List-Id: linux-can.vger.kernel.org

This patch adds 'endianess' as the optional-property for
describing the FlexCAN controller present on various FSL platforms.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..0d5e668 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -18,6 +18,10 @@ Optional properties:
 
 - xceiver-supply: Regulator that powers the CAN transceiver
 
+- little-endian: If the FlexCAN IP on this SoC is little-endian, use
+                 this property. By default it is assumed that the IP
+                 is big-endian
+
 Example:
 
 	can@1c000 {
-- 
1.7.9.5
