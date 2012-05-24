From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RESEND PATCH v3 5/5] can: c_can: Add support for Bosch D_CAN
 controller
Date: Thu, 24 May 2012 09:01:20 +0200
Message-ID: <4FBDDCC0.3020303@grandegger.com>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com> <1337775313-28219-6-git-send-email-anilkumar@ti.com> <4FBD3F32.3080104@grandegger.com> <4FBD4AEB.6000707@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41450 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2EXHBe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 03:01:34 -0400
In-Reply-To: <4FBD4AEB.6000707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

On 05/23/2012 10:39 PM, Marc Kleine-Budde wrote:
> On 05/23/2012 09:49 PM, Wolfgang Grandegger wrote:
>> Hi AnilKumar,
>>
>> I have some more comments...
>>
>> On 05/23/2012 02:15 PM, AnilKumar Ch wrote:
>>> This patch adds the support for D_CAN controller driver to the existing
>>> C_CAN driver.
>>>
>>> Bosch D_CAN controller is a full-CAN implementation which is compliant
>>> to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can be
>>> obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
>>> ipmodules_1/can/d_can_users_manual_111.pdf
>>>
>>> A new array is added for accessing the d_can registers, according to d_can
>>> controller register space.
>>>
>>> Current D_CAN implementation has following limitations, this is done
>>> to avoid large changes to the C_CAN driver.
>>> 1. Message objects are limited to 32, 16 for RX and 16 for TX. C_CAN IP
>>>    supports upto 32 message objects but in case of D_CAN we can configure
>>>    upto 128 message objects.
>>> 2. Using two 16bit reads/writes for accessing the 32bit D_CAN registers.
>>> 3. These patches have been tested on little endian machine, there might
>>>    be some hidden endian-related issues due to the nature of the accesses
>>>    (32-bit registers accessed as 2 16-bit registers). However, I do not
>>>    have a big-endian D_CAN implementation to confirm.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>> Link to previous submission
>>> 	http://marc.info/?l=linux-can&m=133690316927301&w=2
>>>
>>>  drivers/net/can/c_can/c_can.h          |   45 +++++++++++++++++++++++++++
>>>  drivers/net/can/c_can/c_can_platform.c |   52 ++++++++++++++++++++++++--------
>>>  2 files changed, 84 insertions(+), 13 deletions(-)
>>
>> You should also update the Kconfig entry, name and help.
>>
>>> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
>>> index d1e141e..01a7049 100644
>>> --- a/drivers/net/can/c_can/c_can.h
>>> +++ b/drivers/net/can/c_can/c_can.h
>>> @@ -102,6 +102,51 @@ static const u16 reg_map_c_can[] = {
>>>  	[C_CAN_MSGVAL2_REG]	= 0xB2,
>>>  };
>>>  
>>> +static const u16 reg_map_d_can[] = {
>>> +	[C_CAN_CTRL_REG]	= 0x00,
>>> +	[C_CAN_STS_REG]		= 0x04,
>>> +	[C_CAN_ERR_CNT_REG]	= 0x08,
>>> +	[C_CAN_BTR_REG]		= 0x0C,
>>> +	[C_CAN_BRPEXT_REG]	= 0x0E,
>>> +	[C_CAN_INT_REG]		= 0x10,
>>> +	[C_CAN_TEST_REG]	= 0x14,
>>> +	[C_CAN_TXRQST1_REG]	= 0x88,
>>> +	[C_CAN_TXRQST2_REG]	= 0x8A,
>>> +	[C_CAN_NEWDAT1_REG]	= 0x9C,
>>> +	[C_CAN_NEWDAT2_REG]	= 0x9E,
>>> +	[C_CAN_INTPND1_REG]	= 0xB0,
>>> +	[C_CAN_INTPND2_REG]	= 0xB2,
>>> +	[C_CAN_MSGVAL1_REG]	= 0xC4,
>>> +	[C_CAN_MSGVAL2_REG]	= 0xC6,
>>> +	[C_CAN_IF1_COMREQ_REG]	= 0x100,
>>> +	[C_CAN_IF1_COMMSK_REG]	= 0x102,
>>> +	[C_CAN_IF1_MASK1_REG]	= 0x104,
>>> +	[C_CAN_IF1_MASK2_REG]	= 0x106,
>>> +	[C_CAN_IF1_ARB1_REG]	= 0x108,
>>> +	[C_CAN_IF1_ARB2_REG]	= 0x10A,
>>> +	[C_CAN_IF1_MSGCTRL_REG]	= 0x10C,
>>> +	[C_CAN_IF1_DATA1_REG]	= 0x110,
>>> +	[C_CAN_IF1_DATA2_REG]	= 0x112,
>>> +	[C_CAN_IF1_DATA3_REG]	= 0x114,
>>> +	[C_CAN_IF1_DATA4_REG]	= 0x116,
>>> +	[C_CAN_IF2_COMREQ_REG]	= 0x120,
>>> +	[C_CAN_IF2_COMMSK_REG]	= 0x122,
>>> +	[C_CAN_IF2_MASK1_REG]	= 0x124,
>>> +	[C_CAN_IF2_MASK2_REG]	= 0x126,
>>> +	[C_CAN_IF2_ARB1_REG]	= 0x128,
>>> +	[C_CAN_IF2_ARB2_REG]	= 0x12A,
>>> +	[C_CAN_IF2_MSGCTRL_REG]	= 0x12C,
>>> +	[C_CAN_IF2_DATA1_REG]	= 0x130,
>>> +	[C_CAN_IF2_DATA2_REG]	= 0x132,
>>> +	[C_CAN_IF2_DATA3_REG]	= 0x134,
>>> +	[C_CAN_IF2_DATA4_REG]	= 0x136,
>>> +};
>>> +
>>> +enum c_can_dev_id {
>>> +	C_CAN_DEVTYPE,
>>
>> Should probably be:
>>
>> 	C_CAN_DEVTYPE = 0,
>>
>> for legacy C_CAN support.
> 
> I don't understand, what you mean by legacy support.

For legacy C_CAN we may not have id->driver_data set in the board code
and then it will fall back to the default value of 0, meaning C_CAN.
Maybe I have missed something...

> 
>>
>>> +	D_CAN_DEVTYPE,
>>> +};
>>> +
>>>  /* c_can private data structure */
>>>  struct c_can_priv {
>>>  	struct can_priv can;	/* must be the first member */
>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>>> index a6e9b93..3b1f6c7 100644
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -71,6 +71,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  	void __iomem *addr;
>>>  	struct net_device *dev;
>>>  	struct c_can_priv *priv;
>>> +	const struct platform_device_id *id;
>>>  	struct resource *mem;
>>>  	int irq;
>>>  #ifdef CONFIG_HAVE_CLK
>>> @@ -115,7 +116,32 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  	}
>>>  
>>>  	priv = netdev_priv(dev);
>>> -	priv->regs = reg_map_c_can;
>>> +	id = platform_get_device_id(pdev);
>>> +	switch (id->driver_data) {
>>> +	case C_CAN_DEVTYPE:
>>> +		priv->regs = reg_map_c_can;
>>> +		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
>>> +		case IORESOURCE_MEM_32BIT:
>>> +			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
>>> +			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
>>> +			break;
>>> +		case IORESOURCE_MEM_16BIT:
>>> +		default:
>>> +			priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>>> +			priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
>>> +			break;
>>> +		}
>>> +		break;
>>> +	case D_CAN_DEVTYPE:
>>> +		priv->regs = reg_map_d_can;
>>> +		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>>> +		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>>> +		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
>>> +		break;
>>> +	default:
>>> +		ret = -EINVAL;
>>> +		goto exit_free_device;
>>> +	}
>>>  
>>>  	dev->irq = irq;
>>>  	priv->base = addr;
>>> @@ -124,18 +150,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  	priv->priv = clk;
>>>  #endif
>>>  
>>> -	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
>>> -	case IORESOURCE_MEM_32BIT:
>>> -		priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
>>> -		priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
>>> -		break;
>>> -	case IORESOURCE_MEM_16BIT:
>>> -	default:
>>> -		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>>> -		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
>>> -		break;
>>> -	}
>>> -
>>>  	platform_set_drvdata(pdev, dev);
>>>  	SET_NETDEV_DEV(dev, &pdev->dev);
>>>  
>>> @@ -189,6 +203,17 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
>>>  	return 0;
>>>  }
>>>  
>>> +static const struct platform_device_id c_can_id_table[] = {
>>> +	{
>>> +		.name = "c_can_platform",
>>> +		.driver_data = C_CAN_DEVTYPE,
>>> +	}, {
>>> +		.name = "d_can_platform",
>>
>> s/_platform// !
> 
> I thought about removing the "_platform", too:
> 
> The driver is traditionally called KBUILD_MODNAME, which is
> "c_can_platform" in this case. So we need for compatibility a
> "c_can_platform" entry in the id_table.
> 
> If we have a "c_can" and a "d_can" entry, the driver would still match a
> "c_can_platform" device. The platform bus match function will first
> match the id_table, then the driver name [1]. However, only when
> matching via the id_table, the id_entry is set. So the driver will oops
> when "id" will be dereferenced above.

Ah, I was already wondering how that works... then my comments about
legacy C_CAN support do not apply.

> We have these options:
> a) use the patch as it is, with "c_can_platform" and "d_can_platform".
> b) have "c_can_platform" and "d_can", which I don't think is intuitive
> c) have "c_can_platform", "c_can" and "d_can"
> 
> [1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L660

I principle we could also use "c_can" and "d_can" and handle id=NULL as
legacy C_CAN driver using the legacy enum default above. Well, it seems
not to be the for-seen way to handle legacy devices. My concern is
"c_can_platform" in the DTS file and therefore I would vote for c).

Wolfgang.
