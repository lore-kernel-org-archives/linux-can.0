Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455246983F
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540828; cv=pass; b=ryyW7HV3nZ0JPWQ15MlQRaLzJ/4eq03jnqkoxaCQGh9oVBqXYgjNNcZ6ULnL7mc2SHalNdUEjeMx2Oqit2cjrFHVSgL4EUC6NmzVnIFAdyS5gU/V4q57HcnYQn1OMaT8VNKwqmfu9RHQOJbFeWvGm6YjBjkltzZvTxNd1LxOWMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540828; c=relaxed/simple;
	bh=PCuIEFZHs5AXmNvLyQaqmYzpNXqhYUhQFpW966jhkyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1mBy5LP1ViP2szyl6W7w9yU4KJHzIJWf2Yzdm7OWvo6Ee2x1X6ckR3q0hUOZG0Xz5vJYzBx5vbA1cwZ+chRx2tuXwdc1APkIAvq8vr86ENAw0yHZNylKVgKwpjRfz8tC/mxuvhfC8tGTQ1nZJP2AcRk7vhtP2lcwSkb7so2Wmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCzoT/I4; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCzoT/I4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1552775a91.3
        for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 16:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785540826; cv=none;
        d=google.com; s=arc-20260327;
        b=GYQcw9M0t3T4rmTW+3cySMPwOIYbr1JQlP08WTNOztBppymwIgv6bEMsRdi6XTDV/S
         MjaHthl3edYO/VSSjebxQhP+ac/ic5yzFpHA0rb6o2+lChYL0yibnympv5peEZKSEC5g
         Sri7r10SqhItBaLr4fQKKH57WjVE6trJtWMXwaTaeEH4Zz6LvpudyApNt4hePfnFGKlq
         jvarL9uPN76gIccrZa1CaKzIAcMBoFXCf586CuhbTHaQEuPXmQwcdyISrc12Qp7iqyor
         5D2Ye0EmiyzfupgK/PmiMrf8HPTdyoj+dENrsLQBGlbiZxN6OIUq1x8T0qohrvhaKvwq
         pbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fQChzJnXEh8H8MFp0Q6rzCz9bRltM04lPn2tQfKFQFo=;
        fh=eAGK9bGdDG/mhUK8/2nnjo4jellwu03O0T6K4v/MWGw=;
        b=LrzxujtV5i3dHyPQ9tpHCNNo3Jn+4zStSER0Ty067Q/B33gl74BsWI25RxvjbD5Vqn
         x//87jspzPUv919AjfZYHdWpAu3VOI2w2p9aUdMBXJP/ttwh+3YreluNFydMxGpu5j1c
         kzzushO15ctbeVQ++hjO8KVLdImvUbkljSYn3Oc+GwvU9GCKGG7l0rjm8nu1lFjgEmId
         mImgE4bINPhZolnaPUgWSHTbCVdWTQWVAU5hYChPpbacRmu5FhRgofeYCgRHPTC1q5Gy
         cHVNm2Q9bthUnjL+dTjJbqfJ2MK4yMQFTI9qHgRmpIymKOechh+7ilxaSAMIRmHlNZJg
         kTbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785540826; x=1786145626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQChzJnXEh8H8MFp0Q6rzCz9bRltM04lPn2tQfKFQFo=;
        b=eCzoT/I43shcEggrTj/mqL0t1U98NUcqb9q2uuL3Oi2VApL6flihMwK+iyZntOh6L0
         HykebIIcZYv6fuphBoHTbiePkzxCX0hHTrne7pxNKc66GLwHD20HBDFfy19QxPVDtHns
         YRHBzRrMOGv/rWuj6xvpFX9lOpX+giQzr6K78B54+HIuqAABXhg3ageNw5U1PSldxwEa
         zDyuMx/gOTT6+wUe82XD2Hb8Yg3hinV+51ZECo3t0LhIrBI33IbqAJnY1ctygZoWiBuK
         PsNfyclSm+ZP0A7vct4hA3QT+i9sY94ut8lFoVNstKznvw8X3XRXH7/LqKvkqCjlGi01
         YOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540826; x=1786145626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQChzJnXEh8H8MFp0Q6rzCz9bRltM04lPn2tQfKFQFo=;
        b=JZifEUkmTmslAQSH6w2dEHFQvqirnWz/GwYIW6kV4Pk0UJHYYmN5yukHmn91bh6dff
         RjrKu4d6s3mbP9XtwlRqYz1/8xpUrdPGhSkNc3aNYdLpmCWC8nhDDPSptBTAb26v10J2
         PSN81YR93Aii36TMYYezhrZyY37eC/QNclhotyXxbz7uCEW7740dcFpjWEhC7ADAGr91
         xtfGjFNLgpkbo8OwC56BiIFtMm0lUnPYuHf1EMmTZ7iSSbaorgqdXEQzyjD2GKOOsWKM
         ul9VUK8Su8ASpSHWKXgnO0/8IPjpA5MF8gWP12bIWnY915rLX/57IuP5ZK0xpV2+hUoL
         GHmQ==
