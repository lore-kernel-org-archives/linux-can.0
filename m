From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v5 2/5] can: m_can: Migrate the m_can code to use the
 framework
Date: Thu, 28 Feb 2019 13:59:29 -0600
Message-ID: <ac1c9949-7d41-cf4b-695d-1229ff2991ee@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <20190214182754.30721-3-dmurphy@ti.com>
 <0f5f732a-945c-da56-1086-00fb2c621331@grandegger.com>
 <639f316a-1190-1e0e-0a1d-6008a1c332d7@ti.com>
 <bae8adda-8cca-c865-d010-24084e13c2ce@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <bae8adda-8cca-c865-d010-24084e13c2ce@grandegger.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello

On 2/28/19 1:41 PM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 28.02.19 um 18:57 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 2/28/19 11:33 AM, Wolfgang Grandegger wrote:
>>> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>>>> Migrate the m_can code to use the m_can_platform framework
>>>> code.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v5 - Updated copyright, change m_can_classdev to m_can_priv, removed extra
>>>> KCONFIG flag - https://lore.kernel.org/patchwork/patch/1033095/
>>>>
>>>>  drivers/net/can/m_can/Kconfig  |   8 +-
>>>>  drivers/net/can/m_can/Makefile |   1 +
>>>>  drivers/net/can/m_can/m_can.c  | 745 ++++++++++++++++-----------------
>>>>  3 files changed, 367 insertions(+), 387 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>> index 04f20dd39007..66e31022a5fa 100644
>>>> --- a/drivers/net/can/m_can/Kconfig
>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>> @@ -1,5 +1,11 @@
>>>>  config CAN_M_CAN
>>>> +	tristate "Bosch M_CAN support"
>>>> +	---help---
>>>> +	  Say Y here if you want to support for Bosch M_CAN controller.
>>>
>>> Typo?
>>>
>>
>> Maybe like you pointed out to update the help.
> 
> I was just not sure if it's correct English... but you know better!
> 

I actually added some additional content explaining what the flag was for and remove the "to" 

>>
>>>> +
>>>> +config CAN_M_CAN_PLATFORM
>>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>>  	depends on HAS_IOMEM
>>>> -	tristate "Bosch M_CAN devices"
>>>> +	depends on CAN_M_CAN
>>>>  	---help---
>>>>  	  Say Y here if you want to support for Bosch M_CAN controller.
>>>
>>> Please update the help.
>>
>> Ack
>>>
>>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>>> --- a/drivers/net/can/m_can/Makefile
>>>> +++ b/drivers/net/can/m_can/Makefile
>>>> @@ -3,3 +3,4 @@
>>>>  #
>>>>  
>>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>>> index 9b449400376b..2ceccb870557 100644
>>>> --- a/drivers/net/can/m_can/m_can.c
>>>> +++ b/drivers/net/can/m_can/m_can.c
> ... snip ...
>>>> @@ -924,6 +885,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>>>>  		}
>>>>  	}
>>>>  
>>>> +	if (priv->ops->clr_dev_interrupts)
>>>> +		priv->ops->clr_dev_interrupts(priv);
>>>
>>> post_irq _handler?
>>>
>>
>> I can clear them on entry as well
> 
> OK!
> 
> ...snip...
> 
>>>> -	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
>>>> -					  (cccr_poll == cccr_reg), 0, 10);
>>>> +	for (i = 0; i <= 10; i++) {
>>>> +		cccr_poll = m_can_read(priv, M_CAN_CCCR);
>>>> +		if (cccr_poll == cccr_reg)
>>>> +			niso_timeout = 0;
>>>> +	}
>>>
>>> There is no break and delay in the loop? What was the reason why you
>>> can't use readl_poll_timeout()?
>>>
>>
>> OK a break if NISO is supported then and probably could add a 1us delay original code on
>> line 1232 had no delay but timeout at 10us.
>>
>> readl_poll_timeout is for iomapped devices.  How would this work for peripherial devices?
> 
> Well, it takes much more time to read the register via SPI... maybe using
> 
> 	if (priv->is_peripherial) ...
> 
> to handle the different timings would make sense here.
> 

We really should isolate IO access calls away from the framework and have the registrars perform all
IO calls.

It may be better to create a call back to check for NISO support but I would think only IO mapped
code is the only special case.

Also a call back may be a bit much since this NISO function is only called in setup which is a one and done
function during registration.



>>>>  
>>>>  	/* Clear NISO */
>>>>  	cccr_reg &= ~(CCCR_NISO);
>>>> @@ -1242,107 +1210,95 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
>>>>  	return !niso_timeout;
>>>>  }
> ... snip...
> 
>>>> -static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>> -				    struct net_device *dev)
>>>> +static void m_can_tx_handler(struct m_can_priv *priv)
>>>>  {
>>>> -	struct m_can_priv *priv = netdev_priv(dev);
>>>> -	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>>>> +	struct canfd_frame *cf = (struct canfd_frame *)priv->skb->data;
>>>> +	struct net_device *dev = priv->net;
>>>> +	struct sk_buff *skb = priv->skb;
>>>
>>> Maybe "tx_skb" is a clearer member name..
>>
>> Again this was named skb to minimize deltas from original code.
> 
> I mean "priv->tx_skb"!
> 

Ack.  Changed for clarity I guess your point was made in my own confusion (heh).

Dan

>> skb was passed into the start_xmit function and used throughout the function.
>>
>> Since there was little delta in this function I opt'd to keep the names as is.
>>
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
