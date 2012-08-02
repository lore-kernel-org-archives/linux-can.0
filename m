From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 2/3] can: c_can: Modify c_can device names in c_can_pci
 driver
Date: Thu, 2 Aug 2012 16:32:18 +0530
Message-ID: <1343905339-4642-3-git-send-email-anilkumar@ti.com>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1343905339-4642-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, anantgole-l0cyMroinI0@public.gmane.org
List-Id: linux-can.vger.kernel.org

Modify c_can device names from *_CAN_DEVTYPE to BOSCH_*_CAN to make
use of same names in platform_device_id struct and of_device_id
struct.

Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
---
 drivers/net/can/c_can/c_can_pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 1011146..3d7830b 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -120,10 +120,10 @@ static int __devinit c_can_pci_probe(struct pci_dev *pdev,
 
 	/* Configure CAN type */
 	switch (c_can_pci_data->type) {
-	case C_CAN_DEVTYPE:
+	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
 		break;
-	case D_CAN_DEVTYPE:
+	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		break;
@@ -192,7 +192,7 @@ static void __devexit c_can_pci_remove(struct pci_dev *pdev)
 }
 
 static struct c_can_pci_data c_can_sta2x11= {
-	.type = C_CAN_DEVTYPE,
+	.type = BOSCH_C_CAN,
 	.reg_align = C_CAN_REG_ALIGN_32,
 	.freq = 52000000, /* 52 Mhz */
 };
-- 
1.7.9.5
