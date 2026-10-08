Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E83ACF05
	for <linux-can@vger.kernel.org>; Thu,  8 Oct 2026 04:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432819; cv=pass; b=rI1t0GzAExtNuJwb8gCQ/QzE2OoMT4KbG76gFTVeU2doXWwnVCeQeXNlTFfxsnYCqq0jJDla6HfjMsGDZX85q3n3CMt8D/x0VVASI9pWZTDzBf8lXeYOSkDkraUlXi1oOpBVr21Jyearg2bR2+FFlxeBGHo+oG2pQ9xusv8u4hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432819; c=relaxed/simple;
	bh=DexJ4Rup4u7rPB/vqPYNWWgAaahcV3WsYcGnI3nWwLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPAwcoXobQ7Fev/6wkVn1IlMOmqNUVSVQmLHdjC0jzXRPjuXwSeFrbn35MpqGZ7EE7O0aT7PliUftw9t6e9HGhT4ec+WNHGkDHb2QlH6MBrjCMLtIe3NoIKTdAGkmZjvvhWXKXwuNFNih6g8L8Mv1r3xpAIshBgOG164M3sNnJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pznZAJmq; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pznZAJmq"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-676804a3a22so2467502d50.1
        for <linux-can@vger.kernel.org>; Wed, 07 Oct 2026 21:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791432815; cv=none;
        d=google.com; s=arc-20260327;
        b=fhWyetPADkU6XyAGmZzsxaQ4VpuXmEpsv5UJMyIrGowwFNO+2p4QQxm7aac9cBO9xp
         7uBMzi64J3513hM1rRgG/9U2tGuXFLYx5bD/qAq4zDn+bTL6SkbwTHdGGTov/TQ6soPc
         oh++XIjaE8NIrSzsL43XRKyvUuVD9PNQbHa1U1vdocY1DpgkRqIMC15iKlGdd2izlV2p
         hgK9xRkYtto2Xelur3P8ClfSfeYa+WvSW+8PqF1dqVgL77GzyDaaH/g59M9mdE75Nc6w
         asCfSltA29UzifqicQUsSDmkh6j46Dw/xxBIrvkZIK1sMmzIMz+R6KfQcBgYDUtn+OZT
         zdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAieYICSucnxuVyVKR7DS9nN9JBaDIJD2J2XPFRyV5o=;
        fh=I3oN4+KcpOzFOh1nWqPYLS7RjSJFn+vSBSpFM2EnwB0=;
        b=PYXJ+VmpQtIqgaTN+TLAt9IRiILltuTr2q/uJ6tyEEl8fdvdXaAo8wKekOD3XXLn1x
         BokSxDbUNSJdrju/fkKrW8+xI7xcFsE5H5KmnoJ/iFDkOlNKohQKqKJTxr4Jbl1074KH
         c0jbalQZIhR6Dw06BCsFu0BE5UBgaPItuSG1Wvk6GvxruDkXXuLte81kIFqtdVS7uZx/
         9IDFK/ugSmsWKgWcv0GRdDmnd1MFgjjZ8FsgL+py4GFtIJZJRUQbYThpLJ9RSWszMgCR
         ASuhrUopZyHCUIst89HZ8DXPcnFmKUv98QECnJYL0o42gzaZi9a2ymiDEw7QTUd7+BGl
         uGYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432815; x=1792037615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAieYICSucnxuVyVKR7DS9nN9JBaDIJD2J2XPFRyV5o=;
        b=pznZAJmqO74UjQ8SYOzLCXA2IouYzeTDqGvoHjClazdL7cGQ0Ru0DK6v13m2ikD9Iq
         0oB2KKxQ/mkcsqKUhRNFFi/Fosyjj9b+Tdt6tKeYqTmJ2neHnNykmMDnH2SuUfalU6VN
         MRoyO26nT/P30cNa+Rk4z1iFsiQP0o01NCQ276LHzXmVq2m/zllc4lNbXXeVB9nNlpeR
         ncQtNUQXmzZ4s9gX2AKmEcfRvhcNbvcxkLbBL/taErwzHgEuLTZkoFRPz9iTEyZe5EgE
         x5BYZuTrGdCPQgMJ4NcQX1DYrbqTmQWHLh2FQjsZWPK3hW3pm+vOkcAoZeaTHxur0iwp
         WbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432815; x=1792037615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAieYICSucnxuVyVKR7DS9nN9JBaDIJD2J2XPFRyV5o=;
        b=CrpONHDB7EEvr/1pzUYk49S17vDaRJoko/01pTURn6jb9Z3ncL96C+1vwtky2O9+i5
         qEVgUNErT/zBq/CC0aIOcC7ySFC9/PbpAtwzqTYnSny/T0frWluUH7PKzh8sObI7J/Vz
         7F5vTz9nRWnHwe3nE3txX31NDFcUtiicgsPLaP0S1zqLymS0AsmtWRjovsIVHUIL3Me0
         Hu9btbGb7YkESZUyFidWFcHMna3d23C/UzII8V6+5HyxvHV9k3KCC4AUswiDPut298l5
         1ao56KY9YN3xDoLcDmgPuLpoYb1QfGY9O8EJag38yTKH32+jRpN8tqJHWb3j4ux9Mf1e
         PBlA==
