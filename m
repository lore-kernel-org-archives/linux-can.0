Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792423676;
	b=lGeCyFAdwk5vUTIGFLMhA//YFwItqHYZPmnCWDPWveG4WMfqeKAH8mjLZdprv+yTia0s
	 DOzdHff3JGBBIZLc38Gfm7p0Sx9DjCcUkfW+tLKz7n86f38pqwY1QXsiY49NrzxF4UeX+
	 mZhm2BVG4wsqOxjDHFSAKJLOhR3NOGQMfdnPA2qGY18f3cXxslexM4cXbrF1qc1dIopEi
	 nu5qjSwbU6YDMt12waem3GbuG4Y962wWsj+uMTB5bEp6Xp+w8tRAL1+2GHN1oi5C00mwc
	 RtGck/taMY+1dIwiBSq8OfIYXL204D28ZJeGY4U7vNGK00ZYQCa7vVmnAj4BTMei1Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423676;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=ffPlKIyx3CkFoufqPhSmqvsFV1BERbus+sqxODKzTUY=;
	b=J4ii6GynJoQnS7k+w74DrCWSgm2tLqRmZuOMmpqPJXun0Kksqwk0Hz0Q4oGYPJAV4dOr
	 mzy4slsERTrNq/ep5Musu6IqlGCHB39qhyljb/2o7KRQExzb8hpnQ+ZGRhL3BV+kWck9S
	 O3M3TMqpiB9Ov+dhEkgoAsKxa9y6l24tRJp0lD18HXv6EORPedIr6cfuaU8eETk5lxK9J
	 uemjGnEFgFEjw0u9uv67U8/jBJLgs58vuFi2O+8lYAUl/XthMCXxV+6rIzUGH7flt8/Cq
	 N9hNVMPFK2enwqjmyfvgK7THeh4A7f40Kp0yJf2QRD0jmPU1WGG5duApzuy1nGjSkNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=L0BfMKkb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Lo073lYg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147460B6240
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 15:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D147460B6240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=L0BfMKkb;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Lo073lYg
ARC-Seal: i=1; a=rsa-sha256; t=1792423667; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pvDHgGZIbltaWonPRZJPVG2kgMQPv859onI68O8D40a4+72RZzxAyKVkf1FoiP07jr
    SNT56OWmxkG7pdYfDuDD5dgFGpXWD0n9VXqerm/gJCYQTqDqdpJ+00hozhBziVbks9X2
    f2/nq4f2N1X7jjJqeKJTZNQugVj2D/FIoXJfw+ekKJ3aPly/1GauHqg7uEFrEkCM5IUI
    rUJ7ChOr6pCxGVfLU3NcZ7HIDTOX4yahRA4/VMOQ5+Se6jD71lkZ9Pds8ND7pw5hvQ7N
    bBrdpVMvbQQ/KvsBkBsNCBvf5Czx69+vpfyzVL58aCECyi3OpDeStSn8LCsKjpypmvRK
    Bzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ffPlKIyx3CkFoufqPhSmqvsFV1BERbus+sqxODKzTUY=;
    b=TS1Adv/LluaF8FOUotujok7mm+JQAk/5xQP4F/ZX2Ug76cpgGauA+XuT4rPpyrG3wM
    hRyQl5iGhskb/pMqlTcam5pWDn4S7q/toxpyEQZKj8KQQ4ESdSPX9P61JieGWshUFrXF
    pyYfHLMmdwJjhKtPJUGPGl/1h3OOFRETbA8Nj5rPfXmpJvJr5L1VB8Qd245VafSgfoHE
    g22tH4oeqiqSpVfRpbeXxadTDXIRmxU0bsI3sDUw1jl2kiBPMVux3HB8MdX7NEidbPBA
    mmMdtNQKNfL/+UrAEg/wMEw8cqaF3UQfUH0/ehG1N9ck83HWlgiTLhFSdtH4t1s6at61
    PGjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ffPlKIyx3CkFoufqPhSmqvsFV1BERbus+sqxODKzTUY=;
    b=L0BfMKkbpwq/Xd+G2C6R3oKY2de797oouMcchqWdPr7OmQ1hvcXgSK+1pR4n8wxuJX
    fq/395xeMs0AC0WbeXdRDYthL/hdWat68ZdJjI2d9LW9kIHnHDKXfG2Wk3Y5a+E+ffBG
    vuImZvuWuNmLeoi5Blf7/mRhvXTizteTVFcdZot3++SjtrSikJ7ae9KvIjd+hggDl/fz
    D4/VcpUGCroJxqqFn8CdIsQff9Fj/6wLoEbL799NI11NCUxcIlJ+7SsX3EKl0+lJ9Byx
    xIPGVhnRLxs0b1viSGgn8aS2jlug4zwgshTnUc9MybTYmN8sMojVI48S3yhyykhDXppR
    ME0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792423667;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ffPlKIyx3CkFoufqPhSmqvsFV1BERbus+sqxODKzTUY=;
    b=Lo073lYgyEtfAjo/ZxsYDr/wl1YoUO1SgWAediHVRQKNozZI7dPbPAwahfCe1/KyCK
    rvHqihvhTicx22HrZ7Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JFRlXY2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 17:27:47 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v4 0/5] can: protect the receive lists with a per-device lock
Date: Mon, 19 Oct 2026 17:27:36 +0200
Message-ID: <20261019152741.54854-1-socketcan@hartkopp.net>
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
unchanged only to provide a sequence on which the sashiko bot is able to
build and review patch 5. Please do not apply patches 1-4 from this
series.

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
receive list statistics, for which the callers pass the namespace that
has been used for can_rx_register().

As a consequence, CAN_RAW and CAN_ISOTP do not need RTNL in bind(),
setsockopt() and release() anymore. bind() is serialized against
NETDEV_UNREGISTER by publishing the device inside the RCU section of
its lookup, as unlist_netdevice() and synchronize_net() precede
NETDEV_UNREGISTER both on unregistration and on a namespace change.
The notifiers recheck the binding under lock_sock().

[1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
[2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/

Previous versions of patch 5:
v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Oliver Hartkopp (4):
  can: proc: skip stats calculation after reset in can_stat_update()
  can: proc: remove pointers from CAN specific proc output
  can: replace ARPHRD_CAN type checks with can_get_ml_priv()
  can: protect the receive lists with a per-device lock

Runyu Xiao (1):
  can: proc: reset pkg_stats atomics individually

 Documentation/networking/can.rst |  16 ++--
 include/linux/can/can-ml.h       |   3 +
 include/linux/can/core.h         |   2 +-
 include/net/netns/can.h          |   2 +-
 net/can/af_can.c                 |  59 ++++++------
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 +++++--------
 net/can/gw.c                     |   9 +-
 net/can/isotp.c                  |  49 ++++++----
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 ++++++++++++--------
 net/can/raw.c                    | 150 ++++++++++++++++++++-----------
 12 files changed, 264 insertions(+), 189 deletions(-)

-- 
2.43.0

