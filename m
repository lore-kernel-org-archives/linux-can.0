Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201801;
	b=QdKQfe9NYJgPPkLbnPYLjI2VRwubvGMhOVLBtUrXvJgltuXpgPcLdnwUAaed6YqkqcCe
	 hFOY2Hp1gSD+3AFSE6cJo8aM+JTmbYlC1+h0Y1cPEHlC8vUxrlGXNBLUVQFA1mbUodeOa
	 TMVp7rsi0/G//fazYYYw1Vm5/kdNDDOJ7SH8goaaMjeazznT0lMWEVWzkWgr6h8cEdpSp
	 TWvvq4nKz32jNRX2ajXB4SHfKw6qs4drxEknvCwMMPhOdZz1edF0wUDaHSX/BlSGV+vV6
	 okR+ae3dyMSFMxx3NjL45IcoKv7bA4O1RuJL3gfd0uQQb3QtlQpAPr42qRD/lrg8dRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3VxokDgf5Ju8QOYhKslTc2+jpw+WVw3F7PCZRh3ypcI=;
	b=cM3GIt4AsFnwFH0YWyvjLnYKVvwv7aNyu21+c6dYEjoSerJPy2xjCkV2gogX515lxo+E
	 iWIrU5fvg4UTX1pNwVcUDeIK44BbNqm1GFpFxuJpA/LzY3rpiNWZBt2fMpBUKVuYfohWn
	 Xedz5sV/eTVtyRpCqYUUk1L7iFC3WftL25ObvL142mdm3UKeuMc8VweUUqXyk5jGCj1mI
	 p8FlOE7ITt+wAghzDFINEnSh3OpwFMQ8yREaQKyufRLY8HGtkwg4faByDRkEIzlaHFnWx
	 5ovTc1jN+zBtOx8F8BeEoRWWD6SoSg/KWDH5Zp+dhZc52HpVO6hbjD1w0gegUkpJf8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n7zv4wDC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A606A322
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 15:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4432A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n7zv4wDC
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab4c608a6dso11508301fa.1
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 08:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201799; cv=none;
        d=google.com; s=arc-20260327;
        b=bF/foy+wPGtZXu+uLL6bVfImenfMAK84Fal7FTlDFWRiIOApZiiPfWV04/Pvb7xzuG
         hFqbnusIsZDLHTOkq4uL1OJpMU/LAlRs95tS2rCNRD5MOivjcQPZIqVOe0VBmn0QdcoZ
         OGbstlHCMui1RoFikdSzkB/ZXIm50mawNGIuDKltx6cFz2lTK5Mk3PAq7yJPen9boS6G
         u4r/uoEDCUN07om6HzrvY2D9Z9O9T6qAifcPpb74X03ITi5PFUhCj/5ceAyDNQh6NFgv
         kQRDACku3mFIsRkO2n8ucpk60ZwJYCKbWfUtOfZ3ih9UwxKETO5qYOfovgGWJ1alNDq+
         TDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3VxokDgf5Ju8QOYhKslTc2+jpw+WVw3F7PCZRh3ypcI=;
        fh=HF9CpGWn6lLx91CR0SHszi5Vf/4zK5V89Eri8J778AQ=;
        b=a8D44xO8NbO8RHklrfB3TJmXlyTWpeKiGDKdp2a5rassHCUkYWBj++b0N3yqgIM66K
         myIRpFDc2BDlUqCsergXWZ27A7icVKcb4xyGRlV0ervZcBxG6/tB/jFoK1voCiRfxONJ
         9/KBqWtZf/tklLkpSH6po8hIDC+C9j5uOvUW0ztCZWZCQKmQe3N4GHPhaC2PoyiyG1dw
         InfcrDlc3L2ne5Lhq9BoxWmY+OD2NP40iTKIDYvjqgKU2uVDg8vYyL6YKkTlcBWj3IVA
         Tw4GiekPvx/O3N/rXZKwwZFjSH0VjQET6CObl17u7bq65hYv7iM9fw2Zgi+LUBFRVkFZ
         cYag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793201799; x=1793806599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VxokDgf5Ju8QOYhKslTc2+jpw+WVw3F7PCZRh3ypcI=;
        b=n7zv4wDCwsorTr6BXE8IzNX+qirhAchF+XaAccUWVowy3WzrdYWCzYGtq2doVFg31C
         hh8/YMzqy4cT+FacjMzGSfinFQuS1Ov8KeHHmq0omvQmSTxL7h71u4al8swVbsFYjo9A
         M/sOQkDxbdAnPlIHjK895W+u5789LWYtzPtiKfDWDzIMzFk8w8bOXcZPYnN6eMtZHpTg
         H+++pDKsNie94jYcI7pBHzJmIcDH/tTDSO9fX08jSjP0kotsDXhvHXvAncPd00Ht2IYw
         aqVhD52SO8kfgrkFMpK5Dh7BtvtdWrOyVCnOWBInx5Y+JoVEvoiAFSCDh7IIwzOKH8kT
         7AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201799; x=1793806599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VxokDgf5Ju8QOYhKslTc2+jpw+WVw3F7PCZRh3ypcI=;
        b=c2aCqGKKDy8+ClPN3VvXwMrOPA9flOs1+Mgug6pVk3CLDsJFyIXZIY5BNDCD2eogDz
         8FwFOzjWpHS70aGS1UvNxd6VFMNTODv+GUd81IkYdpMq5wtq3nExFofmYv/jeXRwDczm
         6WL7mX1gkgYhlooJY8Sz++t4pIkAk61jPYZgUhkZVOlN4dmz9TSvBkVrME4RI5tg+ZFe
         57xxbWLvas9/ETi6HCuhrRFbAdAsnnpWXNBrg5hhXMwmyDQClEI6LQDXpL7lMUxaePUS
         RD0633KDhgCGK5Y3z7sVusrcU76zV+0QS4G9bfR4qwJ5nDxo3ftcH8GVCzBxAe4Ee7x3
         zCrA==