X-Forwarded-Encrypted: i=1; AKwUvBw36tzPfnCcQHYPfRQNxd/dk7HEXW8mkppdRo9Vw4Y7OnK+55vzXKeeoIkM5/qPmqEuEr4/szXKPbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA+9uwmmR4qUb5ZzZR/uPAv3pfBWWXT0bNZZNBEPpWc4RDL2Wi
	LRPz1e4hw06IgBvvHHLHQ8RyOHKnwDttMgWR9/zFTU0jhae+kYqy4vuFEW5iy1vVaSbLWHx/aIW
	XTzbNpKZskAzhSEeRYMrbUkHLuWU9k4g=
X-Gm-Gg: AYBFou0Xnjj0D7OFI/N4je5tXs7Lnic86A+uwLvZLkUqrEtPYZsZgmEHWkLB7mtN+w3
	iUFXsgIonHEPWfDsn1z9x7iXwRAQCBZv+M35E3WqxpK5QMtf8T8HEbVXLdokKeFc5VfR909ZWtN
	SUfzVB3DCTbHw52wU3OTLHL0SONbVzS28tGReGEN/+Ak8DAwETcvTySiaB5YIxWiLe8JdYE1nUw
	yqzZv8WV8YFbT230NO9VDDtkdyW9fUnxSrI9RvI3IU0d4xyLWeVc0WSCzcUY1ahnCoGlSmxtTKl
	t/1ahhTSzdWby29HbSYVH7v/LV5na9XClnrAOftE//8gcH/CgehHfNI=
X-Received: by 2002:a05:690e:134a:b0:676:87c6:4f57 with SMTP id
 956f58d0204a3-6790a36edb8mr2509435d50.73.1791432815092; Wed, 07 Oct 2026
 21:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com> <f06b2a33-570e-4976-b4ac-b26b74f27cc6@hartkopp.net>
In-Reply-To: <f06b2a33-570e-4976-b4ac-b26b74f27cc6@hartkopp.net>
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
Date: Thu, 8 Oct 2026 09:43:23 +0530
X-Gm-Features: AclHuK9oczXosRk4l605xlZnewa1TAyTXVkGwfBtQQZt2LbHhAG2hgUtTmgK5VY
Message-ID: <CAG6enPzuqq3sLNR5bUNn-z1Y49ut8oZW-6=O2TuxC_EK4RJDzA@mail.gmail.com>
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
To: socketcan@hartkopp.net
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:41=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp=
.net> wrote:
>
>
>
> On 07.10.26 13:36, Yogesh Gaur wrote:
> > vcan_tx() and vcan_rx() update dev->stats with plain increments and
> > rely on the tx queue lock to serialise them.  That only holds for a
> > single tx queue.  vcan does not implement get_num_tx_queues(), so
> > rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
> > created with several queues
>
> dev_dstats_tx_add() has been introduced in Linux 6.14 so it is probably
> some can-next material for Linux 7.4+.

Agreed.

>
> Btw. why don't we implement get_num_tx_queues() and return 1 as a
> potential stable fix? This would add a correct locking via the existing
> tx queue lock for all vcan statistics right?

