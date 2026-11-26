Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727178;
	b=aVhx5NMmNR7KMR0qj/4SYCHuFyKuw5f+OQrM/UVqluudRAMCbJorxyQVAAAIwo4ZsOHZ
	 MWsCtLignVR0GKg4OXbqi8Xnq2xa80KCiSPBItQ10C1FcFS06hcg56QXsvGXW/4KR348V
	 im/ufc1UWpNEcMc1TaMVUMgxEiD01U2qRrAgVXIfLXvOruw9hepRHfTpveG6+T4B7UK40
	 R3pjt9pn95RKpLnHFYIkUwyA+0lzYuj47letSn3qDSAP0ElGbZmxlWAcfuySWDEsyziba
	 llqWomw2Jkz4QXpIogVS9JuKXcaxO+WN4kzH3YT+bixwnlVlOUmtyShyn9UvaMP/4xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727178;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=H9DAAtYiJn7VfiCm4ks+dJ7x/xThJ6GYZvq4VUxUmR0=;
	b=aryQ6OQM+42EjcHJVCQJtzf7HBP0wnt+vulNllT9tb4L9bWOfHs6BKPcuqB+jq/E3ysK
	 f0OP9JHViRRQFPDYWimmxye3Yiz4WLTWqL/muAUTo/9nMSsUftHSxPLOOSsXbx7CLeKJ1
	 XW39pOESBr3HEv3o6kukOPYUikVC002x/kk6PnBvLyeIbWXGh+j3l2fhihU8RkxevBPg3
	 ncbYKtog6Wl5mavnKzqkmWorrrWxTRphIzqCmWnzt9hL70JZdzvx+MQ3IB181dbJFMUrA
	 gIablTCb+5h9CeSPBhWeLLG+Yg3TV4WVq3RMWgAaU87S8FJ5nHgVe8KKziGDRDIkvag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=JH+kacsx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4FWVshqc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB71606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=JH+kacsx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=4FWVshqc
ARC-Seal: i=1; a=rsa-sha256; t=1795727150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VhEu4UODjgc2sCvPyDdB0g2B4bSRfizsKfDzcHizE5S1eXqJEtyjopHslwyj232R3j
    SvKe4i/BaAPGep21ESAVu5R9J2pIjGz6VV8wug8PRNJo/jLI1vRjc5/g8GTz3gBTGyrG
    7MmRAaK0Oi0DhzdHdBW5KCdfFEaChWw4uUjQfZsD4+VxrfpYfaNAfg/b9QH86oMYPoUw
    Yazgpzxsdnmpg71CfhqL7HRl1v+0J3tujdF8pKC/uisoSV7s0TuVvZ8+l/f23WSlPlA5
    VbyoWXuCLiZ0HQIIwIKpzv8WrtmLLD6FEquT1f+hNc3E0uSCyNcb7EGk/dH+UxY40CdP
    5/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=H9DAAtYiJn7VfiCm4ks+dJ7x/xThJ6GYZvq4VUxUmR0=;
    b=ktoAj607fGbvIRL8q4MH1i/6SZnj+/CWQQ8Nm6mLTdWa75GruS2MCH9CKapT0xMYNM
    HwTPK2P0v0/CpLdGWGTcdQqGE5+gmY7VB854CmzJzYLuMwd800dUY0K2SIBYfvCGr1p8
    +w87v4N40LzyRy/fRuk4+e+sC/zuzbEwSd56qaXZYHzNLk5LdV8sk41pbTBQ6LHeJTYx
    F8METTCUn2yIwNP0zMHrOJhUsi8eodXdKqAWRwLGPNPPCUNzmNW36UJ7FvgxzQ+5X4zQ
    SJ4bbbmFpoEgSg9vV3qT4hU9ulBblZ9PdpYT1SrknsK2DgrZEtWWDBDlZfNQN+TSNnpI
    LeoA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=H9DAAtYiJn7VfiCm4ks+dJ7x/xThJ6GYZvq4VUxUmR0=;
    b=JH+kacsxXC4IPyXQUXT6XVdnywztmq21q7dQ7she1LJw2oAwO+8ZDg2cECA6nwNatW
    uvr6Q4MmqfE4nBvVGry/TUX7zQsfezaIpx3ntoKTSOGw+21nggeILgUnry9G43/ERPDn
    9P55zdtrFW11BuO4oyv3nzl8GZICfmHac1DTIKhJCm2t1EeUJLXfJjrym4Bd86jPuxDF
    2sXE6MvGCvUM0Hz0WS06sQs8nMHuhGgdZrF/1+b7E94YbFqbKT496hAMhiE3k0769oYf
    JwE7zj61jq2ll5RBnq1o3N9SOVsluQzegTjtFWhbYaEc0+l9PEGBnUzxjax3WAq3zHBr
    U6dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=H9DAAtYiJn7VfiCm4ks+dJ7x/xThJ6GYZvq4VUxUmR0=;
    b=4FWVshqcrYkrbKtzvRnjY75uGOqYfKlQ6jnvdhsYItRZHzgcY5TNUc4gnFxHFMLdht
    cdmgHNk18tdVfPUtZvDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5otUW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next 00/22] can: memcg accounting, CAN_ISOTP fixes and
 cleanups
