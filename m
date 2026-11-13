Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566003;
	b=g2xCEKh23BS1paiiBVfA/3Xd1zrDK4is2yUw2ZerzdklwO+tbgYQ9aFHFdm1lNz5L9O2
	 PIjW8HOm1wMSAz4b9OeSKHLE7ftekou6oqL42GBMOn/qU59me/KYSWeYXecV8eeMdGvfA
	 VDIdtQTISxwd0vHTKsQLD6qZZWgEvEK913TLmh+Mzjg1+MXXVDK6OJA7/7fFHgIgKxGCb
	 ppePuk3yg64M4YoSrPiVS9mo2Ui0MuKp5I0WbBlV0ptyk23UaNBOIHwFytNh8Mag22r1L
	 koTC9xwsCKvmIVCMS6IutMy30LIuOOk3kaJL9yjBNUiUO/PaHHiR5snuXGhsK7blLOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566003;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hjfuxDQdR6PQ9NBoIR7mgnkeKpqx274CTQVyXtKbfKk=;
	b=XftCXXi3FoiqeQsJNiiXoV4/eU10uGTg2LKH6x8cQvI/ZEJSzoYWdLt/7W1e7OVNEOm4
	 Rj5/hgsWbONY3L2K+d2n2iysP5Mq04BVmbo/SUnLdOVqFPpk0iinkXHvyk0sCxXhJqLGK
	 KqbEpDZQcjoPNu+iiM1Ld0e0lr0sgQpq5tXPt+fyoxuq99krIlYaZSE2mfzTLxTRJpdnF
	 QZ+UzQIPqzTzoBEgT2YISwVagoxfNF5S7mE+c+KebD3k9TUxbf+Bmzt840ua+sN/T2UDJ
	 yTOEK9nGTCjBppDW5iD1voeDCFQAjiyXTzoJa2+THoHWn+CBh2/UbOG8jOEsAq/K1sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BGSQrSS7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="DjMES/lx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.218
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38B606A321
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD38B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BGSQrSS7;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DjMES/lx
ARC-Seal: i=1; a=rsa-sha256; t=1794565994; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XYzjCqZY3AvbQ+bqUP5bh++ADdPlHlzfsf1EJnN+NjZuGmWOmv/7qXeH0AD9S3mPZl
    0zq+SUqLi/f1crq+bGUN2vAEQaI6BG2gw0S8v2RQT0ZA3Ri13tNumGIlDMl3uJsZnbw5
    eprBc5eW0r04cWS1puy7KR7gdfF2YLfGyDp7RdlGmbF/nwz8F9h5Pqh6kAPy4wD+SBOY
    BLpFpv65pfCeOSVwKO1t7uROCnR4s9ZWKviQOvpumsc2TyyCdW3Z3Dugj9WYIZr4g9DJ
    8/27zdWw11cPqjJ0T6jQt6oy7KC2wn0F1om8yT7lxMPo4I9jTpakpr5AthiY4vD+mkdj
    BDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565994;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=hjfuxDQdR6PQ9NBoIR7mgnkeKpqx274CTQVyXtKbfKk=;
    b=iMIqJsn4RO9SEIE4wvi73sQkYQljx0Ttk6WcSZjdZ4Mq1U3ZFoY0NekUcrgqtCEcif
    zXWFf2ynDcocpF1aq7PFaFVtKP5lbW0xNmU72C8NiqgJFp52aJNWjgbd5D76XpI101e3
    ZshHMgR0uYz2hkjiVkzYHBNzCtNWpkgg/N2wJkGZfrQGrvmGrbGdNqOFhNWXzFO22d2q
    cdECVlWwrRqG6HtWJd6msKXsaguKQlCh5GIfYRzDKQDF4QQJ8C6F1DFJ2kuoL6Fp7wz8
    quASdxa2sQJOTIUsvQssyhN5KOcvGPX+b6/2v/QAHr9Bty8HcydTCmHcxTeD/gEjHCTi
    y/ug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565994;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=hjfuxDQdR6PQ9NBoIR7mgnkeKpqx274CTQVyXtKbfKk=;
    b=BGSQrSS7ZKrmwghE7+wVA4bYw/cjiuJIYU/3PS/VB2JnoPFEfENSGH/7dIguvwiBev
    KPsaahLmsJoBepz6VX61Gq6pBBbk+uGiEm1Ft0MpHocH6vGrM3hcm1FL9cGzDQUzZX8M
    wOBlRaWF06ZKmWADRSpq1O8qPQFI6nSKYpkDetgSQ2Ndpi4tAg1jsnoawbvA8b1A2JEk
    CGc9qasGrZHwcI57jSkui/y5hew7xd4psTfMfVyDFDlqg1wgVV920QhlWqpQiVlgfbpm
    h5iUkdGksFa8BxIJ7fI+7OhdRc0WYXLFUXLS6uMF8hMP0lpeh4IJa8p/BaLhuzPNdzY1
    dQdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794565994;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=hjfuxDQdR6PQ9NBoIR7mgnkeKpqx274CTQVyXtKbfKk=;
    b=DjMES/lxwMkog5VI5CjUHfviF1kD4Y9XKt854gOXoKgg2CMrHFln5tZS7yjD2mSa9c
    or8AFxNjyXjKuyb+b0BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAXEIs5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:33:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 0/5] can: avoid RTNL stalls in CAN_RAW, CAN_ISOTP and
 CAN_BCM
