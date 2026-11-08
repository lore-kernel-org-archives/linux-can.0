Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794153954;
	b=0OnPPUwoWlu9qYUH+tMwBViBYiwJiCpVDjD7MXZ6J23GG6xRc/xgctbUuaKUHGcPtiIz
	 pm8eOzbtYyNLdPgD35wnUP3icsqtloyMPhcHHa0su7G/CgZG78KK+3sD9uADlTYA874Pf
	 QBJBT/XzebWaSXKSYDJjRBtDJQzoMJ93K7UzVlQS+VTmBsT4p7G3I3X+pJMxTv76bp0yL
	 McB4UMbWM8oscuzB9AuETpa5z6C2OtLtMulH3hiPKURMNQCTuOUOgD38JTIHZHdsk+aEN
	 VD5HDy5tgV1XyRZhHEEG1PobD+Vs4lTaQylamIIGHz8zjgtbjysbjhDXacthwZIEbLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153954;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=f3vPari8n73wTBea4YYIqqw2Gmy1BKFgQ5wguDf2108=;
	b=GFNeGNb722DR8lLaKMVeD2FTgmud53UliJVUum6nmCGXDBrs5gYVhzRSwqm4Kqq+Bafj
	 17wytana9+k9FwjPXzXBGJEcQIOkFnkYZZCJlkr/EcBgFRpQa8eprgyH5p7nehcDcbfaU
	 kIk3vzKl7rNhG4N3Pre0YQpOeyKbYZbh0SJAhPXS763tdjZ6/Vlq2g3tz1li/dAKnCdIv
	 y8Oq2RoJ2P/FEtQKGLYxbQTwQN3SxLBhT0QrVJt7gRsl1FbnAOIlTTkXnxs2UuXREmGnd
	 SyOCbPNSHCnepAm6k1XNh8tWm1XV7AfBl/585NGmKgny9ok/ImXRx3N0usjYY1ATeTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jclrZ0qe;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=e4rZTqO7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0278606A32A
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 16:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0278606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jclrZ0qe;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=e4rZTqO7
ARC-Seal: i=1; a=rsa-sha256; t=1794153943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bejn1EQay1tZ2i2qH1zzJ6lfKelv5YXLaWCzLUG/kKoteWvlCRtImmClOZ563XB7kx
    1foGE7jjHTSTyoCMIPL4zoQjx3bltrayuBNxcoSuYNDnwfd9ktr5sOAhZ1igIqk+RAN0
    ofnp8pdrGYSoCt3OIJpmzVfJRwKKerfk9fF8pwUXtZrV5dOeBjFjHbKhykEBOw5AS+04
    hCoxzj2jlzvpUJFTrLn7doeSh+bssMGvBakexY+BBOj33EFCIV/O/HYs+P7iDNfkuWD0
    ikanb56VfMjtAirUbG2elvpLwUcgh5ivCFgCUWfzcOcgxExzwzr8QqOzqH58FR4vhaBT
    geOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794153943;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=f3vPari8n73wTBea4YYIqqw2Gmy1BKFgQ5wguDf2108=;
    b=BrBPrDkmNFnCvpILPWzGNf50rm5P2QHhiN64WeH2BvVQ+gm+GGM2QzawbRqPuXVVlf
    zEx/K9WCLZ3YGM60GoYAGu2AvmTh7q3LwkZxwUzvU8eqeNLg8lOOutrp8jS6jAIcv9yL
    bwi3PuQ+IFKXkt4hvZM1haIYcq84Y+H/iVSrpYibzIknN+vpikbbm6hNmK1MmfSk66kF
    NJ2DwwEV1tTmHG35B9X0kqORBZn+3hzqGHfuUHW1r48YmPPwbk+O9JQu3uu3vzmKRTAn
    negNT3vjfGs2MfoUrddWN2/+MoJS7jZsWmmNEegPGbmBmbhfan2JUjMtBfDjYpaqZ8on
    R/Tg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794153943;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=f3vPari8n73wTBea4YYIqqw2Gmy1BKFgQ5wguDf2108=;
    b=jclrZ0qetpQb+GSDyl3N0cTVl69hBpfmENVcl7GEUnvs0vSj+5NVcw9LNv+/flQzLs
    vdw4tG4Wf9Xa4+h8w3DZ2Xg2LNOT0iDEV4BsNugKmS/bbpnM3ynED7qam+toyIOZxVWz
    Q5XmpPxxToljAaTLf1MwnR4RzUghU4McqT0AuPFv7m3lV8o6MuLSvXWbBAbx0dvR7Nst
    LgTDj75LT+3wsDFGkiR6Zyg6q4HwWIaCsuWJNlG+uTjFK6rBcA9lEOMsw+j8SCboW+jX
    sw5E6ijm978z4QdxfnmmITYf8IRnexnpZHl54p9FNk9/gTGi106IkBQxKGUif3+4W1bI
    AotQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794153943;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=f3vPari8n73wTBea4YYIqqw2Gmy1BKFgQ5wguDf2108=;
    b=e4rZTqO7mNFlggrls46Y83FPlmn8SbmjL92HCavqmZxkn+5sm+j+AmqrBA/7MC5+8o
    NrkslWcEo9jFqmYyDRAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A8G5hoVv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 8 Nov 2026 17:05:43 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/3] can: bcm: avoid RTNL stalls and enable memcg
 accounting
Date: Sun, 08 Nov 2026 17:05:37 +0100
Message-Id: <20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBAFf4Xs2TW0KFRP/ofhUNoFKrYlbSUaw
 r8LePc4ybx5M0QKhiJcsxkCTSYa71bghwxUL11HaPTKwHNeMpZXqKTDRtmnVwNasqpDroWkqii
 ZKASsuzFQa957817/OL6aB6m0hTajNzH58NlPJ7Z5//oTwxxPgutLe26ItfrWy5AGP45HRwnqZ
 Vm+BU1ZR8cAAAA=
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794153943; l=2194;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=LjG0fzbrRzuBdeB3NoqPO2Uh2JheS2TuNTzcawNh414=;
 b=At62vRuuwepOG7vSygeYc/Lk70BgzWILskwYls6mZFNbHDZOY2zna26UFY2jS96oGrh2bZPY2
 NH5t310NhrAD5Jz4werowLQww2M4aw8UxNlqLd2N1yUUbgXzeRYwiFw
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
 net/can/bcm.c          | 94 ++++++++++++++++++++++++++++++++++++++------------
 net/can/isotp.c        |  2 +-
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 12 +++++--
 net/can/raw.c          | 14 +++++---
 6 files changed, 99 insertions(+), 37 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