The locking argument holds: vcan is not LLTX, and every counter update
(tx, the echo-mode rx in vcan_rx(), and tx_dropped from
can_dropped_invalid_skb()) happens in vcan_tx() under the xmit locak.

But get_num_tx_queues() alone does not stop the multi-queue case, as
rtnl_create_link() only consults it when userspace did not ask.
>
> Best regards,
> Oliver
>
> ps. vxcan should have a similar problem.

Yes - same pattern and the same single-queue argument works there.

Plan for v2: limiting vcan and vxcan to one TX queue, then the dstats
conversion for can-next.

Yogesh
>
> , each with its own xmit lock.  Two CPUs
> > transmitting on different queues then update the same counters
> > concurrently and lose increments:
> >
> >    BUG: KCSAN: data-race in vcan_tx / vcan_tx
> >    read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 1:
> >     vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
> >     dev_hard_start_xmit+0x10c/0x380 net/core/dev.c:3969
> >     __dev_queue_xmit+0xbfd/0x1ec0 net/core/dev.c:4958
> >     can_send+0x584/0x720 net/can/af_can.c:279
> >     bcm_can_tx+0x3ba/0x5b0 net/can/bcm.c:367
> >    read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 0:
> >     vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
> >    value changed: 0x00000000000025ef -> 0x00000000000025f0
> >
> > Switch the packet and byte counters to the core's per-CPU dstats.
> > The core allocates them for NETDEV_PCPU_STAT_DSTATS and folds them
> > together with dev->stats in dev_get_stats(), so tx_dropped from
> > can_dropped_invalid_skb() is still reported.
> >
> > Reported-by: syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D937a3a1fbfbc99d6fcaf
> > Assisted-by: LLM
> > Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> > ---
> >   drivers/net/can/vcan.c | 13 ++++---------
> >   1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> > index 76e6b7b5c6a1..2ff90cb7eee9 100644
> > --- a/drivers/net/can/vcan.c
> > +++ b/drivers/net/can/vcan.c
> > @@ -71,10 +71,7 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testin=
g). Default: 0 (Off)");
> >
> >   static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
> >   {
> > -     struct net_device_stats *stats =3D &dev->stats;
> > -
> > -     stats->rx_packets++;
> > -     stats->rx_bytes +=3D can_skb_get_data_len(skb);
> > +     dev_dstats_rx_add(dev, can_skb_get_data_len(skb));
> >
> >       skb->pkt_type  =3D PACKET_BROADCAST;
> >       skb->dev       =3D dev;
> > @@ -85,7 +82,6 @@ static void vcan_rx(struct sk_buff *skb, struct net_d=
evice *dev)
> >
> >   static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *de=
v)
> >   {
> > -     struct net_device_stats *stats =3D &dev->stats;
> >       unsigned int len;
> >       int loop;
> >
> > @@ -93,8 +89,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struc=
t net_device *dev)
> >               return NETDEV_TX_OK;
> >
> >       len =3D can_skb_get_data_len(skb);
> > -     stats->tx_packets++;
> > -     stats->tx_bytes +=3D len;
> > +     dev_dstats_tx_add(dev, len);
> >
> >       /* set flag whether this packet has to be looped back */
> >       loop =3D skb->pkt_type =3D=3D PACKET_LOOPBACK;
> > @@ -107,8 +102,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, str=
uct net_device *dev)
> >                       /* only count the packets here, because the
> >                        * CAN core already did the echo for us
> >                        */
> > -                     stats->rx_packets++;
> > -                     stats->rx_bytes +=3D len;
> > +                     dev_dstats_rx_add(dev, len);
> >               }
> >               consume_skb(skb);
> >               return NETDEV_TX_OK;
> > @@ -185,6 +179,7 @@ static void vcan_setup(struct net_device *dev)
> >       dev->netdev_ops         =3D &vcan_netdev_ops;
> >       dev->ethtool_ops        =3D &vcan_ethtool_ops;
> >       dev->needs_free_netdev  =3D true;
> > +     dev->pcpu_stat_type     =3D NETDEV_PCPU_STAT_DSTATS;
> >   }
> >
> >   static struct rtnl_link_ops vcan_link_ops __read_mostly =3D {
>
