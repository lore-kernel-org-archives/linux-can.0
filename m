From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
Date: Wed, 10 Apr 2019 20:11:49 +0200
Message-ID: <baad1868-d5aa-b4f4-0065-c6963b441403@hartkopp.net>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
 <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 10.04.19 09:19, Marc Kleine-Budde wrote:
> On 4/10/19 8:27 AM, Joakim Zhang wrote:
>> CAN driver always writes registers according to "ctrlmode", and now CAN
>> framework will keep CAN ctrlmode after device closed.
>>
>> e.g. with following sequences:
>> 1)ip link set can0 type can bitrate 1000000 loopback on
>> 2)ip link set can0 up
>> 3)ip link set can0 down
>> 4)ip link set can0 type can bitrate 1000000
>> 5)ip link set can0 up
>>
>> After this sequence, we may want to test loopback for the first time and
>> not to test loopback second time. However, CAN device still keep
>> "ctrlmode" as loopback on.
> 
> Then you should configure loopback off in userspace.

ACK!

The idea is that you can set a CAN interface like this:

ip link set can0 type can bitrate 1000000 loopback on

(..)

ip link set can0 down
ip link set can0 up

and none of the configuration changes in the meanwhile.

Regards,
Oliver

> 
>> This patch intends to clean up CAN ctrlmode when close CAN device. We
>> can set which ctrlmode we need when open CAN device again.
> 
> Consider a CANFD device, where CANFD has been enabled. It will feel very
> weird if the interface looses the CANFD property by just a ifdown; ifup.
> 
>>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>   drivers/net/can/dev.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index c05e4d50d43d..4f69a8f16ba3 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -870,6 +870,7 @@ void close_candev(struct net_device *dev)
>>   	struct can_priv *priv = netdev_priv(dev);
>>   
>>   	cancel_delayed_work_sync(&priv->restart_work);
>> +	priv->ctrlmode = 0;
>>   	can_flush_echo_skb(dev);
>>   }
>>   EXPORT_SYMBOL_GPL(close_candev);
>>
> 
> Marc
> 
