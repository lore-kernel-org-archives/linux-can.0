Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23513D567F;
	Wed,  5 Aug 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964018; cv=none; b=Tbdb6xxUIvSpw8ANg6+5xiSnDZ9c08HOFMtISyRRLF2WQPI6FdCrww5H9IW3QnDHiVm9zpwfPm/jV9uupoqeiJ2jsnvaqwcjxv4bvs4R4p11VoEKacBlbfq4BuTlttVmozE29mF/mWOfUzm3pdgo83wpkGFXbnVMotrpSpHbxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964018; c=relaxed/simple;
	bh=tM1D5miOwAd4ZZK+LQ5w4Cefp+GUEO256M7lGXhvzeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDW3H4/ZLXLzUYqWf82Mas3qxQSxxo9+i6pboBkeWrxeFguePi/LxCWkhbqvHHWqDR2Ko6ygBd/pKgmRqlC/hO7FAWolW/qcF2YN2hKP3DLELwNnidMTGyjDTBH1edEffTrPeC+hMZCPWPY/tJo4RfOaca5qWA3Sn+FPuEul0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUYA+89j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUYA+89j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685621F000E9;
	Wed,  5 Aug 2026 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964016;
	bh=DbwZRIFAm0/XfsI9rea3H5lKmlOhTjfrkkCobwtBKhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VUYA+89jaMWVtLJdFxve7mGp2R0jjVHZc96vvOeqE3WkzwjbusktLSaA2Kt7EPkF3
	 ieXKSGOuRy8/RFhLRsIybHRZFovbcPkd/O2oSrYakNGQjToBucJCj+fjMAwpJMN6vu
	 4TddFLmsdxI1HzJekmuoGbODpNbZXPBJvctQm8p5ql7mWy335mXZXEAbBOjXUxwn8l
	 nMaSb39m2SzKPxSF4CAsTP6oPJ5gsQke/scrhpGfaNl9x+uWGRryGJ9H00VTaAeFTX
	 6oongpQiHQx/sbOiy25/4hMcKiKXDuSfnxhbcLpfTjzkwidflllRGiUvSBKcFxO2kJ
	 w9narahJ6AGUA==
Message-ID: <95290e92-68c4-4ce7-8a1a-7d23b0a268d5@kernel.org>
Date: Wed, 5 Aug 2026 23:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
 <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
 <6800934d-2da2-4eeb-8514-3978f4c7b307@kernel.org>
 <c487793e-df15-4b32-9cfd-dd72648a8af2@hartkopp.net>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <c487793e-df15-4b32-9cfd-dd72648a8af2@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2026 at 18:17, Oliver Hartkopp wrote:
> On 05.08.26 09:25, Vincent Mailhol wrote:
>> On 05/08/2026 at 08:29, Oliver Hartkopp wrote:
> 
>>> I prefer this conscious setting in the driver setup. We should better
>>> add proper comments in drivers that do not set the flag, e.g. in slcan.c
>>> there's no hint that the af_can.c echo feature is used.
>>
>> Then, what about setting IFF_ECHO for *all* drivers by default in
>> can_setup() and let the ones which have a special need to opt-out:
>>
>>    dev->flags &= ~IFF_ECHO;
>>
> 
> This looks like a hack reverting bit settings.

This was more to bounce on your remark that we need proper comments. I
still prefer a line of code rather than a comment tight to nothing.

But IFF_ECHO is the symptom, not the root cause. It is probably not this
part which needs to be commented but the overall skb echo logic.

>> This way it remains transparent which one support IFF_ECHO or not. It is
>> also more important to highlight when things are done differently
>> (IFF_ECHO off) than when things go the normal case (IFF_ECHO on).
>>
>> And this is more aligned with IFF_NOARP (c.f. you other message) in the
>> sense that both flags would now be set by default by the framework. It
>> looks odd to me that IFF_NOARP should be set by default by the framework
>> but not IFF_ECHO.
> 
> I'm not really done with my thoughts but ...
> 
> IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO
> flag and the default queue len.