X-Gm-Message-State: AFq9FYLP9Zoet8duRXKA1i6KwEGD2Wlh5xNBHr7GOwa9nCHmPVLVSKuk
	dNS2mPkgGtjna0cEG8vxPBb1M05//Y91EM+3R7k189YRS0dRFHaa5y1Fli+k2TGKphYo1nq3vNm
	av5mOZKSi9mjcJTfnX1K4e8wu95h6hT2D029IC/ALZLIFpdFZDXIjfooZnZuEwQ==
X-Gm-Gg: AYBFou1fY6SgsemF4/YrBx7qtAUcPnnvVhNLEqBzS/jZ20WGtaZvmp25ciyiTyE8rFa
	8ZoHRDFLP+eBEGz77uDDrohhJdYDqXOqRczJVNSJcv7p31zkSfNtjtM5J9edM10j7UxwPNbz7/X
	8jfyyXjdUvz12qoZRXoi3oWmHOA7dwJJNo7EjBGk1UAQeUUy9nyrqRg/8Ks/Fqi5Lxv++l5RO7O
	OKQ8fBBpqJS7f4gjtjpcs8RX1LUBGt6Y5ThmVHEqo7ltI/bwAcfCLqnDogcGBSKUQ0TcMXvcNRt
	s0rxbGIA9+o32GLR+PhA80AbYwCSk7P03UcNOxBgZaf/bOOWMDn1I9bDHf1IpMQ7zCVsoKBT4og
	sT41GjMzcxND4cSaa3u5ecos7BTg174Cd9Y0piUHh8JCOaIvxn9AqfNX5dTymQcKoYJw=
X-Received: by 2002:a05:651c:554:b0:3a6:6f81:1027 with SMTP id
 38308e7fff4ca-3ac9cf92016mr5873331fa.24.1793201799143; Wed, 28 Oct 2026
 08:36:39 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793089479.git.zihanx@nebusec.ai> <cover.1793109154.git.zihanx@nebusec.ai>
 <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai> <08409264-c2b3-489a-b645-5849d7352990@hartkopp.net>
