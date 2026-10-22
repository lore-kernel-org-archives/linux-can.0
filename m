Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792670939;
	b=nLQc4L5GCDQbVmz1+nhl2NGG1Ib6KVBDapyRbrnTWO2n3Bw/kNmM+pHxzH1l90w9Yf2M
	 BnBgh4EOH8h2Xiuba1DFJ6KuPrzam+8Z1usTWlKrR94uhdWmcx4toI/nArSQumpgIx1F4
	 rx6YB92tbRp5s/1g9cT/7DGG1LV97QSv7uKgNGm2U6X2zlFM6wDLJEV7GJpwz8pbo81qh
	 eqdj/otkw3Ax3ImhoFk4w8Vy2pOE70B+qzut38E/uyngEOzsjLHIa+xM7iHMCRlAiZWZJ
	 DgsJwzQoRGHdDxS/Wlda24jqv2KzHfiQXXffJpJ5RoUIN/uZTcFWtUQl89Hv33TJ9UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670939;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=e1ave+kQocJjw+sr2l5kIwkmnZTKf9+I0cPEQnQKyRg=;
	b=bw64wFl6KpftBBd4oD8kAA+F/rSMI+IM/MIIQYORM6U+5HB+6BRp3d2jj888NJtti0c8
	 EL1Mi4YVe6QkIQVX/sJGm6TGYb8JF9M0GgC3ykpk485mkTXjVlr6at1NyMyVW/CPbqRWe
	 Pc2Gby6SNNkCBEhWBQ9u27NLlv2pCsGe1pyu6OiaLOuR4GvXPFTCP4K9xXeLgtcMkC/Bg
	 1PUBqrV1V+o6sfAJWZqezk7tO6EwpIJXYpaarBv/jqESM0Cf5x9AlKfmD/RpwmXfnkVf9
	 NTo+wjmKinEXL66y1t8ZopSgWY5NYJu0AcDDgfMFczr7RPkJ77gYUodjqkp4m+ujz6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="OOJc4/Ph";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iK9+IWvS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221A606A31A
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 12:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B221A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OOJc4/Ph;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iK9+IWvS
ARC-Seal: i=1; a=rsa-sha256; t=1792670930; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qIAKas8SrngKQLumwwj4EPai3htdCvbOzbx3AfYW3cnWP9D0xhodfbRNKPl/yJ8E+a
    K6gnVxAdJ/Lj6viZLZgAlj/drJZw3e1b3PI1C7wqOQSsV9iB9eLcmysnVIDp8v2eBaVo
    /tU8MrKzuJ0i2aEVIhYhAfLWmteUhhaiW+J6MDsSYZDISGGlZU2lZuDeUJAUUFz0cc3P
    KJOs+BY7GncbLpo32HD3is4zhgcicU9tZapzGOYgXFa7zie8wV8j9y4BLSPBk8FGOH+n
    E4Ex/jnr9qFBwgjXUncXWinYb0PIcJnx5J+EKBiuL4ItWE7MZQEQ23seNS5PNeHm0vYv
    hKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792670930;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e1ave+kQocJjw+sr2l5kIwkmnZTKf9+I0cPEQnQKyRg=;
    b=RuvNIHpVNBva1Z4xWraIcyhjux/gATyLQTh+GQsVieryvNlHRSP4lmCr8UBFQym8D/
    zzb2ybE/Z0KIFVYXgrsWcsuMCl4bTCHyRszfoXT5+hRzAWaFtX1hy37cO66AyZQOoyjI
    JZksoaSomFjr5BBmke3SwAHhSjCkWzs4fOeCK/G5CgZrbd6HikXxfWtrBYQLH5E+uFg+
    nTXPvbGEEoMF4ZvE9lzpptOUk+7nql/jc8BIDN0iji0Fq08Q/Lw0SfLABnndPNM3ePw1
    qRPiG3mctu66AQIsD5x2meGlKfODE9FjzJKe9OPlNdBx9OXyLdbOrZLRgCWdRuFO3qOz
    XKog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792670930;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e1ave+kQocJjw+sr2l5kIwkmnZTKf9+I0cPEQnQKyRg=;
    b=OOJc4/PhGvjARs9hyNpyP1ejqX8N6ff2nSfRytfhXBxmM7U+WmdtuJWc/Jxyr6leRr
    uZcf1UzvDLdQ5nvOnPIhgMALjYaOFXZKm19Bal//JrNmygZapT3yY9Boe1JffbrY3Snd
    MUe++VJWyo+GEo2NP7zKqYaWWq3XK8upj15oddOYvglIRAfWHFq4Az3dNfIc0TOns7Ff
    MSRRbJLJ/KfqSkK/uTvM0j44iTEesm3yIev1qkxm5ZMWkHDscTwtg5r1qmlUR4IlvAqs
    zAqsqarmkd4u4hRG0VI7tGyR9kz0UpXKV6PRwp9OXHdsS9+uq39yByJeuRL1TSt54Zj/
    2Yuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792670930;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=e1ave+kQocJjw+sr2l5kIwkmnZTKf9+I0cPEQnQKyRg=;
    b=iK9+IWvS13OW+c5HCblHCvdEXEePlbtqoW12IsbmEFWaHJGvDClZPZAxed42q7sTKr
    y3UHG5/WMCo/7lnJHuBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29MC8ooGJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 14:08:50 +0200 (CEST)
