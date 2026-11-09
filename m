Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.220
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794258263;
	b=UfZzSpGRTgXxuA9G6edAXl0o6Tmawxpbjmed66B9piCENuiK7zIs3Eq2rR//XnYiKalr
	 uH0y7ZedlpXkcSMQbi/PDvHL9z+3Wq9L7x0RcZg6YV7Pn6jsE2ADW0fevtPIW45fNDZoR
	 xBjUX4f5DIcuQCpn+HxjIq2GP9B1rPsVWpa3IenRqSMUBOy2O/FBlkn6I7QfpnBhwLQuJ
	 dIiThwVtn6f4jtfjyhHIMa+GpTyELpq+VLCK/7q9X71bGfg35jlMuW9SZa9DL2OVH+S0L
	 Smqf63nBWdhss6FZ4qgJ+lsHO8W0CQQ0gRFILtj4b40i0TB8hB0e19DXGtkflt8uz8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258263;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ct6EiwlbdCUCiMf+/ow2gXwDv0i5U7dREeDeUjB447U=;
	b=UUw8e9ALvXpSIktqxFaF2RBWgDFSgp7cu/rSpqEYe9S7+73ir3ByNVPX6lzF6iCGoCjn
	 wNykntWIvEZ1cCvZoFVO2LBAb3YAhf7QacmO/aYqSDJWHa+k6TxriUPhCNd7Lxs7AkEf5
	 f12R7db2bzWSrdUZASRX1k1VrzmqFMdBVFYfZ++d+6uJoZTPYpclQBN0472SZbZMm05y1
	 mlxRCpHenfr8py/jGsYtdKlAErNGmTdxSD4B9LSWFep4W3RT5mO8+d8CMNC7xKcZJlMBg
	 mvO9GIC4GdO6lT2USeaMlnZde4CAfioEKCCPP7s7eiVcILqYp+pNWRR+on4+p8fHHaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sVej1Fq3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=CAFix5fu;
	arc=fail smtp.remote-ip=81.169.146.220
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA4606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sVej1Fq3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=CAFix5fu
ARC-Seal: i=1; a=rsa-sha256; t=1794258240; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ixYXEkoW+OlDxTyZG0NYByZje6Vu5B4TV1wtRssqIER8+0xUDeAyAOVKpe3+4reiCM
    my6BXlDpaqiPcbH9awbL8l7Xc0hCxkHS/BekzQf65UKw6gQjzbwHOzXA5H4QN6SPp3C+
    E7lDsH9YQ3p0XwAQsM+RbYxVcv5pCv/NW4aCMVUA18tolvfcu6pZOnj5KGwN7WQrtKus
    97vYEyvdPukACdkmb1OPez3eIV8bE382ly80krVDWoRXTD+thTRjVvF2suI194Xaq2z1
    H/vXe4+kR8Md0uhPhZkrLxbIelvUlNKvIPsKLvk3LB32SMZbogFM0J+aybqMJXcHcJ6v
    J9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=ct6EiwlbdCUCiMf+/ow2gXwDv0i5U7dREeDeUjB447U=;
    b=oZ2iXmXk7aVPHbRGQ8WhSk5eHThA3OpTIO2EJvawsUflujNkzNK/uTKCIAnEBtJFK7
    KYZsxvDmFlXn6b9mg9WMTU+0fOOhXeSArPb1pOe82+iY1kpkUASl61SzKDt8Lmr1kzQv
    4w3rBpVC2G8XWlk4/6J1mJPfyzR57qtA6yLQB67j3szlRnQAJGIvnh/uHQHSM4QpKsgw
    0UyN0KPMhso2vgUY0hSD0F0vnTUJ1ywE0I3KrbTkhOs1VaWkE+QkW8PmLDta5k7iv8j5
    JVhlfXsNQGYdMtXb6RFJr4hBhlSujXp+VU8nNbtIWcadtEqapdDYvUWl8QVa0l1XSWte
    t3JQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=ct6EiwlbdCUCiMf+/ow2gXwDv0i5U7dREeDeUjB447U=;
    b=sVej1Fq3yARtCrJU/ulbtbeWqU1cIUUf83KIgqjMKp8rGzEStC3vPix5IvgfSlALUM
    HDTF8VDQ23/hFz+SrxTSNClcrKSFE1DRKGbIyBSZXoc0VlyDTNB5SUh+hRMUUlLEAx/d
    +ap0OFpKYM2NvcRAJ4edE4dEzZVNzWHAzqHyUutXGJTDVc5hFseCFDDtCf3/qge1FA+W
    w5H6LJKV9yhuBxNnafDRWargSca35MUtBQdiFEvh9mCxyVzeKabera0vAVkqge8GKXDC
    IS1vugbn4BppT4LQq+CvMDKsmjq/OBIUqMTAP9t6yu6JmpU5O/62KzQm9r/1+h4LvGlb
    Du7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794258240;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=ct6EiwlbdCUCiMf+/ow2gXwDv0i5U7dREeDeUjB447U=;
    b=CAFix5fuvpf5vyeBoAuz3FPdEZQUqfCfHngPxAepwKgWK4dvLKa2Gkxi8100QDhuNN
    w+kVfCPmiwV4KTBbEICA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A9L40w3B
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 22:04:00 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3 0/3] can: bcm: avoid RTNL stalls and enable memcg
 accounting
