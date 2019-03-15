From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v9 1/4] can: m_can: Create a m_can platform framework
Date: Fri, 15 Mar 2019 09:51:55 -0500
Message-ID: <af88fad4-37a9-1ccb-0e06-70db34fff562@ti.com>
References: <20190313162629.11937-1-dmurphy@ti.com>
 <87f14a09-244e-c698-1372-f8b49e60faee@grandegger.com>
 <a578dd22-a581-8421-fac4-605fa8f63d1a@ti.com>
 <470e0028-7e4c-b1ba-7c50-7464f4904801@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <470e0028-7e4c-b1ba-7c50-7464f4904801@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 3/14/19 9:38 AM, Wolfgang Grandegger wrote:
> Hello,
> 
> Am 14.03.19 um 15:04 schrieb Dan Murphy:
>> Hello
>>
>> On 3/14/19 2:26 AM, Wolfgang Grandegger wrote:
>>> Hello Dan,
>>>
>>> we are close...
>>>
>>> Am 13.03.19 um 17:26 schrieb Dan Murphy:
>>>> Create a m_can platform framework that peripherial
>>>> devices can register to and use common code and register sets.
>>>> The peripherial devices may provide read/write and configuration
>>>> support of the IP.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>
>>>> v9 - Added back the CSR clearing as this is needed for TCAN device, fixed clean
>>>> function to clean index for version > 30, removed extra skb free and fixed work
>>>> handler to handle FIFO full for perpheral devices - https://lore.kernel.org/patchwork/patch/1050120/
>>>>
>>>> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
>>>> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
>>>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>>>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>>
>>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>>  drivers/net/can/m_can/m_can.c          | 733 +++++++++++++------------
>>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>>>  5 files changed, 714 insertions(+), 345 deletions(-)
>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>
>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>> index 04f20dd39007..f7119fd72df4 100644
>>>> --- a/drivers/net/can/m_can/Kconfig
>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>> @@ -1,5 +1,14 @@
>>>>  config CAN_M_CAN
>>>> +	tristate "Bosch M_CAN support"
>>>> +	---help---
>>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>>> +
>>>> +config CAN_M_CAN_PLATFORM
>>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>>  	depends on HAS_IOMEM
>>>> -	tristate "Bosch M_CAN devices"
>>>> +	depends on CAN_M_CAN
>>>>  	---help---
>>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>>> +	  This support is for devices that have the Bosch M_CAN controller
>>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
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
>>>> index 9b449400376b..56336aefc567 100644
>>>> --- a/drivers/net/can/m_can/m_can.c
>>>> +++ b/drivers/net/can/m_can/m_can.c
> ...  snip ...
> 
>>>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>> +				    struct net_device *dev)
>>>> +{
>>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>>> +
>>>> +	if (can_dropped_invalid_skb(dev, skb))
>>>> +		return NETDEV_TX_OK;
>>>> +
>>>> +	if (priv->is_peripherial) {
>>>> +		if (priv->tx_skb) {
>>>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>>>> +			return NETDEV_TX_BUSY;
>>>> +		}
>>>> +
>>>> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
>>>> +			m_can_clean(dev);
>>>> +		} else {
>>>> +			priv->tx_skb = skb;
>>>> +			queue_work(priv->tx_wq, &priv->tx_work);
>>>
>>> You removed "netif_stop_queue(cdev->net)" here. Does that work with just
>>> *one* "tx_skb"? I think you need an array then!? I'm afraid, this will
>>> require quite some changes and you should also measure the benefit of
>>> queuing outgoing messages first. For the time being, it would be fine
>>> for me to stop the queue here and add an appropriate comment.
>>>
>>
>> Yes I removed this in favor of allowing the work handler to stop the queue.
>>
>> If the version is < 30 then the queue is stopped immediately.  If the version > 30 then the queue is
>> only stopped if FIFO is full.
> 
> Yes, and the next call to m_can_start_xmit() will probably return with
> NETDEV_TX_BUSY. You should at least add a "netif_stop_queue(cdev->net)"
> before returning NETDEV_TX_BUSY, otherwice the upper layer will retry
> immediately resulting in high CPU load. Anyway, the purpose of this
> return code is to signal errors/bugs in the start/stop flow control:
> 

Ack

> https://elixir.bootlin.com/linux/latest/source/Documentation/networking/netdevices.txt#L81
> 
>>
>> I did see the message "tcan4x5x spi1.0 can0: hard_xmit called while tx busy" 
>> more with no gap and no polling in the cangen request.
> 
> You usually should never see that message.
> 
>>
>>> BTW, how big is the FIFO size on your system:
>>>
>>
>> This value is set to 1.
>>
>>>   tx_fifo_size = mram_config_vals[7];
> 
> Then I'm surprised that you see "hard_xmit called while tx busy" at all.
> Are you sure that "cdev->version" is 32 on the tcan4x5?
> 

tcan4x5x spi1.0 can0: Version of M_CAN is 32

> Wolfgang
> 


-- 
------------------
Dan Murphy