Message-ID: <8c4ef118-520a-419d-9f8c-28026d1cde09@hartkopp.net>
Date: Thu, 22 Oct 2026 14:08:43 +0200
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v7 0/5] can: protect the receive lists with a
 per-device lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20261022114202.180023-1-socketcan@hartkopp.net>
Content-Language: en-US
Cc: linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261022114202.180023-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

as the pull-request: can-next 2026-10-22 will be processed after the 
merge into Linus' tree we get some more time. Sorry for the nightly stress.

In this v7 update some release_sock() calls have been moved down behind 
sk_error_report(sk) as suggested by sachiko-bot.

So this patch set can hang around to be cross reviewed once more with 
less pressure.

There are two things that always have been remarked by sashiko:

1. the missing -ENOMEM handling for can_rx_register() in isptp_bind()
2. copying user-space data in raw.c and isotp.c under lock_sock() which 
can block rtnl in the notifiers

Would it make sense to you that I provide some patches/fixes to address 
these two points so that they can additionally go upstream when Paolo 
opens the fixes-phase?

Best regards,
Oliver

On 22.10.26 13:41, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].
> 
> The code of patches 1-4 is unchanged. Only the commit message of patch 4
> has been updated after the Sashiko review of v4 to describe the actual
> NULL pointer dereference in can_rx_unregister() and the CAN_ISOTP path
> that reaches it.
> 
> The series is based on linux-can-next/testing, which also contains
> "can: raw: remove redundant NULL check before netdev_hold()" from [2].
> 
> The idea behind patch 5:
> 
> The receive lists of a CAN device are located in the device's
> can_ml_priv and travel with the device when it is moved to another
> network namespace. But they are protected by the per-netns
> rcvlists_lock, so the lock that protects a device's lists depends on
> the namespace the caller passes to can_rx_register() and
> can_rx_unregister(). can_rx_unregister() silently returns when this
> namespace does not match dev_net(dev) anymore.
> 
> isotp_release() and bcm_release() leave the netdev notifier list before
> they can serialize against the notifier. When the device changes its
> namespace in this window, their filters are not removed and the
> remaining receivers point to the freed socket or bcm op.
> 
> Taking RTNL in these release paths is no option, as CAN_RAW already
> holds RTNL while adding and removing up to CAN_RAW_FILTER_MAX filters
> per socket, which unprivileged users can trigger repeatedly.
> 
> Instead, patch 5 protects the receive lists where they are located: A
> spinlock in struct can_dev_rcv_lists protects the lists of a CAN device
> (initialized in can_set_ml_priv()) or the 'any' CAN device lists of a
> namespace (initialized in can_pernet_init()). can_rx_unregister() then
> finds the subscription independently of the current namespace of the
> device, which is kept accessible by the tracked device references the
> protocols already hold. The per-netns rcvlists_lock only protects the
> receive list statistics, for which CAN_RAW, CAN_BCM and CAN_ISOTP pass
> the namespace that has been used for can_rx_register().
> 
> As a consequence, CAN_RAW and CAN_ISOTP do not need RTNL in bind(),
> setsockopt() and release() anymore. bind() is serialized against
> NETDEV_UNREGISTER by publishing the device inside the RCU section of
> its lookup, as unlist_netdevice() and synchronize_net() precede
> NETDEV_UNREGISTER both on unregistration and on a namespace change.
> The notifiers recheck the binding under lock_sock(). As RTNL does not
> keep NETDEV_DOWN out of bind() anymore, bind() checks IFF_UP after
> publishing the bound device, with an smp_mb() pair against the
> notifiers, so a down transition during bind() is still reported with
> ENETDOWN.
> 
> Changes in v7 (details in patch 5):
> - report ENETDOWN in bind() and ENODEV for NETDEV_UNREGISTER under
>    lock_sock(), so ENODEV can not be overwritten by ENETDOWN (Sashiko
>    review)
> 
> Changes in v6:
> - isotp_bind() checks the device before publishing so->dev, so a
>    failing bind() can not get a needless ENETDOWN (Sashiko review)
> 
> Changes in v5:
> - report ENETDOWN for a down transition during bind() again (Sashiko
>    review)
> - comment and kernel-doc updates (Sashiko review)
> - patch 4: commit message describes the actual crash path (Sashiko
>    review)
> 
> [1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> [2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/
> 
> Previous versions of patch 5:
> v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
> v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
> v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
> v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
> v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
> v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/
> 
> Oliver Hartkopp (4):
>    can: proc: skip stats calculation after reset in can_stat_update()
>    can: proc: remove pointers from CAN specific proc output
>    can: replace ARPHRD_CAN type checks with can_get_ml_priv()
>    can: protect the receive lists with a per-device lock
> 
> Runyu Xiao (1):
>    can: proc: reset pkg_stats atomics individually
> 
>   Documentation/networking/can.rst |  16 +--
>   include/linux/can/can-ml.h       |   3 +
>   include/linux/can/core.h         |   2 +-
>   include/net/netns/can.h          |   2 +-
>   net/can/af_can.c                 |  60 ++++++-----
>   net/can/af_can.h                 |   2 +-
>   net/can/bcm.c                    |  64 +++++-------
>   net/can/gw.c                     |   9 +-
>   net/can/isotp.c                  |  71 ++++++++-----
>   net/can/j1939/main.c             |   2 +-
>   net/can/proc.c                   |  95 ++++++++++-------
>   net/can/raw.c                    | 169 ++++++++++++++++++++-----------
>   12 files changed, 289 insertions(+), 206 deletions(-)
> 

