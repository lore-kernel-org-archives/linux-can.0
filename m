From: Pavel Machek <pavel@denx.de>
Subject: [PATCHv3] C_CAN: Add 32-bit accesses
Date: Tue, 6 May 2014 15:57:02 +0200
Message-ID: <20140506135702.GA9879@amd.pavel.ucw.cz>
References: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140505120801.GA16461@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, socketcan@hartkopp.net, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

Add helpers for 32-bit accesses and replace open-coded 32-bit access
with calls to helpers. Minimum changes are done to the pci case, as I
don't have access to that hardware.

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a2ca820..e154b4c 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -252,8 +252,7 @@ static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj
 	struct c_can_priv *priv = netdev_priv(dev);
 	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
 
-	priv->write_reg(priv, reg + 1, cmd);
-	priv->write_reg(priv, reg, obj);
+	priv->write_reg32(priv, reg, (cmd << 16) | obj);
 
 	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
 		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
@@ -328,8 +327,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 		change_bit(idx, &priv->tx_dir);
 	}
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 
@@ -391,8 +389,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 
 	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
 
-	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
-	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
+	arb = priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
 
 	if (arb & IF_ARB_MSGXTD)
 		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -424,12 +421,10 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	mask |= BIT(29);
-	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
-	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface), mask >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
 
 	id |= IF_ARB_MSGVAL;
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), id);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), id >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
 	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index c56f1b1..ce0e642 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -188,6 +188,8 @@ struct c_can_priv {
 	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
+	u32 (*read_reg32) (struct c_can_priv *priv, enum reg index);
+	void (*write_reg32) (struct c_can_priv *priv, enum reg index, u32 val);
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index fe5f630..419bb7c 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -63,6 +63,23 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	priv->write_reg(priv, index + 1, val>>16);
+	priv->write_reg(priv, index, val);
+}
+
 static int c_can_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -151,6 +168,8 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		ret = -EINVAL;
 		goto out_free_c_can;
 	}
+	priv->read_reg32 = c_can_plat_read_reg32;
+	priv->write_reg32 = c_can_plat_write_reg32;
 
 	ret = register_c_can_dev(dev);
 	if (ret) {
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 1df0b32..002bf9b 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -108,6 +108,34 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 	spin_unlock(&raminit_lock);
 }
 
+static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	u32 val;
+
+	val = priv->read_reg(priv, index);
+	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
+
+	return val;
+}
+
+static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	priv->write_reg(priv, index + 1, val>>16);
+	priv->write_reg(priv, index, val);
+}
+
+static u32 d_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
+{
+	return readl(priv->base + priv->regs[index]);
+}
+
+static void d_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
+		u32 val)
+{
+	writel(val, priv->base + priv->regs[index]);
+}
+
 static struct platform_device_id c_can_id_table[] = {
 	[BOSCH_C_CAN_PLATFORM] = {
 		.name = KBUILD_MODNAME,
@@ -201,11 +229,15 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		case IORESOURCE_MEM_32BIT:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		case IORESOURCE_MEM_16BIT:
 		default:
 			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+			priv->read_reg32 = c_can_plat_read_reg32;
+			priv->write_reg32 = c_can_plat_write_reg32;
 			break;
 		}
 		break;
@@ -214,6 +246,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
 		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
+		priv->read_reg32 = d_can_plat_read_reg32;
+		priv->write_reg32 = d_can_plat_write_reg32;
 
 		if (pdev->dev.of_node)
 			priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