In-Reply-To: <08409264-c2b3-489a-b645-5849d7352990@hartkopp.net>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 28 Oct 2026 23:36:25 +0800
X-Gm-Features: AclHuK9o-Qq9uFgu0tfntEa6FMYVS_cE50kNTbboRQxFPWA-x8eZEj8k4AJWWZ0
Message-ID: <CAANe3eR5DoPe5SBeheHHVM099zS5S_dU0ndOHNxtA86tpLxXkQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] can: bcm: limit RX operation resource usage
 per socket
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, urs.thuermann@volkswagen.de, 
	davem@davemloft.net, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:04=E2=80=AFPM Oliver Hartkopp <socketcan@hartkop=
p.net> wrote:
>
> Just in the case it was not clear to you here:
>
> https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@ha=
rtkopp.net/
>
> Your patch does not solve the problem and will not be merged.
>
> Please stop sending updates.
>
> FYI it will go into this direction below, when the current patches are
> upstream. I already have a prepared patch for this issue.
>
> Best regards,
> Oliver
>
> (..)
>
> Enable memcg accounting instead, as it has been done for other
> allocations that can be triggered by unprivileged users:
> - use GFP_KERNEL_ACCOUNT for the bcm_op structures and their frames and
>    last_frames arrays in bcm_tx_setup() and bcm_rx_setup()
> - create the rcv_cache with SLAB_ACCOUNT, which covers the CAN receivers
>    of all CAN protocols
>
> (..)
>
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -919,7 +919,7 @@ static __init int can_init(void)
>         rcv_cache =3D kmem_cache_create("can_receiver", sizeof(struct rec=
eiver),
> -                                     0, 0, NULL);
> +                                     0, SLAB_ACCOUNT, NULL);
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1155,7 +1155,7 @@ static int bcm_tx_setup(...)
> -               op =3D kzalloc(OPSIZ, GFP_KERNEL);
> +               op =3D kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
> @@ -1172,7 +1172,7 @@ static int bcm_tx_setup(...)
>                         op->frames =3D kmalloc_array(msg_head->nframes,
>                                                    op->cfsiz,
> -                                                  GFP_KERNEL);
> +                                                  GFP_KERNEL_ACCOUNT);
> @@ -1403,7 +1403,7 @@ static int bcm_rx_setup(...)
> -               op =3D kzalloc(OPSIZ, GFP_KERNEL);
> +               op =3D kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
> @@ -1418,7 +1418,7 @@ static int bcm_rx_setup(...)
>                         op->frames =3D kmalloc_array(msg_head->nframes,
>                                                    op->cfsiz,
> -                                                  GFP_KERNEL);
> +                                                  GFP_KERNEL_ACCOUNT);
> @@ -1427,7 +1427,7 @@ static int bcm_rx_setup(...)
>                         op->last_frames =3D kcalloc(msg_head->nframes,
>                                                   op->cfsiz,
> -                                                 GFP_KERNEL);
> +                                                 GFP_KERNEL_ACCOUNT);
>
> (..)
>
> On 28.10.26 14:43, Zihan Xi wrote:
> > BCM sockets can create an unbounded number of RX operations. Each
> > operation allocates memory outside of the socket buffer accounting,
> > so a single unprivileged socket can exhaust kernel memory.
> >
> > Bound the number and aggregate allocation size of RX operations per
> > socket. Keep the charge until the operation and its frame arrays are
> > freed. Also keep a receiver count charged until the CAN core releases
> > the receiver after its RCU grace period, so repeated setup/delete
> > requests cannot bypass the limits while callbacks are pending.
> >
> > Return -ENOBUFS when a socket reaches either limit. Existing operations
> > can still be updated without additional charges.
> >
> > Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://bugtracker.nebusec.ai/f/11134
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >   include/linux/can/core.h |   7 +++
> >   net/can/af_can.c         |  34 ++++++++++-
> >   net/can/af_can.h         |   1 +
> >   net/can/bcm.c            | 127 +++++++++++++++++++++++++++++++++-----=
-
> >   4 files changed, 147 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> > index 2de74c2b78b6..89b9d0a2dcc1 100644
> > --- a/include/linux/can/core.h
> > +++ b/include/linux/can/core.h
> > @@ -53,6 +53,13 @@ int can_rx_register(struct net *net, struct net_devi=
ce *dev,
> >                   void (*func)(struct sk_buff *, void *),
> >                   void *data, char *ident, struct sock *sk);
> >
> > +/* release runs from an RCU callback and must not sleep. */
> > +int can_rx_register_with_release(struct net *net, struct net_device *d=
ev,
> > +                              canid_t can_id, canid_t mask,
> > +                              void (*func)(struct sk_buff *, void *),
> > +                              void *data, char *ident, struct sock *sk=
,
> > +                              void (*release)(struct sock *sk));
> > +
> >   extern void can_rx_unregister(struct net *net, struct net_device *dev=
,
> >                             canid_t can_id, canid_t mask,
> >                             void (*func)(struct sk_buff *, void *),
> > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > index 34fe3b28d576..a3f0ed35fbb5 100644
> > --- a/net/can/af_can.c
> > +++ b/net/can/af_can.c
> > @@ -441,15 +441,20 @@ static struct hlist_head *can_rcv_list_find(canid=
_t *can_id, canid_t *mask,
> >    *  -ENOMEM on missing cache mem to create subscription entry
> >    *  -ENODEV unknown device
> >    */
> > -int can_rx_register(struct net *net, struct net_device *dev, canid_t c=
an_id,
> > -                 canid_t mask, void (*func)(struct sk_buff *, void *),
> > -                 void *data, char *ident, struct sock *sk)
> > +static int can_rx_register_internal(struct net *net, struct net_device=
 *dev,
> > +                                 canid_t can_id, canid_t mask,
> > +                                 void (*func)(struct sk_buff *, void *=
),
> > +                                 void *data, char *ident, struct sock =
*sk,
> > +                                 void (*release)(struct sock *sk))
> >   {
> >       struct receiver *rcv;
> >       struct hlist_head *rcv_list;
> >       struct can_dev_rcv_lists *dev_rcv_lists;
> >       struct can_rcv_lists_stats *rcv_lists_stats =3D net->can.rcv_list=
s_stats;
> >
> > +     if (release && !sk)
> > +             return -EINVAL;
> > +
> >       /* insert new receiver  (dev,canid,mask) -> (func,data) */
> >
> >       if (dev && (dev->type !=3D ARPHRD_CAN || !can_get_ml_priv(dev)))
> > @@ -474,6 +479,7 @@ int can_rx_register(struct net *net, struct net_dev=
ice *dev, canid_t can_id,
> >       rcv->data =3D data;
> >       rcv->ident =3D ident;
> >       rcv->sk =3D sk;
> > +     rcv->release =3D release;
> >
> >       hlist_add_head_rcu(&rcv->list, rcv_list);
> >       dev_rcv_lists->entries++;
> > @@ -485,15 +491,37 @@ int can_rx_register(struct net *net, struct net_d=
evice *dev, canid_t can_id,
> >
> >       return 0;
> >   }
> > +
> > +int can_rx_register(struct net *net, struct net_device *dev, canid_t c=
an_id,
> > +                 canid_t mask, void (*func)(struct sk_buff *, void *),
> > +                 void *data, char *ident, struct sock *sk)
> > +{
> > +     return can_rx_register_internal(net, dev, can_id, mask, func, dat=
a,
> > +                                     ident, sk, NULL);
> > +}
> >   EXPORT_SYMBOL(can_rx_register);
> >
> > +int can_rx_register_with_release(struct net *net, struct net_device *d=
ev,
> > +                              canid_t can_id, canid_t mask,
> > +                              void (*func)(struct sk_buff *, void *),
> > +                              void *data, char *ident, struct sock *sk=
,
> > +                              void (*release)(struct sock *sk))
> > +{
> > +     return can_rx_register_internal(net, dev, can_id, mask, func, dat=
a,
> > +                                     ident, sk, release);
> > +}
> > +EXPORT_SYMBOL(can_rx_register_with_release);
> > +
> >   /* can_rx_delete_receiver - rcu callback for single receiver entry re=
moval */
> >   static void can_rx_delete_receiver(struct rcu_head *rp)
> >   {
> >       struct receiver *rcv =3D container_of(rp, struct receiver, rcu);
> >       struct sock *sk =3D rcv->sk;
> > +     void (*release)(struct sock *sk) =3D rcv->release;
> >
> >       kmem_cache_free(rcv_cache, rcv);
> > +     if (release)
> > +             release(sk);
> >       if (sk)
> >               sock_put(sk);
> >   }
> > diff --git a/net/can/af_can.h b/net/can/af_can.h
> > index 87887014f562..2fa4cf8c1314 100644
> > --- a/net/can/af_can.h
> > +++ b/net/can/af_can.h
> > @@ -57,6 +57,7 @@ struct receiver {
> >       void *data;
> >       char *ident;
> >       struct sock *sk;
> > +     void (*release)(struct sock *sk);
> >       struct rcu_head rcu;
> >   };
> >
> > diff --git a/net/can/bcm.c b/net/can/bcm.c
> > index 3d637a1e0ac1..477bdc1e8745 100644
> > --- a/net/can/bcm.c
> > +++ b/net/can/bcm.c
> > @@ -58,6 +58,7 @@
> >   #include <linux/can/skb.h>
> >   #include <linux/can/bcm.h>
> >   #include <linux/slab.h>
> > +#include <linux/overflow.h>
> >   #include <linux/workqueue.h>
> >   #include <linux/spinlock.h>
> >   #include <net/can.h>
> > @@ -127,6 +128,7 @@ struct bcm_op {
> >       void *last_frames;
> >       struct canfd_frame sframe;
> >       struct canfd_frame last_sframe;
> > +     size_t rx_mem;
> >       struct sock *sk;
> >       struct net_device *rx_reg_dev;
> >       netdevice_tracker rx_reg_dev_tracker;
> > @@ -141,6 +143,9 @@ struct bcm_sock {
> >       struct list_head notifier;
> >       struct list_head rx_ops;
> >       struct list_head tx_ops;
> > +     unsigned int rx_op_count;
> > +     size_t rx_mem_used;
> > +     atomic_t rx_receiver_count;
> >       unsigned long dropped_usr_msgs;
> >       struct proc_dir_entry *bcm_proc_read;
> >       char procname [32]; /* inode number in decimal with \0 */
> > @@ -190,6 +195,10 @@ static bool bcm_is_invalid_tv(struct bcm_msg_head =
*msg_head)
> >   #define OPSIZ sizeof(struct bcm_op)
> >   #define MHSIZ sizeof(struct bcm_msg_head)
> >
> > +/* Bound the resources consumed by RX operations on one BCM socket. */
> > +#define BCM_MAX_RX_OPS 1024
> > +#define BCM_MAX_RX_MEM (16 * 1024 * 1024)
> > +
> >   /*
> >    * procfs functions
> >    */
> > @@ -922,9 +931,64 @@ static struct bcm_op *bcm_find_op(struct list_head=
 *ops,
> >       return NULL;
> >   }
> >
> > +/* Called with the socket lock held. */
> > +static bool bcm_rx_op_charge(struct bcm_sock *bo, size_t rx_mem)
> > +{
> > +     if (bo->rx_op_count >=3D BCM_MAX_RX_OPS ||
> > +         rx_mem > BCM_MAX_RX_MEM - bo->rx_mem_used)
> > +             return false;
> > +
> > +     bo->rx_op_count++;
> > +     bo->rx_mem_used +=3D rx_mem;
> > +     return true;
> > +}
> > +
> > +/* Called with the socket lock held. */
> > +static void bcm_rx_op_uncharge(struct bcm_sock *bo, size_t rx_mem)
> > +{
> > +     if (!rx_mem)
> > +             return;
> > +
> > +     if (WARN_ON_ONCE(!bo->rx_op_count || bo->rx_mem_used < rx_mem))
> > +             return;
> > +
> > +     bo->rx_op_count--;
> > +     bo->rx_mem_used -=3D rx_mem;
> > +}
> > +
> > +static void bcm_rx_receiver_release(struct sock *sk)
> > +{
> > +     struct bcm_sock *bo =3D bcm_sk(sk);
> > +
> > +     WARN_ON_ONCE(atomic_dec_return(&bo->rx_receiver_count) < 0);
> > +}
> > +
> > +/* Called with the socket lock held. */
> > +static int bcm_rx_register(struct bcm_op *op, struct net_device *dev)
> > +{
> > +     struct bcm_sock *bo =3D bcm_sk(op->sk);
> > +     int err;
> > +
> > +     if (atomic_inc_return(&bo->rx_receiver_count) > BCM_MAX_RX_OPS) {
> > +             atomic_dec(&bo->rx_receiver_count);
> > +             return -ENOBUFS;
> > +     }
> > +
> > +     err =3D can_rx_register_with_release(sock_net(op->sk), dev, op->c=
an_id,
> > +                                        REGMASK(op->can_id), bcm_rx_ha=
ndler,
> > +                                        op, "bcm", op->sk,
> > +                                        bcm_rx_receiver_release);
> > +     if (err)
> > +             atomic_dec(&bo->rx_receiver_count);
> > +
> > +     return err;
> > +}
> > +
> >   static void bcm_free_op_work(struct work_struct *work)
> >   {
> >       struct bcm_op *op =3D container_of(work, struct bcm_op, work);
> > +     struct sock *sk =3D op->sk;
> > +     size_t rx_mem =3D op->rx_mem;
> >
> >       hrtimer_cancel(&op->timer);
> >       hrtimer_cancel(&op->thrtimer);
> > @@ -935,13 +999,20 @@ static void bcm_free_op_work(struct work_struct *=
work)
> >       if ((op->last_frames) && (op->last_frames !=3D &op->last_sframe))
> >               kfree(op->last_frames);
> >
> > -     /* the last possible access to op->timer/op->thrtimer has now
> > -      * happened above via hrtimer_cancel() - op->sk is no longer
> > -      * needed by any pending timer callback, so drop our reference
> > +     kfree(op);
> > +     /*
> > +      * Keep the RX budget charged until the operation and its frame a=
rrays
> > +      * have actually been freed. op->sk holds a reference while this =
work is
> > +      * pending, so the socket remains valid while updating its accoun=
ting.
> >        */
> > -     sock_put(op->sk);
> > +     if (rx_mem) {
> > +             lock_sock(sk);
> > +             bcm_rx_op_uncharge(bcm_sk(sk), rx_mem);
> > +             release_sock(sk);
> > +     }
> >
> > -     kfree(op);
> > +     /* Drop the reference held for the operation and any pending time=
r. */
> > +     sock_put(sk);
> >   }
> >
> >   static void bcm_free_op_rcu(struct rcu_head *rcu_head)
> > @@ -1316,6 +1387,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >   {
> >       struct bcm_sock *bo =3D bcm_sk(sk);
> >       struct bcm_op *op;
> > +     size_t rx_mem, frames_size, arrays_size;
> >       int do_rx_register;
> >       int new_op =3D 0;
> >       int err =3D 0;
> > @@ -1414,10 +1486,31 @@ static int bcm_rx_setup(struct bcm_msg_head *ms=
g_head, struct msghdr *msg,
> >               do_rx_register =3D (ifindex && !op->rx_reg_dev) ? 1 : 0;
> >
> >       } else {
> > +             /*
> > +              * Charge the operation and its frame arrays before alloc=
ating
> > +              * them or registering a CAN receiver. nframes is already=
 bounded
> > +              * above, but keep the size arithmetic explicitly overflo=
w-safe.
> > +              */
> > +             rx_mem =3D sizeof(*op);
> > +             if (msg_head->nframes > 1) {
> > +                     if (check_mul_overflow((size_t)msg_head->nframes,
> > +                                            (size_t)CFSIZ(msg_head->fl=
ags),
> > +                                            &frames_size) ||
> > +                         check_mul_overflow(frames_size, (size_t)2,
> > +                                            &arrays_size) ||
> > +                         check_add_overflow(rx_mem, arrays_size, &rx_m=
em))
> > +                             return -EOVERFLOW;
> > +             }
> > +
> > +             if (!bcm_rx_op_charge(bo, rx_mem))
> > +                     return -ENOBUFS;
> > +
> >               /* insert new BCM operation for the given can_id */
> >               op =3D kzalloc(OPSIZ, GFP_KERNEL);
> > -             if (!op)
> > +             if (!op) {
> > +                     bcm_rx_op_uncharge(bo, rx_mem);
> >                       return -ENOMEM;
> > +             }
> >
> >               spin_lock_init(&op->bcm_tx_lock);
> >               spin_lock_init(&op->bcm_rx_update_lock);
> > @@ -1425,6 +1518,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >               op->nframes =3D msg_head->nframes;
> >               op->cfsiz =3D CFSIZ(msg_head->flags);
> >               op->flags =3D msg_head->flags;
> > +             op->rx_mem =3D rx_mem;
> >
> >               if (msg_head->nframes > 1) {
> >                       /* create array for CAN frames and copy the data =
*/
> > @@ -1432,8 +1526,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >                                                  op->cfsiz,
> >                                                  GFP_KERNEL);
> >                       if (!op->frames) {
> > -                             kfree(op);
> > -                             return -ENOMEM;
> > +                             err =3D -ENOMEM;
> > +                             goto free_op;
> >                       }
> >
> >                       /* create and init array for received CAN frames =
*/
> > @@ -1441,9 +1535,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >                                                 op->cfsiz,
> >                                                 GFP_KERNEL);
> >                       if (!op->last_frames) {
> > -                             kfree(op->frames);
> > -                             kfree(op);
> > -                             return -ENOMEM;
> > +                             err =3D -ENOMEM;
> > +                             goto free_op;
> >                       }
> >
> >               } else {
> > @@ -1532,11 +1625,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg=
_head, struct msghdr *msg,
> >
> >                       dev =3D dev_get_by_index(sock_net(sk), ifindex);
> >                       if (dev) {
> > -                             err =3D can_rx_register(sock_net(sk), dev=
,
> > -                                                   op->can_id,
> > -                                                   REGMASK(op->can_id)=
,
> > -                                                   bcm_rx_handler, op,
> > -                                                   "bcm", sk);
> > +                             err =3D bcm_rx_register(op, dev);
> >
> >                               /* keep a tracked reference so that a lat=
er
> >                                * unregister can safely reach the device=
 even
> > @@ -1558,9 +1647,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >                       }
> >
> >               } else {
> > -                     err =3D can_rx_register(sock_net(sk), NULL, op->c=
an_id,
> > -                                           REGMASK(op->can_id),
> > -                                           bcm_rx_handler, op, "bcm", =
sk);
> > +                     err =3D bcm_rx_register(op, NULL);
> >               }
> >
> >               if (err) {
> > @@ -1593,6 +1680,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
> >       if (op->last_frames !=3D &op->last_sframe)
> >               kfree(op->last_frames);
> >       kfree(op);
> > +     bcm_rx_op_uncharge(bo, rx_mem);
> >       return err;
> >   }
> >
> > @@ -1896,6 +1984,7 @@ static int bcm_init(struct sock *sk)
> >       bo->ifindex          =3D 0;
> >       bo->dropped_usr_msgs =3D 0;
> >       bo->bcm_proc_read    =3D NULL;
> > +     atomic_set(&bo->rx_receiver_count, 0);
> >
> >       INIT_LIST_HEAD(&bo->tx_ops);
> >       INIT_LIST_HEAD(&bo->rx_ops);
>

Hi Oliver,

Thank you for taking the time to explain your concerns and review my
report and reproducer. I apologize for missing your earlier message.

I understand your decision and will respect your request not to send
further updates.

Thank you again for your time and guidance.

Best regards,
Zihan
