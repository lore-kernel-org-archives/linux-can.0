Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792528393;
	b=0eYE64ANOR0E+8jZTI9thhtvw7J6rdrv4aBtcL3ODOgxnmcjTJ6xfryCShzLeByzI1/m
	 Qx4kfGEcIBk46rSGxUkbwixJjDWaOA+PPLkEFGxFheVf73MEQZ85LuCko7AG7cZOkXlJu
	 UoncRD/pVNlV+OAgQO/Krqs5uljLEVKON3VW8+ni3LdiYDY9sHQH13xh8NFOcJ1ak7bHn
	 vJ3e0WQQEK2uxNljb/9nG8M7Ny/sIKy6/usvaya++lPWvcHBr3ynB1uyXxYztGC//53jk
	 Vo65vv1SECPW+Oke0Py/0N8kCkPpIwZybOsYcyC+pCuX/moQDwUazzPE4CY+xhNNXpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528393;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=gHsO5dim0fknWdsEO0o9xGQ2S9fCioQOJdqm2mEv6EY=;
	b=TrvZxbWncM+fgk3QgnAS+8jykR0Af+xqJvAINe5RVeumS5aqhTOogHlHEVCnukjQ9v7i
	 TawPPjOuITD9MqwCts/RcPnseovI50ooUxLPEGfdrLT803zSmZN74AR2iIVOGcWvTZGO/
	 rteETMxSYBT1lXCsIvmhEvk/BxnIBtfoKhmM4et8XywG/G5Z5H5tpUKTzHWIdOIGJG6ln
	 BgleJXXaSdzxFzVYSjMQ28tJg5JdhIc4lWawOL+8cZPU0S6cEKSzuGnWt4m50eKRH2QVB
	 H8TWeGrLEfjtFxq93g2Vi7+dim5qqxW/Z+z0c5FetXWcEhT1bxTndC6FeooLYPk0nEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UGUIL411;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cRN6Pc9N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.220
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007E606A31A
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 20:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C007E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UGUIL411;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cRN6Pc9N
ARC-Seal: i=1; a=rsa-sha256; t=1792528384; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C9iWgsJEnEzQGG8uKqKQXqhTg7UWJfyIENTnirvLjj6V85x0VkUEGabMFzvgJN227r
    OG7WD+QlbTmTTXe1exv6m+LT3ArHdRl+rGrtuCNkf1BiRuMULqZwBNkwCHjYtLL4m08k
    xgBrlkSu6sKMzPfV6/bnD59U3sIviCt1QgVkFjweWjpvx9rWNfebvFuajU6NiFd64JWn
    3+fi3rRe87pmQCLf20KepUbfoqbwTxJWYq9serpfnTM9BRHeK6Wy/wZFiu0FXr1dpcFE
    Tlr9OrkuXfnm45GRvQM2idaZ9/ZfSjhiDVspe48yHbNmtPIRTezG7/sRx8EsLE5AwF+Z
    EZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528384;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gHsO5dim0fknWdsEO0o9xGQ2S9fCioQOJdqm2mEv6EY=;
    b=FxJhOxTJ4IltxHz4jrODFuw4AgKpJ4ZKZiC85s6Dbb+FO2mr0girQvWA0QTfytr8Mi
    YEexUsWDjLTlN05YMWnhi551Dzeev5mvkjju6/l6j6SuVdQmfIOhZHIAoaWb6V8JH871
    53sSHG4DOFYrFiwV4t/vYHWuPWno0PKkv+JXehZD0/bgWPjx7UN39Wqpof9XaocTm/VH
    Qu2Dsr9fw0izUNe+wjXzJpUr8Fk83m5b7tZTXQRyAaDz7m4fWHu2t1wAZ7EINrxc3gsm
    zu3rXIr3hA8u04EelVR33dgMkqBlyqYTzUWzlvqYmHVnFDcFEKLo8tk6R2OWfWUwMvbm
    66gA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792528384;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gHsO5dim0fknWdsEO0o9xGQ2S9fCioQOJdqm2mEv6EY=;
    b=UGUIL411KKDDZ0zoeBvR9XDxCpP6ZX3hJHsVKQBWxZQELKS4FeZX7I7WhlKf5w1Mjh
    xwje1siz+H8fL4kCAeudEHyLCrCtkHhX3AvfCpXkWtJntkh0Gsg+Ue/cma58die4U+j4
    NUasBwmO5K115ugjZwVFvFsXvqSl+aabCyR4kE65L30Woul59XnDCUyL8UKwUvVR9gEo
    JSw4lhT5lgBCdVgUdWXcWsFfNO21SoFabvBCgv7HEZqbvXbLxmtC/mIsPd9iTZZhF/KF
    qxlXRaylhm2dMN/Qe6/3iSSVOUA+CFLCoRpIOewhpnyPjyb0iOIwwjixIGZv4eY4AfQd
    gTaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792528384;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gHsO5dim0fknWdsEO0o9xGQ2S9fCioQOJdqm2mEv6EY=;
    b=cRN6Pc9NSvC3YOCoDZe08NnS2RmjgFt3Xp5auitJMRkt/PThWJlWEPDlOUEQU6FfBv
    BUvwBHENRbY16rxme2Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KKX4dMo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 22:33:04 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v5 0/5] can: protect the receive lists with a per-device lock