Date: Fri, 13 Nov 2026 11:33:07 +0100
Message-Id: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTW7DIBQE4KtErEvEA9tAVrlHlAWGR0xT/wgcq
 1XkuwenG6tCXY40882TJIwBEzkdniTiElIYhxzqjwOxnRluSIPLmXDGGwAmqTUDbW3/Ndo77bG
 3N8qdMihFA0ookndTRB++3+bl+pvTo/1EO2/Q1uhCmsf48z5dYOv95y9AGa0Ud9rXLYJ3587E+
 T5O03HAmWwXC98jqoTwjID2xjtvtQNeQMQe0SVEZIQ7qZU1gtVSFZBqhwCUkCojdcVVw6RpmPJ
 /kHVdX8Y2YEiWAQAA
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794565994; l=4694;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=zYPLqcPA8UAX+VrORfYn0CCIXU8MNEMNbW5lx2Xk+fI=;
 b=j7ML8PJBfuMq2pkVMkqSigcV1WVBr+ZSvOjS18wT0cHqQ3bTLbAf5O7PkqUHdLeSgHz9LqrJd
 uvcIEhgs0qvDcaaBayC335tN4GmEnYyuP2lVsjaSIgDZtkHYON9BgZP
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

This series addresses issues that allow unprivileged users to block
RTNL for the whole system through CAN sockets.

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

All patches are fixes and marked for stable. The following changes are
not part of this series anymore and will be sent for can-next:

- "can: enable memcg accounting for user triggered allocations", which
  has no Fixes: tag and has not been marked for stable
- follow-up patches for raw_getsockopt() and isotp_getsockopt(), which
  read the socket options under the new mutex and copy them to user
  space afterwards. The socket options have been read without a lock
  before, so this is no fix and goes beyond the lock replacement.

The series has been tested on a kernel with PROVE_LOCKING and KASAN:
A stalled SO_ATTACH_FILTER or SO_LINGER on a bound CAN_RAW, CAN_ISOTP or
CAN_BCM socket blocks RTNL without patches 3 to 5 and does not block it
with them. Generic and CAN specific socket options have been run
concurrently on shared sockets while sending and while the CAN device
was set down, deleted and moved between network namespaces.

CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
has the same issue with the generic socket options. This is not
addressed by this series and will be handled separately once the
currently discussed j1939 patches have been merged.

---
Changes in v5:
- removed patch 6 "can: enable memcg accounting for user triggered
  allocations" from this series, it will be sent for can-next
- patches 3 and 4: the comment for conf_lock names setsockopt, as most
  options are read without the mutex in getsockopt() like before. The
  commit messages point to the follow-up patches (Sashiko review)
- Link to v4: https://patch.msgid.link/20261111-can-bcmlock-memcg-v4-0-5428607a608f@hartkopp.net

Changes in v4:
- new patches 3 to 5: replace lock_sock() with a private mutex in
  CAN_RAW, CAN_ISOTP and CAN_BCM, so that the generic SOL_SOCKET options
  can not block the netdev notifiers under RTNL anymore
- patch 6 (was patch 3): charge the isotp RX buffer to the memory
  cgroup of the socket with set_active_memcg() (Sashiko review)
- Link to v3: https://patch.msgid.link/20261109-can-bcmlock-memcg-v3-0-2d798ca30578@hartkopp.net

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
Oliver Hartkopp (5):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: raw: use a private mutex instead of lock_sock()
      can: isotp: use a private mutex instead of lock_sock()
      can: bcm: use a private mutex instead of lock_sock()

 net/can/bcm.c   | 114 ++++++++++++++++++++++++++++++++++++++++----------------
 net/can/isotp.c |  28 ++++++++------
 net/can/raw.c   |  41 ++++++++++----------
 3 files changed, 119 insertions(+), 64 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

