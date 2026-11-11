Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410540;
	b=BGoI7eksiq8UV4Mz8ktGn23P41+to781plzFxoU4DWrTdhDImID/P9Jr7mJfxmaG93mR
	 dTVMnZ+QnVNUywL/W/cnX4UGEM1yfyECZaMoGUWbfUTBwmxXl0EJq3mfsW3hyWWWOmLjA
	 7ocz1iHJF33MyfHpQkja4oem+YTLt5tEsQT3QXBtXb+oP9EhzgT5mIv3misUadOYKjVCQ
	 LLs+1b1PZt+hHt6SLETSOdMvErl5f2ta8/K9fiwgtQxFf9mjDbLbf5rvRokcGWFg6/1S/
	 hvNxUukObyBTkK5c0aAKA845EMWmIoTRU2q7bwxNhueQMZtiIp+YBySd6HSq/tiNYvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410540;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=OK8oIYyzQAEkbInZNO/xm5DMnrehkWW6djJxmOwCwNM=;
	b=lHXazS3By89j66eUXOIWNmdbnNVH7QAky9B9hpqgM7ggCq6oSGCkUU07jeRriaCW5PkN
	 EHviISPLd1jno6Y7DXKFrELzoNP7UqQI60GteYkKYc/3AgYnUyfMJVX4Cy5HdGgED1hHX
	 AmT2k6P8rWNWqGd/eg03Yg+0AUqg8yt9o1AaEq/tW7Fr5c/9VYI/DDMcxrd6aQ6yMcdJ3
	 djRfd3sf+NmGAK3FI8IuQ6WViK1JyRfKRJmXnP+Yrw/BqIt0SqkZRlk+q5Vp7CDsEJYWs
	 j3bvvXRH5Fny8lRrVSZPOg9f7ZXwuqskGHw+Tcy6G7dkycbBgVahQPIjZoJh3gfSTcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oxJS63a9;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=urRaNEF3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A21606A333
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 15:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A21606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=oxJS63a9;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=urRaNEF3
ARC-Seal: i=1; a=rsa-sha256; t=1794410512; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bw4llhQzDDvgUHYKBzey8d9J/eKpeVoj3tzufOGI1wO3Pt8oXFltd4k2CRLCovuTnk
    C7UdvicJeO1CENuRSrHpZ5n5Wp9ph7NEH1denHUjgRb7tQEZrtJny/RqUwJe5+CEZkSA
    7UpVM82/KgploYe/DeFMBwJQMEiUj9soP0OF/6NDsKTi5n/V/hYmRFb6Kf2eFJimXIET
    LUaPUh0nMbHTHJ5W8DxiNSdBPcMcVP7Tmktdx9ScTPqwadLT8tuqiUfd7A+RfjJVp2OZ
    F/em45FAZFWhzYt3uv77w4mwuB9Z2L9YVS5KBfeP9hNCpxPWemiqRF6qIRtfzQACN9yD
    qWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410512;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=OK8oIYyzQAEkbInZNO/xm5DMnrehkWW6djJxmOwCwNM=;
    b=UMeYMVr/qMg89C/1igP0MrL97GHaRJQl+RmYmNp6JgOUoVuVWlGmFqvmB1jX74dJQa
    IAVeU+xnXDkwUZhG+2oBPD2Z6zK5meQEsG4G42Vdke3zshgSFDtzOpUIub2skiFu6B1v
    OmHeZNa5ps0RQHJ67JBifpv2sTN3jeLZhl34ih5HJSsX3u18+Sv8s7OkPvJolyOOX4Fq
    AbvgHlAbPbx0MlcTAGTJbPCPl/sHnP35Y8w2CRZpwut6qGaYGAc7LBI5X9BMlf7zWGjE
    OCoUugm6fk18xo2HhSQn/7iFbhtBBu90Sx8YLPLPJkNjX2pwKJDLirsJ8/vh4qhsJVtY
    uwjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794410512;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=OK8oIYyzQAEkbInZNO/xm5DMnrehkWW6djJxmOwCwNM=;
    b=oxJS63a9rjpiBGAD+w8AdqQyg4z3H2KYEeBi8jeyUY+xLeZdXkGX7rRpRmXMh1qeU7
    xaAs9a5KPYlKEJdzVHofN+07nyRIWurcrpFcq9IEhBaSY5r48Ze8GrcD9fChmpFjjxzD
    4D+YjcFcPF85cCwRB9Y1f2Z7KzT004ZpMhEmRL5t9BHmcYMxuPrihPPLwAvicj0eBGta
    qcMG0PfR3+9p4iOPUecsJvBUjgRWMoYfj00gezpcOG2fe2LAK/jGJ/KvGvZXjkLVMjoP
    obYztigpdG2YusiF/d7Jfq3Bq+BR7kruidgiuvu5zDymtSwXT8p9vvIjhgMlxYopU5+t
    OOcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794410512;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=OK8oIYyzQAEkbInZNO/xm5DMnrehkWW6djJxmOwCwNM=;
    b=urRaNEF3QlO/FSm9nIbbRcAWikT24U2XMMcfoFR9m+iC35aUQPUcIzTN8fnuIpJdEH
    wTkOgqm3RxoJ2C8fk9AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ABFLq9Lx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 16:21:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 0/6] can: avoid RTNL stalls and enable memcg accounting
