From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v5] can: dev: add CAN interface termination API
Date: Mon, 16 Jan 2017 14:55:10 +0100
Message-ID: <CAKT-o-e-NyQt7TDeBRXsJ8f3KQ2penkk+JdeTZ1BBWS=vPivig@mail.gmail.com>
References: <20170113113457.21775-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36741 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdAPNzc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2017 08:55:32 -0500
Received: by mail-ua0-f182.google.com with SMTP id 96so81429552uaq.3
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2017 05:55:32 -0800 (PST)
In-Reply-To: <20170113113457.21775-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

On 13 January 2017 at 12:34, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
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
> Reviewed-by: Ramesh Shanmugasundaram <Ramesh.shanmugasundaram@bp.renesas.=
com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v4:
>
> - convert struct can_priv::termination_const_cnt into unsigned int
> - can_changelink(): convert num_term and i to unsigned int
> - register_candev(): added do_set_termination() to check
>
>  drivers/net/can/dev.c            | 49 ++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/can/dev.h          |  4 ++++
>  include/uapi/linux/can/netlink.h |  5 ++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c240cd9f823b..afcf487382c9 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -978,6 +978,30 @@ static int can_changelink(struct net_device *dev,
>                 }
>         }
>
> +       if (data[IFLA_CAN_TERMINATION]) {
> +               const u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMINATI=
ON]);
> +               const unsigned int num_term =3D priv->termination_const_c=
nt;
>
> +               unsigned int i;
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
> @@ -1000,6 +1024,11 @@ static size_t can_get_size(const struct net_device=
 *dev)
>                 size +=3D nla_total_size(sizeof(struct can_bittiming));
>         if (priv->data_bittiming_const)                         /* IFLA_C=
AN_DATA_BITTIMING_CONST */
>                 size +=3D nla_total_size(sizeof(struct can_bittiming_cons=
t));
> +       if (priv->termination_const) {
> +               size +=3D nla_total_size(sizeof(priv->termination));     =
         /* IFLA_CAN_TERMINATION */
> +               size +=3D nla_total_size(sizeof(*priv->termination_const)=
 *       /* IFLA_CAN_TERMINATION_CONST */
> +                                      priv->termination_const_cnt);
> +       }
>
>         return size;
>  }
> @@ -1038,7 +1067,15 @@ static int can_fill_info(struct sk_buff *skb, cons=
t struct net_device *dev)
>             (priv->data_bittiming_const &&
>              nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>                      sizeof(*priv->data_bittiming_const),
> -                    priv->data_bittiming_const)))
> +                    priv->data_bittiming_const)) ||
> +
> +           (priv->termination_const &&
> +            (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) |=
|
> +             nla_put(skb, IFLA_CAN_TERMINATION_CONST,
> +                     sizeof(*priv->termination_const) *
> +                     priv->termination_const_cnt,
> +                     priv->termination_const))))
> +
>                 return -EMSGSIZE;
>
>         return 0;
> @@ -1093,6 +1130,16 @@ static struct rtnl_link_ops can_link_ops __read_mo=
stly =3D {
>   */
>  int register_candev(struct net_device *dev)
>  {
> +       struct can_priv *priv =3D netdev_priv(dev);
> +
> +       /* Ensure termination_const, termination_const_cnt and
> +        * do_set_termination consistency. All must be either set or
> +        * unset.
> +        */
> +       if ((!priv->termination_const !=3D !priv->termination_const_cnt) =
||
> +           (!priv->termination_const !=3D !priv->do_set_termination))
> +               return -EINVAL;
> +
>         dev->rtnl_link_ops =3D &can_link_ops;
>         return register_netdev(dev);
>  }
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 5f5270941ba0..94c5037881f3 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -38,6 +38,9 @@ struct can_priv {
>         struct can_bittiming bittiming, data_bittiming;
>         const struct can_bittiming_const *bittiming_const,
>                 *data_bittiming_const;
> +       const u16 *termination_const;
> +       const unsigned int termination_const_cnt;

1. Is const intentional here? It makes setting value in a driver hard...
2. nitpick - as the value is intended to be initialized with
ARRAY_SIZE maybe we should change it to size_t? If so we should also
change "const unsigned int num_term" above.

>
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
