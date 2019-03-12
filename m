From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v8 1/4] can: m_can: Create a m_can platform framework
Date: Tue, 12 Mar 2019 08:17:43 -0500
Message-ID: <ca927ad9-709f-6817-7130-488ad0bbbbbf@ti.com>
References: <20190312121254.8043-1-dmurphy@ti.com>
 <da6a94ba-e843-891f-cbbc-9ba1e9324f77@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <da6a94ba-e843-891f-cbbc-9ba1e9324f77@grandegger.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Wolfgang

On 3/12/19 7:43 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 12.03.19 um 13:12 schrieb Dan Murphy:
>> Create a m_can platform framework that peripherial
>> devices can register to and use common code and register sets.
>> The peripherial devices may provide read/write and configuration
>> support of the IP.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
>> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
>>
>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>
>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>  drivers/net/can/m_can/Makefile         |   1 +
>>  drivers/net/can/m_can/m_can.c          | 717 +++++++++++++------------
>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>  5 files changed, 699 insertions(+), 344 deletions(-)
>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>
>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>> index 04f20dd39007..f7119fd72df4 100644
>> --- a/drivers/net/can/m_can/Kconfig
>> +++ b/drivers/net/can/m_can/Kconfig
>> @@ -1,5 +1,14 @@
>>  config CAN_M_CAN
>> +	tristate "Bosch M_CAN support"
>> +	---help---
>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>> +
>> +config CAN_M_CAN_PLATFORM
>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>  	depends on HAS_IOMEM
>> -	tristate "Bosch M_CAN devices"
>> +	depends on CAN_M_CAN
>>  	---help---
>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>> +	  This support is for devices that have the Bosch M_CAN controller
>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>> index 8bbd7f24f5be..057bbcdb3c74 100644
>> --- a/drivers/net/can/m_can/Makefile
>> +++ b/drivers/net/can/m_can/Makefile
>> @@ -3,3 +3,4 @@
>>  #
>>  
>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
> 
> ... snip ...
> 
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> -static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
>> -			   void __iomem *addr)
>> +static int m_can_dev_setup(struct m_can_priv *m_can_dev)
>>  {
>> -	struct m_can_priv *priv;
>> +	struct net_device *dev = m_can_dev->net;
>>  	int m_can_version;
>>  
>> -	m_can_version = m_can_check_core_release(addr);
>> +	m_can_version = m_can_check_core_release(m_can_dev);
> 
> What is m_can_version for the tcan4x5x?
> 

I believe it is Bosch M-CAN Revision 3.2.1.1

> ... snip ...
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