Date: Thu, 26 Nov 2026 22:05:42 +0100
Message-Id: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EKTagW/Ih7SzRpXaRKyUQqlf
 2/U4zDMrKBchBUu3QqFP6KSYgNz6IAeLgZG8Y3B9nY0xo4YuGqiV8oVZ54poGiqGfuTPQ4DnZ3
 3DlqcC99l+Y2vQC5i5KXC7W/0PT2Z6vcL27YDKkGNoIQAAAA=
X-Change-ID: 20261126-getsockopt-memcg-isotp-052433c7adda
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Wentian Ye <yewentian395@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=3580;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=DnzAJ6drFcJi7DviRsK7rXRtI79GMIZR9ZvWOSQFcko=;
 b=il8LIIOU4lz5C3RVYN1+LcmZxJGQDjTRqaFlfrxQObZBBj/aH6dl6UHwUozhWwYUFRz38KULI
 k778RWIigVqB1QSnxidBMroSYTJuf+W3J6z6VbU1rklfx67yL/gQFR9
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Patches 1-3 are the remaining CAN patches of the former lock_sock() and
memcg series, whose first patches have been applied via the net tree.
They are followed by CAN_ISOTP fixes and cleanups that have been found
while preparing the CAN XL support for CAN_ISOTP.

Patches 1-2 read the CAN_RAW and CAN_ISOTP socket options under
conf_lock, so that a concurrent setsockopt() can not lead to a mix of
old and new values in getsockopt().

Patch 3 enables the memcg accounting for the CAN allocations that can
be triggered by unprivileged users (socket structures, receivers,
CAN_BCM ops and frames, CAN_RAW/J1939 filters, the CAN_ISOTP TX buffer
for large PDUs and the J1939 per device data).

Patches 4-8 improve the CAN_ISOTP socket options:
- check the CAN_ISOTP_OPTS values before applying them
- add the documented frame transmission time (N_As/N_Ar) to the
  protocol timeouts
- reject undefined CAN FD tx_flags, reserved STmin values and
  CAN_ISOTP_CHK_PAD_DATA without CAN_ISOTP_RX_PADDING

Patches 9-14 fix the CAN_ISOTP reception against ISO 15765-2:
- drop frames without N_PCI and FFs with an invalid length extension
- check FF_DLmin and the data length of the last CF
- do not send FC.OVFLW in listen mode
- ignore invalid SF/FF frames without terminating an ongoing reception

Patches 15-22 are cleanups in preparation of the CAN XL support for
CAN_ISOTP.

As patches 4-14 reject socket option values and frames that have been
accepted before, they are intended for can-next and do not carry Fixes
tags.

---
Oliver Hartkopp (22):
      can: raw: read socket options under conf_lock in raw_getsockopt()
      can: isotp: read socket options under conf_lock in isotp_getsockopt()
      can: enable memcg accounting for user triggered allocations
      can: isotp: check the CAN_ISOTP_OPTS values before applying them
      can: isotp: add the frame transmission time to the protocol timeouts
      can: isotp: check the CAN FD tx_flags in CAN_ISOTP_LL_OPTS
      can: isotp: reject reserved STmin values in CAN_ISOTP_RECV_FC
      can: isotp: reject CAN_ISOTP_CHK_PAD_DATA without CAN_ISOTP_RX_PADDING
      can: isotp: drop frames without N_PCI
      can: isotp: drop FF frames with invalid length extension
      can: isotp: check the minimum FF_DL
      can: isotp: check the data length of the last CF
      can: isotp: do not send FC.OVFLW in listen mode
      can: isotp: ignore invalid SF and FF frames during a reception
      can: isotp: drop inline keyword, let the compiler decide
      can: isotp: rename rx_lock as it has become state machine lock
      can: isotp: introduce isotp_invalid_canid() to verify proper CAN-IDs
      can: isotp: rename variable for the required content length
      can: isotp: rename checkpad functions returning bool values
      can: isotp: change return type of functions to void
      can: isotp: rename pointer in isotp_rcv() prototype
      can: isotp: introduce CAN_ISOTP_MIN_TX_DL

 include/uapi/linux/can/isotp.h |   3 +-
 net/can/af_can.c               |  12 +-
 net/can/bcm.c                  |  10 +-
 net/can/isotp.c                | 380 ++++++++++++++++++++++++-----------------
 net/can/j1939/main.c           |   2 +-
 net/can/j1939/socket.c         |  12 +-
 net/can/raw.c                  |  78 +++++----
 7 files changed, 291 insertions(+), 206 deletions(-)
---
base-commit: e1055cbfd6eb578417f3ce983cf44462e8465267
change-id: 20261126-getsockopt-memcg-isotp-052433c7adda

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