Date: Wed, 11 Nov 2026 16:21:45 +0100
Message-Id: <20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NSw7CIBgE4Ks0rMUU6ANceQ/jgsJPi9pHoBJN0
 7tL66YxjctJZr6ZkAdnwaNTMiEHwXrbdzFkhwSpRnY1YKtjRjSlBSFpiZXscKXaR6/uuIVW1Zh
 qLqFkBeGMo7gbHBj7Ws3L9Zv9s7qBGhdoaTTWj717r6eBLL1/fiA4xRmnWpi8AmL0uZFuvPfDc
 OxgRMtFoFuE7yE0IkQYabRRQhO6g7AtIvYQFhGqS8GVZGle8h9knucPKP30R1EBAAA=
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794410512; l=3787;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=rgFf3nJCpzxefX1Qfnz7psZKazUX6wm9VQqm/lfu+xQ=;
 b=A6PTXWgPADh7Ldf3reKLq04+ENljXCX0kie6NHEy9A1VaLAy6FOWjniL2G0/bhjPzm3SW89wU
 YOumExCyirXBKHfz0cdcS0g8zMsb3H25kxkv0Bge70Gj9HpR8p09htz
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

Patches 3 to 5 replace lock_sock() with a private mutex in CAN_RAW,
CAN_ISOTP and CAN_BCM. The netdev notifiers of these protocols take the
socket lock under RTNL, while the generic SOL_SOCKET options in
sk_setsockopt() and sk_getsockopt() access user space under the same
lock, e.g. for SO_ATTACH_FILTER. As the generic socket options do not
take the new mutex, they can not block the notifiers anymore. The
patches for CAN_RAW and CAN_ISOTP depend on commit 43c973a0887d ("can:
raw, isotp: copy socket options outside of lock_sock()"), the patch for
CAN_BCM depends on patches 1 and 2.

Patch 6 enables memcg accounting for the allocations that unprivileged
users can trigger in the CAN subsystem. As there is no specific commit
to point to, it has no Fixes: tag and is not marked for stable, like
most of the memcg accounting patches in the networking subsystem. If
you prefer this patch for net-next, please let me know.

CAN_J1939 has similar issues with lock_sock() under RTNL, which will
be addressed separately once the currently discussed j1939 patches
have been merged.

---
Changes in v4:
- new patches 3 to 5: replace lock_sock() with a private mutex in
  CAN_RAW, CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options
  can not block the netdev notifiers under RTNL anymore
- patch 6 (was patch 3): charge the isotp RX buffer to the memory
  cgroup of the socket with set_active_memcg() (Sashiko review)
- Link to v3: https://patch.msgid.link/20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net

The patch numbers in the following changelogs refer to the patch order
up to v3.

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
Oliver Hartkopp (6):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()
      can: enable memcg accounting for user triggered allocations

 net/can/af_can.c       |  12 +++--
 net/can/bcm.c          | 124 ++++++++++++++++++++++++++++++++++---------------
 net/can/isotp.c        |  39 ++++++++++------
 net/can/j1939/main.c   |   2 +-
 net/can/j1939/socket.c |  12 +++--
 net/can/raw.c          |  55 +++++++++++++---------
 6 files changed, 160 insertions(+), 84 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