Date: Mon, 09 Nov 2026 22:03:53 +0100
Message-Id: <20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBQE0Ks0rMUUqi115T2MCwqfFrXQABJN0
 7sLdWOMcTnJzJsZeXAaPDoUM3IQtdfWpFBtCiQGbnrAWqaMaElrQsoGC25wJ8abFVc8wih6TCX
 j0FQ1YRVDaTc5UPqxmqfzO/t7dwERMpQbg/bBuud6Gknu/fMjwSXeMSpbte+AKHkcuAtXO01bA
 wHli0g/EfYLoQkhreJKKtFKQr+QZVleL1NLcwwBAAA=
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794258240; l=2446;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=EJ6GLQHPHUExYoU/vlZvGOyQVl7glit/nRsTRsdpLws=;
 b=w/1fD8rmCisSVngdKrQYGxJeOuBof77JOBibam+jKsZhFf7FwvFYeIHKhrg5lAfJfOyT+UILT
 HZKY0ETD6rSDdN07M7KfiVuZ6jQuETQ8QvGyn9WCYuEVvTJ6nsCutBa
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

This series addresses issues that allow unprivileged users to affect
the whole system through CAN sockets.

Patch 1 copies the CAN frames in bcm_sendmsg() outside of lock_sock(),
so that a stalled copy from user space can not block bcm_notify(),
which takes lock_sock() under RTNL.

Patch 2 keeps the procfs entry of a CAN_BCM socket until bcm_release(),
as remove_proc_entry() in bcm_notify() waits for stalled procfs readers
while holding RTNL.

Patch 3 enables memcg accounting for the allocations that unprivileged
users can trigger in the CAN subsystem. As there is no specific commit
to point to, it has no Fixes: tag and is not marked for stable, like
most of the memcg accounting patches in the networking subsystem. If
you prefer this patch for net-next, please let me know.

CAN_J1939 has similar issues with lock_sock() under RTNL, which will
be addressed separately once the currently discussed j1939 patches
have been merged.

---
Changes in v3:
- patch 2: read bo->bound and bo->ifindex with READ_ONCE() for NETDEV_DOWN
  and shortened the bcm_notify() comment (Sashiko review)
- Link to v2: https://patch.msgid.link/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net

Changes in v2:
- patch 1: fixed the description of the stack buffer and described the
  remaining generic SOL_SOCKET paths (Sashiko review)
- patch 2: read and write bo->ifindex with READ_ONCE()/WRITE_ONCE() for
  the lockless access in bcm_proc_show() (Sashiko review)
- patch 3: keep the GFP_USER | __GFP_NOWARN flags of memdup_sockptr()
  for the filters and describe the local j1939 ECUs (Sashiko review)
- Link to v1: https://patch.msgid.link/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net

---
Oliver Hartkopp (3):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: enable memcg accounting for user triggered allocations

 net/can/af_can.c       | 12 ++++---
 net/can/bcm.c          | 98 ++++++++++++++++++++++++++++++++++++--------------
 net/can/isotp.c        |  2 +-
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 12 +++++--
 net/can/raw.c          | 14 +++++---
 6 files changed, 100 insertions(+), 40 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