For IFF_ECHO, this is exactly what this series does!

For the default queue len, why not. I have not study this particular
topic. But I think the IFF_ECHO and the queue len should be in separate
series.

> What puzzles me is that the slcan driver is something in between which
> is neither a real CAN hardware nor a virtual CAN interface.

My understanding it that devices which do not have a TX completion
handler (like slcan or can327) have no benefits to implement the
echo_skb framework and can instead simply rely on the PF_CAN core.

> My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only for
> real CAN hardware devices and open code slcan and the virtual CAN
> drivers ... which goes into the direction below.
> 
> Any thoughts?

The logic I tried to follow in this series is that alloc_candev{,_mqs}()
has two arguments:

  1. one for the priv structure

  2. one for the number of echo_skb

But then, when 2. is zero:

  alloc_candev{,_mqs}(..., 0)

means to me: give me all the features expect from the echo_skb.

With the above, there is no anomalies to see the slcan do:

  dev = alloc_candev(sizeof(*sl), 0);

So I don't see the point to open code the allocations in slcan. After
patch #1 which corrects the echo skb count, the code describes correctly
the behaviour.

> Best regards,
> Oliver
> 
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c..5bdbe0c1d197 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -277,25 +277,10 @@ void can_bus_off(struct net_device *dev)
>          schedule_delayed_work(&priv->restart_work,
>                        msecs_to_jiffies(priv->restart_ms));
>  }
>  EXPORT_SYMBOL_GPL(can_bus_off);
> 
> -void can_setup(struct net_device *dev)
> -{
> -    dev->type = ARPHRD_CAN;
> -    dev->mtu = CAN_MTU;
> -    dev->min_mtu = CAN_MTU;
> -    dev->max_mtu = CAN_MTU;
> -    dev->hard_header_len = 0;
> -    dev->addr_len = 0;
> -    dev->tx_queue_len = 10;
> -
> -    /* New-style flags. */
> -    dev->flags = IFF_NOARP;
> -    dev->features = NETIF_F_HW_CSUM;
> -}
> -
>  /* Allocate and setup space for the CAN network device */
>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int
> echo_skb_max,
>                      unsigned int txqs, unsigned int rxqs)
>  {
>      struct can_ml_priv *can_ml;
> @@ -332,10 +317,13 @@ struct net_device *alloc_candev_mqs(int
> sizeof_priv, unsigned int echo_skb_max,
> 
>      can_ml = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
>      can_set_ml_priv(dev, can_ml);
>      can_set_cap(dev, CAN_CAP_CC);
> 
> +    dev->tx_queue_len = CAN_TX_QUEUE_LEN;



> +    dev->flags |= IFF_ECHO;

I really prefer to have the IFF_ECHO gated under the

	if (echo_skb_max) {

because it is tightly linked to the echo skb framework.

And yes, there are a couple drivers here and there which set IFF_ECHO
without using the echo skb framework. But these are the drivers which
implements their own custom echo skb logic. So it makes sense to have
them open code the IFF_ECHO because they are also open coding the rest
of the echo skb logic.

This goes back to my previous point that:

  alloc_candev{,_mqs}(..., 0)

means that the drivers do not use the framework echo skb. Such drivers
fall in two categories:

  - No echo skb at all (e.g. slcan or can327): no IFF_ECHO

  - custom echo skb (e.g. grcan, janz-ican3): everything is open coded
    -> explicit IFF_ECHO flag

>      if (echo_skb_max) {
>          priv->echo_skb_max = echo_skb_max;
>          priv->echo_skb = (void *)priv +
>              (size - echo_skb_max * sizeof(struct sk_buff *));
>      }
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index 76e6b7b5c6a1..70263813ec40 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -167,16 +167,15 @@ static const struct ethtool_ops vcan_ethtool_ops = {
>      .get_ts_info = ethtool_op_get_ts_info,
>  };
> 
>  static void vcan_setup(struct net_device *dev)
>  {
> -    dev->type        = ARPHRD_CAN;
> -    dev->mtu        = CANXL_MTU;
> -    dev->hard_header_len    = 0;
> -    dev->addr_len        = 0;
> -    dev->tx_queue_len    = 0;
> -    dev->flags        = IFF_NOARP;
> +    can_setup(dev);
> +    dev->tx_queue_len = 0;
> +    dev->mtu = CANXL_MTU;
> +    dev->min_mtu = CAN_MTU;
> +    dev->max_mtu = CANXL_MTU;
>      can_set_ml_priv(dev, netdev_priv(dev));
>      vcan_set_cap_info(dev);

In such example, please don't add parasite white space changes. It makes
it hard to grasp what you are actually modifying.

>      /* set flags according to driver capabilities */
>      if (echo)
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index e882250180ef..615a906203fa 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -180,19 +180,18 @@ static const struct ethtool_ops vxcan_ethtool_ops = {
> 
>  static void vxcan_setup(struct net_device *dev)
>  {
>      struct can_ml_priv *can_ml;
> 
> -    dev->type        = ARPHRD_CAN;
> -    dev->mtu        = CANXL_MTU;
> -    dev->hard_header_len    = 0;
> -    dev->addr_len        = 0;
> -    dev->tx_queue_len    = 0;
> -    dev->flags        = IFF_NOARP;
> -    dev->netdev_ops        = &vxcan_netdev_ops;
> -    dev->ethtool_ops    = &vxcan_ethtool_ops;
> -    dev->needs_free_netdev    = true;
> +    can_setup(dev);
> +    dev->tx_queue_len = 0;
> +    dev->mtu = CANXL_MTU;
> +    dev->min_mtu = CAN_MTU;
> +    dev->max_mtu = CANXL_MTU;
> +    dev->netdev_ops = &vxcan_netdev_ops;
> +    dev->ethtool_ops = &vxcan_ethtool_ops;
> +    dev->needs_free_netdev = true;
> 
>      can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv),
> NETDEV_ALIGN);
>      can_set_ml_priv(dev, can_ml);
>      vxcan_set_cap_info(dev);
>  }
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6d0710d6f571..4619a74599cb 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -21,10 +21,12 @@
>  #include <linux/can/netlink.h>
>  #include <linux/can/skb.h>
>  #include <linux/ethtool.h>
>  #include <linux/netdevice.h>
> 
> +#define CAN_TX_QUEUE_LEN 10 /* default length for hardware interfaces */
> +
>  /*
>   * CAN mode
>   */
>  enum can_mode {
>      CAN_MODE_STOP = 0,
> @@ -98,11 +100,23 @@ static inline u32 can_get_static_ctrlmode(struct
> can_priv *priv)
>  static inline bool can_is_canxl_dev_mtu(unsigned int mtu)
>  {
>      return (mtu >= CANXL_MIN_MTU && mtu <= CANXL_MAX_MTU);
>  }
> 
> -void can_setup(struct net_device *dev);
> +void can_setup(struct net_device *dev)
> +{
> +    dev->type = ARPHRD_CAN;
> +    dev->mtu = CAN_MTU;
> +    dev->min_mtu = CAN_MTU;
> +    dev->max_mtu = CAN_MTU;
> +    dev->hard_header_len = 0;
> +    dev->addr_len = 0;
> +
> +    /* New-style flags. */
> +    dev->flags = IFF_NOARP;
> +    dev->features = NETIF_F_HW_CSUM;
> +}

It is strange to have a non static inline function in a header. What was
the motivation for pulling this out of dev.c?

>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int
> echo_skb_max,
>                      unsigned int txqs, unsigned int rxqs);
>  #define alloc_candev(sizeof_priv, echo_skb_max) \
>      alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
> 


Yours sincerely,
Vincent Mailhol

