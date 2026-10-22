Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669340;
	b=bjjw4uahHiKp5AV0JDHU8b1JRNNI3+7pq/Yf4NX5KTRyywP7cCuTLLZE7mgEIybEsY/H
	 VF8XWMhxjmMZjc/SBTvUvhYXFSrW9BKgZZ4WuAkx95t4GJ/jv2s7ROXeTzBPFJdc7B3bj
	 s3EFPCBjuATvytwffcB6GeK1xVHj1qFO/5JKPdgndeEIwsjaYmokA5HJexFaHaWD5daWw
	 wUSaT35g1lt9S7li/x7F6RJxXsk9CT2jttBwhb6/4mh7lvAY7We/TG3ny67BsntldrogR
	 iVzdbTzQsFJVlgsO8b9IcMDsbZh10h8pa8gFy3PziPBYxNU0k4juOgSM+DkHu4Ll7Sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669340;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=Wk0WIrd7aHdQ6h0t+sPzrVrWQav706slCRn+eTZR0Es=;
	b=ZgUYi0b1uI27/9CvxPO9eM5UwEjBQZ4HdFx3tyGnHdZm2uyzPtwCzqvH4F/ZXxa3utWK
	 gFzLP6je/Sh6Wd6lwE5GMTCSQ0KfSErt9bJbX4rBnPsize4UpXvhxF+zJLLzAhYAym8lg
	 IBiGFfxx7JeLCwAetunvatKwyFLnF6rXPh9U97rsOkFxTMoP7+ebaHxjfs2FT0n6R407G
	 rDEYJ3x/T86qErWeZF+frOVa5K3JeXVR99H3QLa65Uy0N6bm+mhdIViiuVrdkCff4lfJh
	 92Uxsovz29mqe08AlhQk/DjMNRtpzQ/sZJvRbd6Mej0WVAECvMDeNOGIYaY2wjjml1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OQdZx2HN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="g0RR/6gs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4C606A319
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 11:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A4C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OQdZx2HN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=g0RR/6gs
ARC-Seal: i=1; a=rsa-sha256; t=1792669337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pKD89BAIDLyeESadY/hP0S0m/7yxnNKy/pku+aVtGMwXz5Sl6GuSf4vWtmMfyrONOK
    XAHkVEX/LDyjzeelxCn2va8wFuNgYb0kfb3RJ3gL37Vsge1m0iYgopXn5Jxfc1wpDNnB
    /hC7J7Y8m388yMpK08CpY2wgPRi9kpAZT5U7mqHAhIszz0WwoXXESMNpRNRfE2qv2r7O
    C8sw7TtNwTiZ7BG40zP/QcARmN+m+dIY48D0GGWVnUiwhDsOZ0rP5BAyWw8vgTvzPsUC
    fHRO0XqrxWouV8vb4fSgkaRQNkfF7qCFWXHBqcnlOKD6Hb+N67cwYEwUA0f3I+xlM/bP
    VS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669337;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Wk0WIrd7aHdQ6h0t+sPzrVrWQav706slCRn+eTZR0Es=;
    b=NgeEG7UTGYB5EBVTh7lt5V0zTpXlqUJ4XOd+Yee6Bxg13xhUXXziJTsO8hfzvUl5M2
    r8pmdR3OdbjUGaqNPWJp22yIyWjjpvnKy/yaerq1a7f/Ucv8dzUnltT99crlDEWUWgSE
    bEpcWZfUjiZZ8Lt3WYDauRhclAEbVZCTjlc8j/NC6R1eVULojrsvQbcqaOSHUyX/UwND
    dt3PNcyvpLRFJcQ4EpvyrgoXwH5phU7W3lc//kfCP/OR5cFis3NKKX+QW0/0/lC4I0zN
    9oDiM8KCzcM931yX6OkNS+IZp5Wu4HJJBuvd39FjhK8E6X1Hqef6m/QQnBnAF/YLsBf6
    PU3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792669337;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Wk0WIrd7aHdQ6h0t+sPzrVrWQav706slCRn+eTZR0Es=;
    b=OQdZx2HNv10lroKdNrdYKFiUQHqogMY6GsuutxhOeYGaQu1+bW6pFdnWva/Fd/zNZi
    YpASTKalr4zDxpmLC0H0DIubE/2Qo4rdV0GSDttET8DQ/1UaeK27F5w0iKbnPSp6Ud/E
    8yd6FTZ8yOuzkD+qqphMtYY71bOX4EuhVJxlTDUjxzJlkrJglNoLqaAdgE9yvFt+4GI9
    q8MANgU2cajOOHdJopLKHAA7ZqV+icAIuj49suDK3nzq4y8VhjJqnOksFj5VrhYl/PaX
    GTbq1WNGvupUg5he0cVVdL0hbgV4ooGsp7TR55MHeMPHFgke9zaY30yPDkhHhbS/hX3E
    xltQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792669337;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Wk0WIrd7aHdQ6h0t+sPzrVrWQav706slCRn+eTZR0Es=;
    b=g0RR/6gsAkw/jZDj0uKYFbSlquneESEbHJ/0q8ukCYKFotVkGRB2JB7WjtyTFKBZhF
    hYBIhiQi7eALWF+ni1CA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29MBgHo50
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 22 Oct 2026 13:42:17 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v7 0/5] can: protect the receive lists with a per-device lock
Date: Thu, 22 Oct 2026 13:41:56 +0200
Message-ID: <20261022114202.180023-1-socketcan@hartkopp.net>
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

Changes in v7 (details in patch 5):
- report ENETDOWN in bind() and ENODEV for NETDEV_UNREGISTER under
  lock_sock(), so ENODEV can not be overwritten by ENETDOWN (Sashiko
  review)

Changes in v6:
- isotp_bind() checks the device before publishing so->dev, so a
  failing bind() can not get a needless ENETDOWN (Sashiko review)

Changes in v5:
- report ENETDOWN for a down transition during bind() again (Sashiko
  review)
- comment and kernel-doc updates (Sashiko review)
- patch 4: commit message describes the actual crash path (Sashiko
  review)

[1] https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
[2] https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/

Previous versions of patch 5:
v6: https://lore.kernel.org/linux-can/20261021231130.2085690-12-mkl@pengutronix.de/
v5: https://lore.kernel.org/linux-can/20261020203257.230955-6-socketcan@hartkopp.net/
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
 net/can/af_can.c                 |  60 ++++++-----
 net/can/af_can.h                 |   2 +-
 net/can/bcm.c                    |  64 +++++-------
 net/can/gw.c                     |   9 +-
 net/can/isotp.c                  |  71 ++++++++-----
 net/can/j1939/main.c             |   2 +-
 net/can/proc.c                   |  95 ++++++++++-------
 net/can/raw.c                    | 169 ++++++++++++++++++++-----------
 12 files changed, 289 insertions(+), 206 deletions(-)

-- 
2.43.0