X-Gm-Message-State: AOJu0Yy8MfeaZtWIAjyIeCbXrUl5XjngfZ9SJ2DkiUGLzCrYcxaW6gLs
	RpDR7hSisQevNYJm0hyYGKkSkMfA4lVFKLeg9NvLP1itbdFEeu7b9kYxjamWynKNktPow4n9m1/
	QURo2CitU6TWs54ECbsxWycu7SUcOr9UmLtr5UXKA
X-Gm-Gg: AR+sD10eHVZitiyQ4w9inKMKf4NhuhhRVgOCNJAisxSy08AfpNYNhg/bfMo2ejTxZrW
	/WbZbCt4DcJLfN41iwjRfGdHzdWBLguhpRd4xgU5OtICA8J0CH8cAO2zb7ZP79gtTF0ThAqQvko
	l7G89+KdxiSdRXBbpMVNXENkk49pescnIRuVDf046BvF2RmSyZw4Cw3QK2EggDv7WwVigPtsVNd
	AGezVJIuzdcDHuDlUkOeytBC+4Z+t/uDD3RV+OR/62aaLl50MrtqIx1fB7GtKzoTOTX42n2NQEU
	AxgJYoEKNecqh76lpyYMuzmSX3jMHfu7KC+6JPuixfcbl+e+scOvWYk49wayuPPmAAdekXxwWEY
	XVyVld/l49MgrvRpSYW5DPXq3gPOyxN1lUBERXzGpr5w/EIU/9RBCBGHKF6t+V1m+wEiPEsE3M3
	pdPpPZjAgG2NqYcg==
X-Received: by 2002:a17:90b:510e:b0:38e:a555:8fc3 with SMTP id
 98e67ed59e1d1-38fbc5c04e3mr1443221a91.41.1785540825522; Fri, 31 Jul 2026
 16:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731231755.2474376-1-kuniyu@google.com> <20260731233136.A908F1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731233136.A908F1F00AC4@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 1 Aug 2026 01:33:33 +0200
X-Gm-Features: AUfX_mwSp6UhBMcMTmJknHmFLku5OaIRrv5x6VVlXn_a1Iq8USG1cW9wm6dIgWc
Message-ID: <CAAVpQUD31xYKAx6NKdbqGKCLzk2ckB8Fb5tLySK7dBO_jvg4dg@mail.gmail.com>
Subject: Re: [PATCH RESEND v1] vxcan: Support per-netns device unregistration.
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The patch calls a non-existent function `unregister_netdevice_que=
ue_net()`, causing a build failure.

Hmm.. weird.  I saw can-next has this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/comm=
it/?id=3D71ac90cca6d8e6fcdd674a50157181ef4ac441a0


> --
>
> --- Patch [1]: [PATCH RESEND v1] vxcan: Support per-netns device unregist=
ration. ---
> commit aa743c4ffeab7ce1e07d36aa7e401187541f6f4f
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> vxcan: Support per-netns device unregistration.
>
> This commit modifies vxcan_dellink() to support concurrent per-netns devi=
ce
> unregistration by using xchg() to ensure each device is queued for
> destruction only once. It drops the synchronous RTNL assumption for delet=
ing
> both the local and peer devices.
>
> > diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> > index e882250180ef6..b7efed1226d88 100644
> > --- a/drivers/net/can/vxcan.c
> > +++ b/drivers/net/can/vxcan.c
> [ ... ]
> > @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
> >
> >  static void vxcan_dellink(struct net_device *dev, struct list_head *he=
ad)
> >  {
> [ ... ]
> > -     if (peer) {
> > -             priv =3D netdev_priv(peer);
> > -             RCU_INIT_POINTER(priv->peer, NULL);
> > -             unregister_netdevice_queue(peer, head);
> > -     }
> > +     priv =3D netdev_priv(peer);
> > +     dev =3D unrcu_pointer(xchg(&priv->peer, NULL));
> > +     if (dev)
> > +             unregister_netdevice_queue_net(dev_net(dev), peer, head);
>
> [Severity: Low]
> Does unregister_netdevice_queue_net() exist in the source tree? It appear=
s
> this will cause a build failure due to an undefined function reference wh=
en
> the driver is compiled.
>
> > +
> > +     netdev_put(peer, peer_tracker);
> > +     netdev_put(dev, &priv->peer_tracker);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731231755.24=
74376-1-kuniyu@google.com?part=3D1
