Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF033A02B
	for <linux-can@vger.kernel.org>; Thu,  8 Oct 2026 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432929; cv=pass; b=BD4I+4zZ+ynJYxOpl2DhO45KKdyFFLf6MkXzIiT4SNa2VfrAEf2sq0Byx1uX23qjuR2fOb3zQRy4h4M9Vy7UyUbevo5fxspZeImPMKIDnXLA3lZ2aBOQjp/3U6V/XFajtkJRPslOstmp0wEHmfkVUhEwiljCU4jMPXizvt9MnwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432929; c=relaxed/simple;
	bh=HiSvYPDXqPvWEVmnS61tLSv9MuxSkdO1CETIYvM23ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwWxRoSSRFZ5HvAhWJYMcvkgZKg8kN3KjmkGgX6Zv02fFjfKiHKVXTqGVvCuvXCOoXgon/hrYT4q8j1azMFtgzIY6PmlgIWE1EkRtN/zXOf1t3MMTwHsuqzUnjrEBtx86VGvC0phz61LYE01ObgV+hDW7SdyGuzrzZpEbzDwhIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzR0k70e; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzR0k70e"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-885cf67963eso28467777b3.0
        for <linux-can@vger.kernel.org>; Wed, 07 Oct 2026 21:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791432927; cv=none;
        d=google.com; s=arc-20260327;
        b=aygqsxHolGjtVt1+4SjCcXuM52YDqnxF4i7u1COpGA8yy2emSQ+FX3t/Sl0Zo+8LV+
         D/nPPP2Zrp7OliAaG2KP99hc7fRtEvzuGKD+wE0U/r3m+TUE+Ix/7JV7Zw3FmvIo5gja
         BibrihnZFV7k2KEhR1j1vMGyK9CHtVVYO6Cto/fEMftlVxhulCDEQmoGfq6QUUblsYwB
         4DhlBtHyvuHOEE9ChKRFQmTV4rkhOot4TEmiXSgCrlPo1pS53c+C/7pASiKSVWMlIUFk
         P74yVncSJw4T7HMiHiqq9Q4Ad8Lh7MqBhMU4lLQAQqOD+boKyYXpT3s2Qp7qFs9KpfyZ
         nc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ni3U1mE/yYvE5MNAfH3rxBCgOfVpQVRjU3mksJnmC0Q=;
        fh=rmF6g0MMlhd4wk80OXI/yyXB/RiSPDUEfDrXBHxHbZ0=;
        b=fA3i9kVGxL2LTQf1K9gEalgB3zsdsBLzg7V+qKYC5NZOo0f3jeDvWG74Rsg2VkuB7D
         OufES5GrLgqSUgM9Jrv0O4+lTj8O8BXC5e69jKIpQMhG0ebtj8i7bEDEkaO5dnfviPvn
         ED0Fy3Sskz6HfofoNr+nvJZftxI6BF2ZpZlAHgx6ulzXbPxXNaHj+IvnkmxDtRhFGj9H
         WD0Zohirz6cCV932pRnsWGdHVfQJl46SaAZHKQHZPX1SNrYcWm7c9/65aA3K8QBStKfw
         SeJlN1zwrmhEeVi6zEQBgSCgzwBn4ebTdrDW1U7rKUpdbELTSuJgYJIZH/utHMwzXTee
         53fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432927; x=1792037727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ni3U1mE/yYvE5MNAfH3rxBCgOfVpQVRjU3mksJnmC0Q=;
        b=XzR0k70eQjj4agYQmcNl4HL9wL5ZWeGl2UYFRzUp51whL7ztKybgyI4K8VMVjSFsFP
         oSkFbWxHGg2n5iIWtuEzGlePKHWWMRGqlrS1/Tti5j0r7ISETvCDXwp7hILJSb8NHt8g
         IxFyMePLeJ6JosoCohOcAlWMQYPrA9JddH6uujP20Ed1A33PXH0qQewrphqYLcQRqGa3
         XROVhYxpF0DukugMczQlEVu8kyB1wXTXAJZgKP2Sc10gUwEWAimHF6XsipXQAxQED0rK
         lFKwGUVYeSMJ4tY472Pc+AOoNa8oERWtfdygnUJ0mrr9J0CqbxaUviFIj86UvhSpDCzr
         UeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432927; x=1792037727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ni3U1mE/yYvE5MNAfH3rxBCgOfVpQVRjU3mksJnmC0Q=;
        b=WRBzxQau2Vg5wO8eczsPV6EwpQm/UxcrNHxzjkoASe5eI0rwuV0Y3NCEVoqoq2uk3R
         o+qmXSqokLw9elFAvEMk6gA7qlciUYfgSQsifaIrjn+FLdALuJFUn3O+mdGCTRXObiuZ
         EP8T9cAxot3wTePvO0U9m12QWsVAEeEwKfpJCbtnCwSuU18vfS5FP+zLwHzfgj5AJv1m
         qyhIOtan7yXZWIBgNZIJGdxQ7x7Sq4vKydq8xhSmxoW5ol7Iot95Eq1xXUuho2EedLY0
         tpkNYRtS716wHjENC/hsSZvfjllE4F1EeW4flqplW6JHFlDPsOlM84tLlJngwa5PRH9c
         8GVA==
