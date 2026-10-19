Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8E30B521
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395779; cv=pass; b=ebt4qIgsad2lW/88SmGOudA6Ih0wZ4NSjQgJ9CZyCoJhLXunu26uTTBtV3lNBvjdyF/r5B1rMbVoM0z5eom6eveGnvEMDdi5AY2pJVue3ZLvpLn0w9kCP4ILAELJiii94/ASg170Do6I0N1iPNZaoGToqzMts1qf+OTW6Ya1oZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395779; c=relaxed/simple;
	bh=UNZsxKeKsKDnZZIrAkwepvf8ByBCSHijnfLk5x3Lr7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZ5l6liFGA4c4w2/GOqmMzRKKCJ8nfrrXerMTXRSZoPQRUiD2bugFFmTxmigDh3O5xme0oLEqMt+hCw4Wdqo+/siHkne3jdbUjHVstQvtwSFf+6ICBNHkQ9s3Qec8ZJTpqnMih48nmrpILNOq2OgfRl90lKKFMM5CJliS6pg/rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tRczv8LB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WwfM636D; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tRczv8LB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WwfM636D"
ARC-Seal: i=1; a=rsa-sha256; t=1792395775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lBTByWRRFq3hQjZ/tiKs/uDxSJ/ziTYxo5UIoCSqOfvq0tL2ji7aSfK02xSwhg50fR
    rsBMTp1nI78b5i4zwKaIRGO7Q+NsfKIycdvzvEoMWuB+ukwsAt693Kx4fyop3EFRCGj7
    0pMhPPUTOUVdX8IR0rqkh2biLa6DqvIco5J99WcRAyJbQhpx7P5i8ommExhrUY17Elwf
    d4dRelhtuco1jzW/q01YOfR+H0Tl/dRlvzw3Q0i86q4A6FtZPBNaMaf0xXNPrQ+wX31k
    gqSdKoudOxrVwUEvcPpMOqYJXqwW/KXKNVeq6LXY/km4K/UI4+taNSqOh7JGh4aZHgpJ
    7ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792395775;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xRFhFosdZ6FnDKXr09IucNjej0etnLmgVaaRE5aJ66A=;
    b=dGrcwA13NQ8NNFMKM9mn9caOaqSMAW/S60hLXkrz9jVtqMw0m72821KxXXRBCl7vzi
    VmAO0oI0WQAFVHH/uqHWQmlDc0r/+9KGGvxHpK+FLKVwZaInJFZa5Jnjz9xCtlSfg9ue
    zgSOcwJdOFfojno2zL2t51qJAnRjkoiGmaFgtxfNerhkCmyVyJ2wIXnYtsdM0asJLPOX
    IeuQU18VKQ75VlRmOrVGC7EsCqMJcbszNXlS8MpcClVavMQ6pCQd7oghed1OskAk9i4S
    2vKUIHqcEzKZHeeZM+yWb3tqgi4wuqG4vNHh5v/km/GhnAWL6c+Jr2+J+RFxhZaSQuTh
    ytzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792395775;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xRFhFosdZ6FnDKXr09IucNjej0etnLmgVaaRE5aJ66A=;
    b=tRczv8LB2cdCdclOXjiiIUCM/Uh4Fgf/ODHNGrzG1dWy7In7q42NNqS9oFNcrPEX91
    xMbjjoZRuqkfD9pgG9Om9ezvKVlVshfwotf40K4izcIHAzZL7W1eBnbor6LBgZ/CILDH
    iFZEVXs7GZAGcBG/3zNJ4DtsaOtigazlUAtvTdxM3p2LZAY+M4GD2hH17RPX7apfIR2V
    rqYSLRDCf2/C4PKAS9ZTllW7tBIi/ds5ef6tXBizRtQtga0LStZU8SLiusmIy+PblG78
    OP7PVrC7IvXklp9bwpm1ZlvBZOIOb52ZV/kbf/NFe88brpG2v+x0IANEGtwPEn+jtgHz
    qJYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792395775;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xRFhFosdZ6FnDKXr09IucNjej0etnLmgVaaRE5aJ66A=;
    b=WwfM636DahRUbfRWYEdMXsyijpuofUFW2ZTEAI9BqeisapYmE4ezjL7Pas/2D248+M
    P1kZrcfA0lIQUJhqdTCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29J7gtUqC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 09:42:55 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v3 0/4] can: protect the receive lists with a per-device lock
Date: Mon, 19 Oct 2026 09:42:39 +0200
Message-ID: <20261019074244.50391-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
triggered when a CAN device is moved to another network namespace while
a socket bound to this device is released [1].

Only patch 4 is new. Patches 1-3 are already on their way to net-next
with the linux-can-next pull request [2]. They are included unchanged
only to provide a sequence that applies on top of mainline, so that the
sashiko bot is able to build and review patch 4. Please do not apply
patches 1-3 from this series.

The idea behind patch 4:

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

Instead, patch 4 protects the receive lists where they are located: A
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

Previous versions of patch 4:
v2: https://lore.kernel.org/linux-can/20261018180739.689750-1-socketcan@hartkopp.net/
v1: https://lore.kernel.org/linux-can/20261017201935.399233-1-socketcan@hartkopp.net/

Oliver Hartkopp (3):
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
 net/can/proc.c                   |  65 +++++++++-----
 net/can/raw.c                    | 150 ++++++++++++++++++++-----------
 12 files changed, 252 insertions(+), 171 deletions(-)


base-commit: 32c52ec87d6245ee2d12ed5dd509e40062939b50
-- 
2.43.0

