Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569769;
	b=vObZy/VWPVqrhKA+hpcscA1GAJQuvF0jH4nwIhLYadKi6nsPvJvZEeVfyYNdwWcJN8IN
	 B3s8mGKfxFqebpB2/w7Wmv/oHepQd6P4YjBeCICCWH+TqVw5lX69pmh50bpXX2eJHoMhl
	 jSh2+N9ta4/VZUI9pmrTC0XHyI7SPLBwGruRR091AC0upF7g5y4ONiMn/2nLAVvnRq4u3
	 AXDtKh9Xl5bZh81QlQASE80kR7t20tW5QG4fMiFbUN+A1+s24YqlJWNAkEJiym/qaTnCV
	 aL9S+NA2+MgQqhIYWELsgN4ZgCqh+QbHGuX4ivYBqT20RpTt48FxFw74CX3zWULyKUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569769;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=IcwKAgz3ruH+bjQcgpEPCvdlWUTt9+XugmnErvMzTJU=;
	b=OpzfrDnnExgnPDCARo5jXM5sBw91u0ObZNyx+YERyDJQLz65rsEuw4Q0fzcj+EQWOwcD
	 Zdq9sK1fazWbn8kLSWvpIiZzB48nbue8d9VyNQxe2tZ1VvFIcCq8NuBljURnS078TV8CU
	 4LF1X8e9KIDpusxT6XWN4JNmS1ZhNdoOfAeLNT9DBzToE3pN5pSAKJmShPugZi5vJdi1J
	 K0F6DLKEd1LrV9V8CJFk7ix+Wneehb1YP3iOYMSvBc3TyI5zK0l+yNUZKlS4rt58g9WK/
	 DwNhhP5RUugW0IfL2GeMsamiAmWX9Y4NHEZRjwy6p6rNBHB6NA1uRQjRb6scnLgIwrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TXd7Ki7I;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=41Wxc8A0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0A606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C0A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TXd7Ki7I;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=41Wxc8A0
ARC-Seal: i=1; a=rsa-sha256; t=1792569760; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=q3nUxq6hoNb09tXTosjUj6/lFn+PabF+rPOfdWZZIYRGrJxI7jcrNjO5T/WrVI5Wb/
    qcqYVFuw4kzMK9dx2u1Kt6QhEIicHHihDzj0NLhMqpp2b4k5kn6hi+QsTOcNzDyl3cuJ
    PEGG/MlokMrZaSqmz/+maSAeJ71b9DJsYsuEmZ2YJUv0/s/kkGscc1llwnYTylU5p0tQ
    72OvHfKUD7QaE/6ZUicRgm9EeeIbE/cU9MWQ7gGjxIHWYI2Zo6BiCz032Uqz5/dlE3Cq
    gxlIPP6y2ReV9GsmJv72V/NoBiQVdHz62BnFPVQRLMXtjt3P5l9+2Epb86+OMeN1bpjh
    stEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569760;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IcwKAgz3ruH+bjQcgpEPCvdlWUTt9+XugmnErvMzTJU=;
    b=eX8g1pVGyVuW1ltAdUhVvSCZs++THsC79kEeWCgnPf5PIrhOiFM9AyDaEZuBshEiPT
    3npn7rMe6YUAyM0yYfKL5yvEt6LLv+uz/R15c2+G4XeE8GH/q7DNnI5o0cKi4D0OCtHp
    mtKZOubq6JqedvKhXRJST7rQH7zsum1rO/Ri8r2eLMxLw59HMeFUTBOA13FrMaDUslF8
    zb+zhukplhUGauBB8PK63qfdfy1p+Te9XoA0Pt4CRSvOK5rRWGWKINUuAg+7QuDtK4mX
    fLcAb1fkE9rPfFTzvvUf3AdYDORB+p9QxBmALm1eIFC/Rww2AAuBLlLSjjQiLdzrc7FF
    WMPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792569760;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IcwKAgz3ruH+bjQcgpEPCvdlWUTt9+XugmnErvMzTJU=;
    b=TXd7Ki7IJtm9pgs32x2LhQ2mLK00FHe9mqEHmpU4ru9ZCdYnn2HWKB+U+ScsWVvDOY
    JwAh6fOjEemYlOR/h7If3jWPRcWYU5WGJTk6E56hPEUCY+foKWD+oeL3mT0jFjjF65E3
    yytuI0UY0vWSVzXeSF/f6rN/02Yia75waO97uk26K179jskqIjYSwuFJLiDWhRP8Ls9Y
    rr0Q49VBgk/JUHRMLfaH3vzbe1QeOVqLPhcK1XA3flUKg3QZww9EvaXHCf2t7rW0MfbS
    wGXVhTDxfke9Bae1UE5aRuB54+bTlowNPH3pGcvC8y0SgIj7GY8n9vOibGODL1HubQTg
    /EBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792569760;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=IcwKAgz3ruH+bjQcgpEPCvdlWUTt9+XugmnErvMzTJU=;
    b=41Wxc8A0VcMLl2rqEx9nzXAgJaPV8Q+IvghDyNKGmaKeerZ0fPYE09Q/uak4Awl5Pr
    ZnrneUf/1CibXyKHRqDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29L82efom
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 10:02:40 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v5 0/5] can: protect the receive lists with a per-device lock
Date: Wed, 21 Oct 2026 10:02:31 +0200
Message-ID: <20261021080231.16408-1-socketcan@hartkopp.net>
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

