From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
Date: Mon, 4 Mar 2019 19:13:42 +0100
Message-ID: <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
 <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 04.03.19 um 18:22 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/4/19 10:56 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> the series already looks quite good. I still realized a few (minor)
>> issues while browsing the patch/code...
>>
> 
> Thanks for the review.  It is getting there.
> 
>> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>>> Create a m_can platform framework that peripherial
>>> devices can register to and use common code and register sets.
>>> The peripherial devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>
>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>  drivers/net/can/m_can/m_can.c          | 702 +++++++++++++------------
>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>  drivers/net/can/m_can/m_can_platform.c | 198 +++++++
>>>  5 files changed, 681 insertions(+), 343 deletions(-)
>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>
>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>> index 04f20dd39007..f7119fd72df4 100644
>>> --- a/drivers/net/can/m_can/Kconfig
>>> +++ b/drivers/net/can/m_can/Kconfig
>>> @@ -1,5 +1,14 @@
>>>  config CAN_M_CAN
>>> +	tristate "Bosch M_CAN support"
>>> +	---help---
>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>> +
>>> +config CAN_M_CAN_PLATFORM
>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>  	depends on HAS_IOMEM
>>> -	tristate "Bosch M_CAN devices"
>>> +	depends on CAN_M_CAN
>>>  	---help---
>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>> +	  This support is for devices that have the Bosch M_CAN controller
>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>> --- a/drivers/net/can/m_can/Makefile
>>> +++ b/drivers/net/can/m_can/Makefile
>>> @@ -3,3 +3,4 @@
>>>  #
>>>  
>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>> index 9b449400376b..b37d0886f9cb 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c

...snip...

>>> @@ -1451,7 +1459,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>  			netif_stop_queue(dev);
>>>  			netdev_warn(dev,
>>>  				    "TX queue active although FIFO is full.");
>>> -			return NETDEV_TX_BUSY;
>>> +			return;
>>
>> m_can_start_xmit() doesn't return NETDEV_TX_BUSY but NETDEV_TX_OK and
>> the queue is stopped! Also the skb is not freed! The code states 
>> "/* This shouldn't happen */" but then it just prints a warning. Did
>> you see that message?
>>
> 
> No I have not seen this warning but I will re-check to be sure.

If we don't return NETDEV_TX_BUSY but NETDEV_TX_OK, we must handle it
differently.

...snip...

>>> +struct m_can_priv;
>>> +struct m_can_ops {
>>> +	/* Device specific call backs */
>>> +	int (*clr_dev_interrupts)(struct m_can_priv *m_can_class);
>>
>> Why not just "clear_interrupt"... to be consistant with the names below.
> 
> I wanted to be clear in the M_CAN code that these are device interrupts and not M_CAN interrupts.
> 
> I can change it to clear_interrupt if you think it makes more sense.

Well, like for "read_reg" etc, I think it's clear that it's a
device-specific function/ops:

	cdev->read_reg
	cdev->clear_interrupt

>>> +	u32 (*read_reg)(struct m_can_priv *m_can_class, int reg);
>>> +	int (*write_reg)(struct m_can_priv *m_can_class, int reg, int val);
>>> +	u32 (*read_fifo)(struct m_can_priv *m_can_class, int addr_offset);
>>> +	int (*write_fifo)(struct m_can_priv *m_can_class, int addr_offset,
>>> +			  int val);
>>> +	int (*device_init)(struct m_can_priv *m_can_class);

And the same here:

	cdev->init

>>> +	int pm_clock_support;
>>
>> A "bool" would be more appropriate, I think.
> 
> 
> I was abiding by this checkpatch warning I got on the is_peripherial.
> 
> CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
> #94: FILE: drivers/net/can/m_can/m_can.h:94:
> +	bool is_peripherial;
> 

Ah, right! I was also surprised to get that warning. The kernel is full
of bool's, but well, we should make "checkpatch" happy (and Linus).

Wolfgang
