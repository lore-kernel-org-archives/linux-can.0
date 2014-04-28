From: Thor Thayer <tthayer@altera.com>
Subject: Re: [patch] Fix CAN on socfpga, for net/master
Date: Mon, 28 Apr 2014 15:20:49 -0500
Message-ID: <1398716449.836.4.camel@dinh-ubuntu>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
	 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
	 <20140404102815.GA9242@amd.pavel.ucw.cz>
	 <20140425195319.GA3677@amd.pavel.ucw.cz>
	 <1398457446.26387.0.camel@linux-builds1>
	 <1398461518.3587.11.camel@dinh-ubuntu>
	 <20140426093646.GE8730@amd.pavel.ucw.cz>
	 <20140426203131.GA21832@amd.pavel.ucw.cz>
	 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
	 <20140427122510.GB12901@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0125.outbound.protection.outlook.com ([207.46.100.125]:40934
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754684AbaD1UOx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Apr 2014 16:14:53 -0400
In-Reply-To: <20140427122510.GB12901@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ZY - pavel <pavel@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com, tthayer.linux@gmail.com

On Sun, 2014-04-27 at 14:25 +0200, ZY - pavel wrote:
> Apparently, socfpga CAN needs 32-bit accesses and different raminit
> sequence.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> ---
> 
> > 
> > I'm not in the office (and fighting with my phone's email client) until 5th of May, however please rebase all your patches against the latest net/master from David Miller, as this tree includes all c_can fixes by Thomas.
> > 
> 
> Ok, combined patch is here. Lightly tested using loopback on Arrow
> SocKit.

Hi Pavel. 

Thanks for your help on the SOCFPGA support! I can test this on the
Altera Development Kit but I'm not able to cleanly apply to the latest
David Miller net-next branch. Is there a different branch I should use? 

I also like your updates to my patch as shown below - much cleaner.

Thanks,

Thor

> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index a2ca820..824ec21 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -48,6 +48,7 @@
>  #define C_CAN_IFACE(reg, iface)	(C_CAN_IF1_##reg + (iface) * IF_ENUM_REG_LEN)
>  
>  /* control extension register D_CAN specific */
> +#define CONTROL_MIL		BIT(17)
>  #define CONTROL_EX_PDR		BIT(8)
>  
>  /* control register */
> @@ -239,12 +240,20 @@ static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
>  
>  static void c_can_irq_control(struct c_can_priv *priv, bool enable)
>  {
> -	u32 ctrl = priv->read_reg(priv,	C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
> +	u32 ctrl;
> +
> +	if (priv->type == BOSCH_D_CAN)
> +		ctrl = priv->read_reg32(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
> +	else
> +		ctrl = priv->read_reg(priv, C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
>  
>  	if (enable)
>  		ctrl |= CONTROL_IRQMSK;
>  
> -	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
> +	if (priv->type == BOSCH_D_CAN)
> +		priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl);
> +	else
> +		priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
>  }
>  
>  static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj)
> @@ -252,8 +261,7 @@ static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj
>  	struct c_can_priv *priv = netdev_priv(dev);
>  	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
>  
> -	priv->write_reg(priv, reg + 1, cmd);
> -	priv->write_reg(priv, reg, obj);
> +	priv->write_reg32(priv, reg, (cmd << 16) | obj);
>  
>  	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
>  		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
> @@ -328,8 +336,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
>  		change_bit(idx, &priv->tx_dir);
>  	}
>  
> -	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
> -	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
> +	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
>  
>  	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
>  
> @@ -391,8 +398,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
>  
>  	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
>  
> -	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
> -	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
> +	arb = priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
>  
>  	if (arb & IF_ARB_MSGXTD)
>  		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
> @@ -424,12 +430,10 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
>  	struct c_can_priv *priv = netdev_priv(dev);
>  
>  	mask |= BIT(29);
> -	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
> -	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface), mask >> 16);
> +	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
>  
>  	id |= IF_ARB_MSGVAL;
> -	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), id);
> -	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), id >> 16);
> +	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
>  
>  	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
>  	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
> @@ -510,16 +514,22 @@ static int c_can_set_bittiming(struct net_device *dev)
>  	netdev_info(dev,
>  		"setting BTR=%04x BRPE=%04x\n", reg_btr, reg_brpe);
>  
> -	ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
> +	if (priv->type == BOSCH_D_CAN)
> +		ctrl_save = priv->read_reg32(priv, C_CAN_CTRL_REG);
> +	else
> +		ctrl_save = priv->read_reg(priv, C_CAN_CTRL_REG);
>  	ctrl_save &= ~CONTROL_INIT;
> -	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);
> +	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT); /* FIXME: want to do write32? */
>  	res = c_can_wait_for_ctrl_init(dev, priv, CONTROL_INIT);
>  	if (res)
>  		return res;
>  
>  	priv->write_reg(priv, C_CAN_BTR_REG, reg_btr);
>  	priv->write_reg(priv, C_CAN_BRPEXT_REG, reg_brpe);
> -	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
> +	if (priv->type == BOSCH_D_CAN)
> +		priv->write_reg32(priv, C_CAN_CTRL_REG, ctrl_save);
> +	else
> +		priv->write_reg(priv, C_CAN_CTRL_REG, ctrl_save);
>  
>  	return c_can_wait_for_ctrl_init(dev, priv, 0);
>  }
> @@ -1240,7 +1250,7 @@ int c_can_power_up(struct net_device *dev)
>  
>  	/* Clear PDR and INIT bits */
>  	val = priv->read_reg(priv, C_CAN_CTRL_EX_REG);
> -	val &= ~CONTROL_EX_PDR;
> +	val &= ~(CONTROL_EX_PDR | CONTROL_MIL);
>  	priv->write_reg(priv, C_CAN_CTRL_EX_REG, val);
>  	val = priv->read_reg(priv, C_CAN_CTRL_REG);
>  	val &= ~CONTROL_INIT;
> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> index c56f1b1..10c3fd2 100644
> --- a/drivers/net/can/c_can/c_can.h
> +++ b/drivers/net/can/c_can/c_can.h
> @@ -78,6 +78,7 @@ enum reg {
>  	C_CAN_INTPND2_REG,
>  	C_CAN_MSGVAL1_REG,
>  	C_CAN_MSGVAL2_REG,
> +	C_CAN_FUNCTION_REG,
>  };
>  
>  static const u16 reg_map_c_can[] = {
> @@ -129,6 +130,7 @@ static const u16 reg_map_d_can[] = {
>  	[C_CAN_BRPEXT_REG]	= 0x0E,
>  	[C_CAN_INT_REG]		= 0x10,
>  	[C_CAN_TEST_REG]	= 0x14,
> +	[C_CAN_FUNCTION_REG]	= 0x18,
>  	[C_CAN_TXRQST1_REG]	= 0x88,
>  	[C_CAN_TXRQST2_REG]	= 0x8A,
>  	[C_CAN_NEWDAT1_REG]	= 0x9C,
> @@ -188,6 +190,8 @@ struct c_can_priv {
>  	u32 comm_rcv_high;
>  	u32 rxmasked;
>  	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
> +	u32 (*read_reg32) (struct c_can_priv *priv, enum reg index);
> +	void (*write_reg32) (struct c_can_priv *priv, enum reg index, u32 val);
>  };
>  
>  struct net_device *alloc_c_can_dev(void);
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index 1df0b32..476d1e0 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -40,6 +40,7 @@
>  #define CAN_RAMINIT_START_MASK(i)	(0x001 << (i))
>  #define CAN_RAMINIT_DONE_MASK(i)	(0x100 << (i))
>  #define CAN_RAMINIT_ALL_MASK(i)		(0x101 << (i))
> +#define DCAN_RAM_INIT_BIT	(1 << 3)
>  static DEFINE_SPINLOCK(raminit_lock);
>  /*
>   * 16-bit c_can registers can be arranged differently in the memory
> @@ -80,7 +81,7 @@ static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
>  		udelay(1);
>  }
>  
> -static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
> +static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
>  {
>  	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
>  	u32 ctrl;
> @@ -88,7 +89,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>  	spin_lock(&raminit_lock);
>  
>  	ctrl = readl(priv->raminit_ctrlreg);
> -	/* We clear the done and start bit first. The start bit is
> +	/*
> +	 * We clear the done and start bit first. The start bit is
>  	 * looking at the 0 -> transition, but is not self clearing;
>  	 * And we clear the init done bit as well.
>  	 */
> @@ -108,6 +110,54 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>  	spin_unlock(&raminit_lock);
>  }
>  
> +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
> +{
> +	u32 ctrl;
> +
> +	spin_lock(&raminit_lock);
> +
> +	ctrl = readl(priv->raminit_ctrlreg);
> +	ctrl &= ~DCAN_RAM_INIT_BIT;
> +	writel(ctrl, priv->raminit_ctrlreg);
> +	c_can_hw_raminit_wait(priv, ctrl, 0);
> +
> +	if (enable) {
> +		/* Set start bit. */
> +		ctrl |= DCAN_RAM_INIT_BIT;
> +		writel(ctrl, priv->raminit_ctrlreg);
> +		c_can_hw_raminit_wait(priv, ctrl, 0);
> +	}
> +	spin_unlock(&raminit_lock);
> +}
> +
> +static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
> +{
> +	u32 val;
> +
> +	val = priv->read_reg(priv, index);
> +	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
> +
> +	return val;
> +}
> +
> +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
> +		u32 val)
> +{
> +	priv->write_reg(priv, index + 1, val>>16);
> +	priv->write_reg(priv, index, val);
> +}
> +
> +static u32 d_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
> +{
> +	return readl(priv->base + priv->regs[index]);
> +}
> +
> +static void d_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
> +		u32 val)
> +{
> +	writel(val, priv->base + priv->regs[index]);
> +}
> +
>  static struct platform_device_id c_can_id_table[] = {
>  	[BOSCH_C_CAN_PLATFORM] = {
>  		.name = KBUILD_MODNAME,
> @@ -201,11 +251,15 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  		case IORESOURCE_MEM_32BIT:
>  			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
>  			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
> +			priv->read_reg32 = c_can_plat_read_reg32;
> +			priv->write_reg32 = c_can_plat_write_reg32;
>  			break;
>  		case IORESOURCE_MEM_16BIT:
>  		default:
>  			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>  			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
> +			priv->read_reg32 = c_can_plat_read_reg32;
> +			priv->write_reg32 = c_can_plat_write_reg32;
>  			break;
>  		}
>  		break;
> @@ -214,6 +268,8 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>  		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>  		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
> +		priv->read_reg32 = d_can_plat_read_reg32;
> +		priv->write_reg32 = d_can_plat_write_reg32;
>  
>  		if (pdev->dev.of_node)
>  			priv->instance = of_alias_get_id(pdev->dev.of_node, "d_can");
> @@ -221,11 +277,22 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  			priv->instance = pdev->id;
>  
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		/*
> +		 * Not all D_CAN module have a separate register for the D_CAN
> +		 * RAM initialization. Use default RAM init bit in D_CAN module
> +		 * if not specified in DT.
> +		 */
> +		if (!res) {
> +			priv->raminit = c_can_hw_raminit;
> +			priv->raminit_ctrlreg = addr + priv->regs[C_CAN_FUNCTION_REG];
> +			break;
> +		}
> +
>  		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
>  		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
>  			dev_info(&pdev->dev, "control memory is not used for raminit\n");
>  		else
> -			priv->raminit = c_can_hw_raminit;
> +			priv->raminit = c_can_hw_raminit_ti;
>  		break;
>  	default:
>  		ret = -EINVAL;
> 
> 