X-Forwarded-Encrypted: i=1; AKwUvByY7cdYECjckQ3XT7SJLXp0l8+U1HHBEi2RTHzzcHpRID4gLBVFx2u8LadfkcJwZLKyuFRmGdtJR1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBRaukgI3Gr2+Q8o6lgwP7AntnxZTDPbNLK7C+5eN9PyxkBkev
	izCBTNnduBuEjvnutaRFnxstHrxqXkZrWJZAKnCaQIL7eSsvLUS4oY5AY9SyJH8uqQp29efy32s
	3udWU+SF8TuuAyfZokrGwBrauL0Hmp6w=
X-Gm-Gg: AYBFou0Uz4CgEOJ3fwT1Jln8ylgVp3PLbANKwiO8n5omOpuG2+/D7K+XdkiTWX93OtQ
	aobQ095iPclwtuy8QbJW8ysiI1XBU8yMP0+xaNlt7sxPJAxEK89SAOQ7FTd7EWSpYX+6tVnTj+w
	7/nA6fdmzguhlpfydJqWs1FcuFs3wlKgkowh8a6+Sb5a9EXIMX9++Il6joPTANYqWbrVsE1nnwt
	0L4d33zw2LC2fu4EuaoQvi52Cp1JHEwXbwQ6T1OiqfqLPwATYFUAulh+FCE5EVoZGeQ3BAgkrLX
	WY37Q3fw/KOqDUU2sPbFdgzRsmk8CgUfYbrxga0pKXwmPiudmVWapco=
X-Received: by 2002:a05:690e:458a:10b0:675:6acc:d1a1 with SMTP id
 956f58d0204a3-67909dd9839mr1860290d50.11.1791432927404; Wed, 07 Oct 2026
 21:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com> <20261007-rustling-congenial-kraken-8bbdb1-mkl@pengutronix.de>
In-Reply-To: <20261007-rustling-congenial-kraken-8bbdb1-mkl@pengutronix.de>
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
Date: Thu, 8 Oct 2026 09:45:15 +0530
X-Gm-Features: AclHuK9d6F0XiDHJJKsZ7ABW-KDT80rpT2TLY7hlHxLRiJCumRYu4nJy0hZ9rKo
Message-ID: <CAG6enPzfok4+zN-BxQkmw68DPJ_vEemDiDwsAGXQuLPPSTq07A@mail.gmail.com>
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:50=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.d=
e> wrote:
>
> On 07.10.2026 17:06:11, Yogesh Gaur wrote:
> > vcan_tx() and vcan_rx() update dev->stats with plain increments and
> > rely on the tx queue lock to serialise them.  That only holds for a
> > single tx queue.  vcan does not implement get_num_tx_queues(), so
> > rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
> > created with several queues, each with its own xmit lock.  Two CPUs
> > transmitting on different queues then update the same counters
> > concurrently and lose increments:
> >
> >   BUG: KCSAN: data-race in vcan_tx / vcan_tx
> >   read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 1:
> >    vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
> >    dev_hard_start_xmit+0x10c/0x380 net/core/dev.c:3969
> >    __dev_queue_xmit+0xbfd/0x1ec0 net/core/dev.c:4958
> >    can_send+0x584/0x720 net/can/af_can.c:279
> >    bcm_can_tx+0x3ba/0x5b0 net/can/bcm.c:367
> >   read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 0:
> >    vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
> >   value changed: 0x00000000000025ef -> 0x00000000000025f0
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
>
> So far all drivers use the classic stats, and the CAN dev helper code
> (in drivers/net/can/dev) also modifies these fields. A quick search
> shows these places:
>
> drivers/net/can/dev/rx-offload.c:48:     struct net_device_stats *stats =
=3D &dev->stats;
> drivers/net/can/dev/rx-offload.c:162:            offload->dev->stats.rx_d=
ropped++;
> drivers/net/can/dev/rx-offload.c:163:            offload->dev->stats.rx_f=
ifo_errors++;
> drivers/net/can/dev/rx-offload.c:249:    struct net_device_stats *stats =
=3D &dev->stats;
> drivers/net/can/dev/rx-offload.c:289:    struct net_device_stats *stats =
=3D &dev->stats;
> drivers/net/can/dev/skb.c:29:    struct net_device_stats *stats =3D &dev-=
>stats;
> drivers/net/can/dev/skb.c:402:   dev->stats.tx_dropped++;
>
> Can you modify the code to update the dstats if they are active?

Yes and as per Oliver's suggestion send race fix along with dstats
work on top for can-next.

Yogesh
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
