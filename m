From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v6 1/6] can: dev: Add support for limiting configured
 bitrate
Date: Wed, 3 Jan 2018 17:49:33 +0530
Message-ID: <b023ccf0-ec9b-30b9-f868-aaf7286df247@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
 <b3cb6058-f61f-b643-a26f-c8330d9a3ffa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b3cb6058-f61f-b643-a26f-c8330d9a3ffa@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

Hi Marc,

On Tuesday 02 January 2018 06:30 PM, Marc Kleine-Budde wrote:
> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>
>> Various CAN or CAN-FD IP may be able to run at a faster rate than
>> what the transceiver the CAN node is connected to. This can lead to
>> unexpected errors. However, CAN transceivers typically have fixed
>> limitations and provide no means to discover these limitations at
>> runtime. Therefore, add support for a can-transceiver node that
>> can be reused by other CAN peripheral drivers to determine for both
>> CAN and CAN-FD what the max bitrate that can be used. If the user
>> tries to configure CAN to pass these maximum bitrates it will throw
>> an error.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> [nsekhar@ti.com: fix build error with !CONFIG_OF]
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>> v6 changes:
>> fix build error with !CONFIG_OF
>>
>>  drivers/net/can/dev.c   | 39 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/can/dev.h |  8 ++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index 365a8cc..007cfc0 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/can/skb.h>
>>  #include <linux/can/netlink.h>
>>  #include <linux/can/led.h>
>> +#include <linux/of.h>
>>  #include <net/rtnetlink.h>
>>  
>>  #define MOD_DESC "CAN device driver interface"
>> @@ -814,6 +815,30 @@ int open_candev(struct net_device *dev)
>>  }
>>  EXPORT_SYMBOL_GPL(open_candev);
>>  
>> +#ifdef CONFIG_OF
>> +/*
>> + * Common function that can be used to understand the limitation of
>> + * a transceiver when it provides no means to determine these limitations
>> + * at runtime.
>> + */
>> +void of_can_transceiver(struct net_device *dev)
>> +{
>> +	struct device_node *dn;
>> +	struct can_priv *priv = netdev_priv(dev);
>> +	struct device_node *np = dev->dev.parent->of_node;
>> +	int ret;
>> +
>> +	dn = of_get_child_by_name(np, "can-transceiver");
>> +	if (!dn)
>> +		return;
>> +
>> +	ret = of_property_read_u32(dn, "max-bitrate", &priv->max_bitrate);
>> +	if ((ret && ret != -EINVAL) || (!ret && !priv->max_bitrate))
>> +		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
>> +}
>> +EXPORT_SYMBOL_GPL(of_can_transceiver);
>> +#endif
>> +
>>  /*
>>   * Common close function for cleanup before the device gets closed.
>>   *
>> @@ -913,6 +938,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>  					priv->bitrate_const_cnt);
>>  		if (err)
>>  			return err;
>> +
>> +		if (priv->max_bitrate && bt.bitrate > priv->max_bitrate) {
>> +			netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
>> +				   priv->max_bitrate);
>> +			return -EINVAL;
>> +		}
> 
> What about movong this check into can_get_bittiming()? Although we loose
> the "arbitration" vs "canfd data".

I would prefer to keep the distinction.

> 
>> +
>>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>  
>>  		if (priv->do_set_bittiming) {
>> @@ -997,6 +1029,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>  					priv->data_bitrate_const_cnt);
>>  		if (err)
>>  			return err;
>> +
>> +		if (priv->max_bitrate && dbt.bitrate > priv->max_bitrate) {
>> +			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
>> +				   priv->max_bitrate);
>> +			return -EINVAL;
>> +		}
>> +
>>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>>  
>>  		if (priv->do_set_data_bittiming) {
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 61f1cf2..fbb7810 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -48,6 +48,8 @@ struct can_priv {
>>  	unsigned int data_bitrate_const_cnt;
>>  	struct can_clock clock;
>>  
>> +	unsigned int max_bitrate;
> 
> Please make it an u32, name it "bitrate_max" and ...

Sure.

> 
>>> struct can_priv {
>>> 	struct net_device *dev;
>>> 	struct can_device_stats can_stats;
>>>
>>> 	struct can_bittiming bittiming, data_bittiming;
>>> 	const struct can_bittiming_const *bittiming_const,
>>> 		*data_bittiming_const;
>>> 	const u16 *termination_const;
>>> 	unsigned int termination_const_cnt;
>>> 	u16 termination;
>>> 	const u32 *bitrate_const;
>>> 	unsigned int bitrate_const_cnt;
>>> 	const u32 *data_bitrate_const;
>>> 	unsigned int data_bitrate_const_cnt;
> 
> ...move it here.

Ok.

Thanks,
Faiz
