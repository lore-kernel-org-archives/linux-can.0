Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB7483BF0;
	Wed,  5 Aug 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947396; cv=pass; b=Bf0MY+fYgXjGdvv2eQnz2cSmGm9n5p03IJO/a/ea5trTaZNYkwDLmv5a9+LJCAMFImHcoEHpdevKILenqhPMPBiITM3tmHc2Orx3DVp9PKYgrtI1K85z3p3VbaCj2laMPGGKcAHp7Gx1qSvOubtk4VXfay2Mzl737/vnnZUmmJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947396; c=relaxed/simple;
	bh=SHShCHbJMZiPURNBD6DvXr4K49BghDlt7QQIAGcrk5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2NzoeYw3UjilAJD47xwJj71Il/jSIWfpiLmxO2YIIruR99SaiaJueopzOGmybXlPEtnZisMLifH2OBysru8v7eHm/STeWliTsT09SA+zcC95dmt5zbir1Td3t4afx0UBXWFaep3qzFkdv7yk18olrMlh/F/KYMzTxRh4VV4aJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=t02XQPLB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PKfB9YC0; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="t02XQPLB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PKfB9YC0"
ARC-Seal: i=1; a=rsa-sha256; t=1785946663; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YYyiObwvPKhEBiD+5ksB2rKwZvVSTw+5CyJclSAZrZ5JylbBut90/eTjoQut/1sUp1
    yME5Sucz1UCrUzL3G4Vd+lo+KCz2q3us2f5gUcq5V1c3d1oHdOMMMcWwnLyBqMb4aneL
    /RdfJTfXt+mZA0j32Np6NnS2Q0KEUJsJBUHvkqMPrD+2FJsbE8q96leXmOQwLGrTh5eQ
    Fb4P0SXDiBebMj4KZyHcZ0WCWCzx91WMtl28drIouScev1JL+BSNk9SRF8PdQSjRLBLv
    Fghruj6WeS15yhcrfrPN2JZntdQ1VvarJlbsvVxaOP++gvNkzZaviX5z2qYtgntNYPcy
    qSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785946663;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mOj25W7HB2ja6z4damFhPE7hAj/yYWADiGVUN7nFoPI=;
    b=iVIRCwVnuhln+vDTYOfKFCp6LY6fi8KdFWP3RMsVnyWNFEdt3s1M8EPZwpHy5I3Mzl
    RABpX67E2MQdAkwy/OoUmiZ0exXnY1t/aw4CY/5O1+WxW0doOCOKEGd7MXMHv4aU0Jm9
    OUwgogwLCLsQ4vG/QX3Zvmhn9qg0UlFA4RDVCLajet11uaMzZs4G+2OwXtC8nihY5C7z
    PA0ay8zoYz/W478FCfqfvapZV1hWSxnGfM0ew5bQ6dstIOzAobPmZjPeNCakk6O3OTKK
    ObvxblPkMUJmPx0DSmJ5sc8HrrX0x+wVOA123VFbX1a3BStIynLqylwyTCZC1XHa1rSj
    UEiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785946663;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mOj25W7HB2ja6z4damFhPE7hAj/yYWADiGVUN7nFoPI=;
    b=t02XQPLBw42LZAeMgEqH8CjSeYd5hnHAtN5O38PZe/GQ/mGIFwv/cyJc8+yAWVNnEs
    FlZY3QsaDRSz7pUrMmt20Fn1+6bH5XmftRzJZRoMwSjbYQ+RnbN6lqt4QfApWeGxuxPl
    0tImx4U5McyBJ/Zi/ST8yxO03zLARR7BtWUkULNzcYdwtLoCkLjcDOcdrX5KtiUdpXoy
    /QK2ssZPPUvclxxUwByb3ePUhK+fJx+kbE/IjI79ErOpjW+S+yHotj1W1dqfoNAWanEp
    vNOioR2c+RDvVVlwdWu0awm/5Jw71B1sZULHX6lNmm+3MV4AyFMOs5A+gYn5aGdc46DK
    OIaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785946663;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mOj25W7HB2ja6z4damFhPE7hAj/yYWADiGVUN7nFoPI=;
    b=PKfB9YC0FamhpuSDZYBTZc8iDQylUw48/0EsB+wBKWyg+i9DO9viUbZMihUcFupdvU
    hfP4Fd4+b5gxlv+lwuCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819275GHh452
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 5 Aug 2026 18:17:43 +0200 (CEST)
Message-ID: <c487793e-df15-4b32-9cfd-dd72648a8af2@hartkopp.net>
Date: Wed, 5 Aug 2026 18:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
 <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
 <6800934d-2da2-4eeb-8514-3978f4c7b307@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <6800934d-2da2-4eeb-8514-3978f4c7b307@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.26 09:25, Vincent Mailhol wrote:
> On 05/08/2026 at 08:29, Oliver Hartkopp wrote:

>> I prefer this conscious setting in the driver setup. We should better
>> add proper comments in drivers that do not set the flag, e.g. in slcan.c
>> there's no hint that the af_can.c echo feature is used.
> 
> Then, what about setting IFF_ECHO for *all* drivers by default in
> can_setup() and let the ones which have a special need to opt-out:
> 
>    dev->flags &= ~IFF_ECHO;
> 

This looks like a hack reverting bit settings.

> This way it remains transparent which one support IFF_ECHO or not. It is
> also more important to highlight when things are done differently
> (IFF_ECHO off) than when things go the normal case (IFF_ECHO on).
> 
> And this is more aligned with IFF_NOARP (c.f. you other message) in the
> sense that both flags would now be set by default by the framework. It
> looks odd to me that IFF_NOARP should be set by default by the framework
> but not IFF_ECHO.

