From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH] [RFCv3] can: add CAN interface termination API
Date: Wed, 11 Jan 2017 10:50:21 +0100
Message-ID: <CAKT-o-dKX_DSjJsAyFF=+oVTZBymxxMT8MYXsHtUB7QrAVkUFg@mail.gmail.com>
References: <20170110175206.22733-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:35976 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753440AbdAKJum (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2017 04:50:42 -0500
Received: by mail-ua0-f180.google.com with SMTP id 96so82343244uaq.3
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2017 01:50:41 -0800 (PST)
In-Reply-To: <20170110175206.22733-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On 10 January 2017 at 18:52, Oliver Hartkopp <socketcan@hartkopp.net> wrote=
:
> This patch adds a netlink interface to configure the CAN bus termination =
of
> CAN interfaces.
>
> Inside the driver an array of supported termination values is defined:
>
> const u16 drvname_termination[] =3D { 60, 120, CAN_TERMINATION_DISABLED }=
;
>
> struct drvname_priv *priv;
> priv =3D netdev_priv(dev);
>
> priv->termination_const =3D &drvname_termination;
> priv->termination_const_cnt =3D ARRAY_SIZE(drvname_termination);
> priv->termination =3D CAN_TERMINATION_DISABLED;
>
> And the funtion to set the value has to be defined:
>
> priv->do_set_termination =3D drvname_set_termination;
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c            | 37 ++++++++++++++++++++++++++++++++++=
++-
>  include/linux/can/dev.h          |  4 ++++
>  include/uapi/linux/can/netlink.h |  5 +++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 8d6208c0b400..900feacaf0ac 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -958,6 +958,30 @@ static int can_changelink(struct net_device *dev,
>                 }
>         }
>
> +       if (data[IFLA_CAN_TERMINATION]) {
> +               u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);
const
> +               int num_term =3D priv->termination_const_cnt;
const
> +               int i;
> +
> +               if (!priv->do_set_termination)
> +                       return -EOPNOTSUPP;
> +
> +               /* check whether given value is supported by the interfac=
e */
> +               for (i =3D 0; i < num_term; i++) {
> +                       if (termval =3D=3D priv->termination_const[i])
> +                               break;
> +               }
> +               if (i >=3D num_term)
> +                       return -EINVAL;
> +
> +               /* Finally, set the termination value */
> +               err =3D priv->do_set_termination(dev, termval);
> +               if (err)
> +                       return err;
> +
> +               priv->termination =3D termval;
> +       }
> +
>         return 0;
>  }
>
> @@ -980,6 +1004,11 @@ static size_t can_get_size(const struct net_device =
*dev)
>                 size +=3D nla_total_size(sizeof(struct can_bittiming));
>         if (priv->data_bittiming_const)                         /* IFLA_C=
AN_DATA_BITTIMING_CONST */
>                 size +=3D nla_total_size(sizeof(struct can_bittiming_cons=
t));
> +       if (priv->termination_const &&
> +           priv->termination_const_cnt) {                      /* IFLA_C=
AN_TERMINATION_CONST */
> +               size +=3D nla_total_size(priv->termination_const_cnt * si=
zeof(u16));
> +               size +=3D nla_total_size(sizeof(u16));            /* IFLA=
_CAN_TERMINATION */
> +       }
>
>         return size;
>  }
> @@ -1018,7 +1047,13 @@ static int can_fill_info(struct sk_buff *skb, cons=
t struct net_device *dev)
>             (priv->data_bittiming_const &&
>              nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>                      sizeof(*priv->data_bittiming_const),
> -                    priv->data_bittiming_const)))
> +                    priv->data_bittiming_const)) ||
> +
> +           (priv->termination_const && priv->termination_const_cnt &&
> +            nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +                    priv->termination_const_cnt * sizeof(u16),
> +                    priv->termination_const) &&
> +            nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
>                 return -EMSGSIZE;
>
>         return 0;
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5f5270941ba0..cba7f4b5a722 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -38,6 +38,9 @@ struct can_priv {
>         struct can_bittiming bittiming, data_bittiming;
>         const struct can_bittiming_const *bittiming_const,
>                 *data_bittiming_const;
> +       const u16 *termination_const;
> +       const int termination_const_cnt;
> +       u16 termination;
>         struct can_clock clock;
>
>         enum can_state state;
> @@ -53,6 +56,7 @@ struct can_priv {
>         int (*do_set_bittiming)(struct net_device *dev);
>         int (*do_set_data_bittiming)(struct net_device *dev);
>         int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
> +       int (*do_set_termination)(struct net_device *dev, u16 term);
>         int (*do_get_state)(const struct net_device *dev,
>                             enum can_state *state);
>         int (*do_get_berr_counter)(const struct net_device *dev,
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/ne=
tlink.h
> index 94ffe0c83ce7..7414771926fb 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -127,9 +127,14 @@ enum {
>         IFLA_CAN_BERR_COUNTER,
>         IFLA_CAN_DATA_BITTIMING,
>         IFLA_CAN_DATA_BITTIMING_CONST,
> +       IFLA_CAN_TERMINATION,
> +       IFLA_CAN_TERMINATION_CONST,
>         __IFLA_CAN_MAX
>  };
>
>  #define IFLA_CAN_MAX   (__IFLA_CAN_MAX - 1)
>
> +/* u16 termination range: 1..65535 Ohms */
> +#define CAN_TERMINATION_DISABLED 0
> +
>  #endif /* !_UAPI_CAN_NETLINK_H */
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