Date: Tue, 20 Oct 2026 22:32:52 +0200
Message-ID: <20261020203257.230955-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
triggered when a CAN device is moved to another network namespace while
a socket bound to this device is released [1].

Only patch 5 is new. Patches 1-4 are already applied to the testing
branch of linux-can-next, and patches 1, 3 and 4 are on their way to
net-next with the linux-can-next pull request [2]. They are included
only to provide a sequence on which the sashiko bot is able to build and
review patch 5. Please do not apply patches 1-4 from this series.

The code of patches 1-4 is unchanged. Only the commit message of patch 4
has been updated after the Sashiko review of v4 to describe the actual
NULL pointer dereference in can_rx_unregister() and the CAN_ISOTP path
that reaches it.

The series is based on linux-can-next/testing, which also contains
"can: raw: remove redundant NULL check before netdev_hold()" from [2].

The idea behind patch 5:

The receive lists of a CAN device are located in the device's
can_ml_priv and travel with the device when it is moved to another
network namespace. But they are protected by the per-netns
rcvlists_lock, so the lock that protects a device's lists depends on
the namespace the caller passes to can_rx_register() and
can_rx_unregister(). can_rx_unregister() silently returns when this
namespace does not match dev_net(dev) anymore.

isotp_release() and bcm_release() leave the netdev notifier list before
they can serialize against the notifier. When the device changes its
namespace in this window, their filters are not removed and the
remaining receivers point to the freed socket or bcm op.

Taking RTNL in these release paths is no option, as CAN_RAW already
holds RTNL while adding and removing up to CAN_RAW_FILTER_MAX filters
per socket, which unprivileged users can trigger repeatedly.

Instead, patch 5 protects the receive lists where they are located: A
spinlock in struct can_dev_rcv_lists protects the lists of a CAN device
(initialized in can_set_ml_priv()) or the 'any' CAN device lists of a
namespace (initialized in can_pernet_init()). can_rx_unregister() then
finds the subscription independently of the current namespace of the
device, which is kept accessible by the tracked device references the
protocols already hold. The per-netns rcvlists_lock only protects the
receive list statistics, for which CAN_RAW, CAN_BCM and CAN_ISOTP pass
the namespace that has been used for can_rx_register().

As a consequence, CAN_RAW and CAN_ISOTP do not need RTNL in bind(),
setsockopt() and release() anymore. bind() is serialized against
NETDEV_UNREGISTER by publishing the device inside the RCU section of
its lookup, as unlist_netdevice() and synchronize_net() precede
NETDEV_UNREGISTER both on unregistration and on a namespace change.
The notifiers recheck the binding under lock_sock(). As RTNL does not
keep NETDEV_DOWN out of bind() anymore, bind() checks IFF_UP after
publishing the bound device, with an smp_mb() pair against the
notifiers, so a down transition during bind() is still reported with
ENETDOWN.

Changes in v5 (details in patch 5):
- report ENETDOWN for a down transition during bind() again
- comment and kernel-doc updates
- patch 4: commit message describes the actual crash path
(all from the Sashiko review of v4)

[1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
[2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/

Previous versions of patch 5:
v4: https://lore.kernel.org/linux-can/20261019152741.54854-6-socketcan@hartkopp.net/
v3: https://lore.kernel.org/linux-can/20261019074244.50391-5-socketcan@hartkopp.net/
v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Oliver Hartkopp (4):
  can: proc: skip stats calculation after reset in can_stat_update()
  can: proc: remove pointers from CAN specific proc output
  can: replace ARPHRD_CAN type checks with can_get_ml_priv()
  can: protect the receive lists with a per-device lock

Runyu Xiao (1):
  can: proc: reset pkg_stats atomics individually

 Documentation/networking/can.rst |  16 +--
 include/linux/can/can-ml.h       |   3 +
 include/linux/can/core.h         |   2 +-
 include/net/netns/can.h          |   2 +-
 net/can/af_can.c                 |  60 +++++++-----
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 +++++-------
 net/can/gw.c                     |   9 +-
 net/can/isotp.c                  |  57 ++++++++---
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 +++++++++++-------
 net/can/raw.c                    | 163 ++++++++++++++++++++-----------
 12 files changed, 284 insertions(+), 191 deletions(-)

-- 
2.43.0

