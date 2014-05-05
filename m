From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] hwinit support for non-TI devices
Date: Mon, 05 May 2014 14:22:51 +0200
Message-ID: <5367829B.4000104@pengutronix.de>
References: <20140426203131.GA21832@amd.pavel.ucw.cz> <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com> <20140427122510.GB12901@amd.pavel.ucw.cz> <1398716449.836.4.camel@dinh-ubuntu> <20140428211505.GA28242@amd.pavel.ucw.cz> <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com> <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com> <20140430215359.GA15148@amd.pavel.ucw.cz> <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com> <20140502084851.GA5730@amd.pavel.ucw.cz> <20140505120810.GB16461@amd.pavel.ucw.cz> <5367824D.2070406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48379 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbaEEMW7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 May 2014 08:22:59 -0400
In-Reply-To: <5367824D.2070406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>, Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

On 05/05/2014 02:21 PM, Marc Kleine-Budde wrote:
> On 05/05/2014 02:08 PM, Pavel Machek wrote:
>> Non-TI chips (including socfpga) needs different raminit
>> sequence. Implement it.
>>
>> Tested-by: Thor Thayer <tthayer@altera.com>
>> Signed-off-by: Thor Thayer <tthayer@altera.com>
>> Signed-off-by: Pavel Machek <pavel@denx.de>
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>> index 1df0b32..476d1e0 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -40,6 +40,7 @@
>>  #define CAN_RAMINIT_START_MASK(i)	(0x001 << (i))
>>  #define CAN_RAMINIT_DONE_MASK(i)	(0x100 << (i))
>>  #define CAN_RAMINIT_ALL_MASK(i)		(0x101 << (i))
>> +#define DCAN_RAM_INIT_BIT	(1 << 3)
>>  static DEFINE_SPINLOCK(raminit_lock);
>>  /*
>>   * 16-bit c_can registers can be arranged differently in the memory
>> @@ -80,7 +81,7 @@ static void c_can_hw_raminit_wait(const struct c_can_priv *priv, u32 mask,
>>  		udelay(1);
>>  }
>>  
>> -static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>> +static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
>>  {
>>  	u32 mask = CAN_RAMINIT_ALL_MASK(priv->instance);
>>  	u32 ctrl;
>> @@ -88,7 +89,8 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>>  	spin_lock(&raminit_lock);
>>  
>>  	ctrl = readl(priv->raminit_ctrlreg);
>> -	/* We clear the done and start bit first. The start bit is
>> +	/*
>> +	 * We clear the done and start bit first. The start bit is
> 
> Please don't reformat comments.
> 
>>  	 * looking at the 0 -> transition, but is not self clearing;
>>  	 * And we clear the init done bit as well.
>>  	 */
>> @@ -108,6 +110,54 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>>  	spin_unlock(&raminit_lock);
>>  }
>>  
>> +static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
>> +{
>> +	u32 ctrl;
>> +
>> +	spin_lock(&raminit_lock);
> 
> Why do you need this spinlock?
> 
>> +
>> +	ctrl = readl(priv->raminit_ctrlreg);
>> +	ctrl &= ~DCAN_RAM_INIT_BIT;
>> +	writel(ctrl, priv->raminit_ctrlreg);
> 
> Why don't use use the reg directly? Have you read my previous review?
> 
>> +	c_can_hw_raminit_wait(priv, ctrl, 0);
>> +
>> +	if (enable) {
>> +		/* Set start bit. */
>> +		ctrl |= DCAN_RAM_INIT_BIT;
>> +		writel(ctrl, priv->raminit_ctrlreg);
>> +		c_can_hw_raminit_wait(priv, ctrl, 0);
>> +	}
>> +	spin_unlock(&raminit_lock);
>> +}
>> +
>> +static u32 c_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
>> +{
>> +	u32 val;
>> +
>> +	val = priv->read_reg(priv, index);
>> +	val |= ((u32) priv->read_reg(priv, index + 1)) << 16;
>> +
>> +	return val;
>> +}
> 
> Why are you adding the read32() support here? Your commit message
> doesn't mention it. Please move this into a different patch.
> 
>> +
>> +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
>> +		u32 val)
>> +{
>> +	priv->write_reg(priv, index + 1, val>>16);
>> +	priv->write_reg(priv, index, val);
>> +}
>> +
>> +static u32 d_can_plat_read_reg32(struct c_can_priv *priv, enum reg index)
>> +{
>> +	return readl(priv->base + priv->regs[index]);
>> +}
>> +
>> +static void d_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
>> +		u32 val)
>> +{
>> +	writel(val, priv->base + priv->regs[index]);
>> +}
>> +
>>  static struct platform_device_id c_can_id_table[] = {
>>  	[BOSCH_C_CAN_PLATFORM] = {
>>  		.name = KBUILD_MODNAME,
>> @@ -201,11 +251,15 @@ static int c_can_plat_probe(struct platform_device *pdev)
>>  		case IORESOURCE_MEM_32BIT:
>>  			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
>>  			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
>> +			priv->read_reg32 = c_can_plat_read_reg32;
>> +			priv->write_reg32 = c_can_plat_write_reg32;

This will not compile.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
