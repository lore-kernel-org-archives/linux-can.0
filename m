From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 11:18:23 +0100
Message-ID: <CAKT-o-dT5ZR9J+zwJuGZELg3=ssQ7GcuGzr7P5ATYX8rWa_YKQ@mail.gmail.com>
References: <20170106125344.15267-1-mkl@pengutronix.de> <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de> <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34339 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759537AbdAJKSt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 05:18:49 -0500
Received: by mail-ua0-f174.google.com with SMTP id 35so49554549uak.1
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2017 02:18:49 -0800 (PST)
In-Reply-To: <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi,

I can see three major problems with setting up predefined bitrates:
1. I think that there is no way to pass supported bitrates to
userspace (other than printk)
2. The bitrate that is passed to the driver is calculated/validated by
can_get_bittiming. This causes that driver not always get exact value
that was input by a user.
3. When CAN device is using predefined bitrates you do not have
influence or even access to bittiming parameters. As you noticed I had
to hardcode those values in mcba_usb to present them correctly to
userspace.

Based on solution created by Oliver for termination I created
something similar for predefined bitrates. It solves issue number 1
and 2. Not sure how to solve issue 3 correctly to maintain
compatibility (adding another netlink value for predefined bitrate
will break it). As for now I just zeroed values.

The patch is just to visualise my idea. It definitely needs some more work.

Inside the driver:
const u32 predef_bitrate[] = {20000, 50000, 100000};

priv->bitrate_const = predef_bitrate;
priv->bitrate_const_cnt = ARRAY_SIZE(predef_bitrate);

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8d6208c0b400..d2034a69c990 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -279,25 +279,44 @@ static int can_fixup_bittiming(struct net_device
*dev, struct can_bittiming *bt,
        return 0;
 }

+/*
+ * Checks the validity of predefined bitrate settings
+ */
+static int can_validate_bittiming(struct net_device *dev, struct
can_bittiming *bt)
+{
+       struct can_priv *priv = netdev_priv(dev);
+       int i;
+
+       for(i = 0; i < priv->bitrate_const_cnt &&
+               bt->bitrate != priv->bitrate_const[i]; ++i);
+
+       if (i >= priv->bitrate_const_cnt)
+               return -EINVAL;
+
+       /* Clear bittiming settings to idicate we are using predefined
bitrate */
+       memset(bt, 0, sizeof(struct can_bittiming));
+       bt->bitrate = priv->bitrate_const[i];
+
+       return 0;
+}
+
 static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
                             const struct can_bittiming_const *btc)
 {
        int err;

-       /* Check if the CAN device has bit-timing parameters */
-       if (!btc)
-               return -EOPNOTSUPP;
-
        /*
         * Depending on the given can_bittiming parameter structure the CAN
         * timing parameters are calculated based on the provided bitrate OR
         * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
         * provided directly which are then checked and fixed up.
         */
-       if (!bt->tq && bt->bitrate)
+       if (!bt->tq && bt->bitrate && btc)
                err = can_calc_bittiming(dev, bt, btc);
-       else if (bt->tq && !bt->bitrate)
+       else if (bt->tq && !bt->bitrate && btc)
                err = can_fixup_bittiming(dev, bt, btc);
+       else if (bt->bitrate && !btc)
+               err = can_validate_bittiming(dev, bt);
        else
                err = -EINVAL;

@@ -1018,7 +1037,11 @@ static int can_fill_info(struct sk_buff *skb,
const struct net_device *dev)
            (priv->data_bittiming_const &&
             nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
                     sizeof(*priv->data_bittiming_const),
-                    priv->data_bittiming_const)))
+                    priv->data_bittiming_const)) ||
+
+           (priv->bitrate_const &&
+            nla_put(skb, IFLA_CAN_BITRATE_CONST,
+                    sizeof(u32) * priv->bitrate_const_cnt,
priv->bitrate_const)))
                return -EMSGSIZE;

        return 0;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5f5270941ba0..fa5e8337f0e3 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,6 +38,8 @@ struct can_priv {
        struct can_bittiming bittiming, data_bittiming;
        const struct can_bittiming_const *bittiming_const,
                *data_bittiming_const;
+       const u32 *bitrate_const;
+       const int bitrate_const_cnt;
        struct can_clock clock;

        enum can_state state;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 94ffe0c83ce7..7d1815dad72b 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -127,6 +127,7 @@ enum {
        IFLA_CAN_BERR_COUNTER,
        IFLA_CAN_DATA_BITTIMING,
        IFLA_CAN_DATA_BITTIMING_CONST,
+       IFLA_CAN_BITRATE_CONST,
        __IFLA_CAN_MAX
 };



Regards,
Remik