I'm not really done with my thoughts but ...

IMO it's the right approach that alloc_candev_mqs() sets the IFF_ECHO 
flag and the default queue len.

What puzzles me is that the slcan driver is something in between which 
is neither a real CAN hardware nor a virtual CAN interface.

My idea would be to use alloc_candev() (-> alloc_candev_mqs()) only for 
real CAN hardware devices and open code slcan and the virtual CAN 
drivers ... which goes into the direction below.

Any thoughts?

Best regards,
Oliver


diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..5bdbe0c1d197 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -277,25 +277,10 @@ void can_bus_off(struct net_device *dev)
  		schedule_delayed_work(&priv->restart_work,
  				      msecs_to_jiffies(priv->restart_ms));
  }
  EXPORT_SYMBOL_GPL(can_bus_off);

-void can_setup(struct net_device *dev)
-{
-	dev->type = ARPHRD_CAN;
-	dev->mtu = CAN_MTU;
-	dev->min_mtu = CAN_MTU;
-	dev->max_mtu = CAN_MTU;
-	dev->hard_header_len = 0;
-	dev->addr_len = 0;
-	dev->tx_queue_len = 10;
-
-	/* New-style flags. */
-	dev->flags = IFF_NOARP;
-	dev->features = NETIF_F_HW_CSUM;
-}
-
  /* Allocate and setup space for the CAN network device */
  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int 
echo_skb_max,
  				    unsigned int txqs, unsigned int rxqs)
  {
  	struct can_ml_priv *can_ml;
@@ -332,10 +317,13 @@ struct net_device *alloc_candev_mqs(int 
sizeof_priv, unsigned int echo_skb_max,

  	can_ml = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
  	can_set_ml_priv(dev, can_ml);
  	can_set_cap(dev, CAN_CAP_CC);

+	dev->tx_queue_len = CAN_TX_QUEUE_LEN;
+	dev->flags |= IFF_ECHO;
+
  	if (echo_skb_max) {
  		priv->echo_skb_max = echo_skb_max;
  		priv->echo_skb = (void *)priv +
  			(size - echo_skb_max * sizeof(struct sk_buff *));
  	}
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 76e6b7b5c6a1..70263813ec40 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -167,16 +167,15 @@ static const struct ethtool_ops vcan_ethtool_ops = {
  	.get_ts_info = ethtool_op_get_ts_info,
  };

  static void vcan_setup(struct net_device *dev)
  {
-	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANXL_MTU;
-	dev->hard_header_len	= 0;
-	dev->addr_len		= 0;
-	dev->tx_queue_len	= 0;
-	dev->flags		= IFF_NOARP;
+	can_setup(dev);
+	dev->tx_queue_len = 0;
+	dev->mtu = CANXL_MTU;
+	dev->min_mtu = CAN_MTU;
+	dev->max_mtu = CANXL_MTU;
  	can_set_ml_priv(dev, netdev_priv(dev));
  	vcan_set_cap_info(dev);

  	/* set flags according to driver capabilities */
  	if (echo)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index e882250180ef..615a906203fa 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -180,19 +180,18 @@ static const struct ethtool_ops vxcan_ethtool_ops = {

  static void vxcan_setup(struct net_device *dev)
  {
  	struct can_ml_priv *can_ml;

-	dev->type		= ARPHRD_CAN;
-	dev->mtu		= CANXL_MTU;
-	dev->hard_header_len	= 0;
-	dev->addr_len		= 0;
-	dev->tx_queue_len	= 0;
-	dev->flags		= IFF_NOARP;
-	dev->netdev_ops		= &vxcan_netdev_ops;
-	dev->ethtool_ops	= &vxcan_ethtool_ops;
-	dev->needs_free_netdev	= true;
+	can_setup(dev);
+	dev->tx_queue_len = 0;
+	dev->mtu = CANXL_MTU;
+	dev->min_mtu = CAN_MTU;
+	dev->max_mtu = CANXL_MTU;
+	dev->netdev_ops = &vxcan_netdev_ops;
+	dev->ethtool_ops = &vxcan_ethtool_ops;
+	dev->needs_free_netdev = true;

  	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), 
NETDEV_ALIGN);
  	can_set_ml_priv(dev, can_ml);
  	vxcan_set_cap_info(dev);
  }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571..4619a74599cb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -21,10 +21,12 @@
  #include <linux/can/netlink.h>
  #include <linux/can/skb.h>
  #include <linux/ethtool.h>
  #include <linux/netdevice.h>

+#define CAN_TX_QUEUE_LEN 10 /* default length for hardware interfaces */
+
  /*
   * CAN mode
   */
  enum can_mode {
  	CAN_MODE_STOP = 0,
@@ -98,11 +100,23 @@ static inline u32 can_get_static_ctrlmode(struct 
can_priv *priv)
  static inline bool can_is_canxl_dev_mtu(unsigned int mtu)
  {
  	return (mtu >= CANXL_MIN_MTU && mtu <= CANXL_MAX_MTU);
  }

-void can_setup(struct net_device *dev);
+void can_setup(struct net_device *dev)
+{
+	dev->type = ARPHRD_CAN;
+	dev->mtu = CAN_MTU;
+	dev->min_mtu = CAN_MTU;
+	dev->max_mtu = CAN_MTU;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+
+	/* New-style flags. */
+	dev->flags = IFF_NOARP;
+	dev->features = NETIF_F_HW_CSUM;
+}

  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int 
echo_skb_max,
  				    unsigned int txqs, unsigned int rxqs);
  #define alloc_candev(sizeof_priv, echo_skb_max) \
  	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)

