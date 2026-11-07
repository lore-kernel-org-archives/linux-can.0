Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794056828;
	b=xWkL7mkHd07WigWUHKkVHAvk4P1L2MiVPs9ZWgrt3seP4JCaG6piIlkzCj9+c2OJ0rcY
	 nfLrK3OtswLIQuuU4GXOWW1cVh5dQ/2L3CLa4uGjU1/EcdPfPS6oj0iB0EDV2V0UVstRM
	 qkMb8sH/J+inLUGgTh4zwEGtuGIHem+kvyklO4SaB4GbwwjZ3VlAQ13o65FduXYT5MxQ3
	 8Oz5nZwBYsCDzXv5UKhq3DSMY6GUzJsFA6Y9uROOTAmBdww+HgTBRfWMhQzdqzbwfhEi/
	 MH0Sl5IXKgxJK9Ah+Kursalxm9r2lAA1v9OVeJsIF28112wu8cL/FTenmF5UqlVenqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056828;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=RxWkNKL+wePZ78+Dr9tHh2s2azPLLqJ4j0ohd5bfCtQ=;
	b=su37cOfX/sW7y3quLWHPerQDfl6z+TUz6c4CThHZcI8oxNnaNuoDdL5uhkykubF/iwfw
	 uMDVR6pK6PL7ElUywqkFYlcDpEY47qJQ+U3NbfFXHfVLzckDptBshuBiPymfw+llqARiG
	 HCf8yXjd4vuDuKXumKMuWY5nvmnJO+WZc0zwQfX+KF/RFoOxw35G6aRylezMQIf+xzBVR
	 PziMkl+LT9+oyCu0QzPWzt6OSqHi8N2F9idHb8DK1/hTZKqcXUVlkeRebm+hIoNl2cWHf
	 6DRO78PBZmhipcGOeNBrFOR4+I9gt5qQNpIBpEbWpSFV3nnDluN89hOoKF0UjDeOmhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TujZfcSv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oHqJCD1k;
	arc=fail smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12989606A334
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12989606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TujZfcSv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=oHqJCD1k
ARC-Seal: i=1; a=rsa-sha256; t=1794056819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C0RJFTUWPP5ceyb+9Zs1GekPIgK1ceRa2CzMnxR79RyKV+HDx3LTK+9RKHl1lt5MLi
    ortcra+y5DLLrkX7dKAOdG72he39yZ13VtqSouNKY38piCyGZZH0x2pVNsjBMboB3fBl
    ZWyXanHIXF0rEtyRo8grCRdG1QCVB6q+Ke8tfUhsmT+bg6IE89p6LtTVO6D0G2pwmntg
    3EYAxNP9otiS9SlN/5468IOvT9lOpzyy9cfq1JCjKivYcLtbf5sH6njo3/18/Yq+pOz1
    6mBEavvMovssmssO99TPHuZw7oCKAu/BiPadEFLU+D5LwpIlKOHP8/4VQbzGqE0kV+Ed
    480g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=RxWkNKL+wePZ78+Dr9tHh2s2azPLLqJ4j0ohd5bfCtQ=;
    b=e8wHjGr7wQcXZyOVjyPJATVbvGZ7go2jPuvHK+DRs3aud29SV4IuHtA5DIEpmkcB+9
    QuhVOAPIp5QgF5EGMAEDer/CBqYxO3k3AuAKoIcElbTJqIW3LgOUsub+XStbtm1mSfaz
    KkSwBSpJ6UM7FWTXV5Ov7ng4BEP4HjZknatapKXpOOd/QEgbxx/h8yynaE3w6moSuheg
    sUuO1L+RZL5Gmp9NCnXHe0AxJ7tSvD+raKAOQA8PUvXbyXLqq8gOkLVVXH2J7nhazHUu
    tYqF++RepVKlfvHBpYNZVLJiKr5ZgujPQacNBZUlXR3WI7Axby/Bw/bYpfP/IVBiWdWv
    RMpw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=RxWkNKL+wePZ78+Dr9tHh2s2azPLLqJ4j0ohd5bfCtQ=;
    b=TujZfcSvgPIewYidFfJA2AabkTKEzJZbSfAqn6+6LGosbZAag9y+SEXHDH2N0MXhCk
    W/zYu0zGPdHKlmCyTWLi9YbuOr227KvroXkx9c/0aLabamNp7ZVStvPmHKaNGJH1ZvcM
    g9qy67UwYqkQ0yzvcMkH/1dRkAM1AxLrqATHj+gBw/ODLdbWO9tFyCl52PQk9crnguVh
    KnImcjk27jSSi/3W6EoQge6+3qGtJ+5QiRcGZ0OylGHzHJshGlvTmcSYDs8LUQpREOMS
    wI5Mprs5lgyPvqcVImCUPzZQ/MEIXAgLX3k85+gDZVNn0yRk2/3b2IalAVXkjwmogc7g
    pMjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=RxWkNKL+wePZ78+Dr9tHh2s2azPLLqJ4j0ohd5bfCtQ=;
    b=oHqJCD1kr3M+vr0rtQ19t6vv7OaceDOYZqw84imLQOBKhvhfWbqUeCLwLwLASYiVRl
    y0josDmqpn0o1B339VDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7D6wlPV
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:06:58 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/3] can: bcm: avoid RTNL stalls and enable memcg
 accounting
Date: Sat, 07 Nov 2026 14:06:43 +0100
Message-Id: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB0wETR4FXERx1FHTZSkLQXx7
 sZ2+Rb/nxA5CEdoshMCfyTK7hNUngHN1k+MMiSDLnSlVFEjWY89uW2nFR07mlAPxnJdVsqUBlJ
 3BB7l+3u23d/x3S9Mr2cE13UDdODafXUAAAA=
X-Change-ID: 20261107-can-bcmlock-memcg-2d8ae7361838
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, Sashiko <sashiko-bot@kernel.org>, 
 Zihan Xi <zihanx@nebusec.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794056818; l=1674;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=K3KCcEIJ/0sdCtEFJCygDNEXa4KrQDb/TEXSp32qUQo=;
 b=39d9vCBz87qnqFgEIsSTZJXopFNli4ai7A5gmzEga3jUBOARqW+oaOPA3m2ViexVynH4y3IJn
 x1EqjVyMhMZAHoBxCeBSMY/vVObe5iCtpM3iXLCAjLABmojEQp01To5
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
Oliver Hartkopp (3):
      can: bcm: copy the CAN frames outside of lock_sock()
      can: bcm: do not remove the procfs entry in bcm_notify()
      can: enable memcg accounting for user triggered allocations

 net/can/af_can.c       | 12 ++++----
 net/can/bcm.c          | 80 ++++++++++++++++++++++++++++++++++++++++----------
 net/can/isotp.c        |  2 +-
 net/can/j1939/main.c   |  2 +-
 net/can/j1939/socket.c | 11 +++++--
 net/can/raw.c          | 13 +++++---
 6 files changed, 90 insertions(+), 30 deletions(-)
---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261107-can-bcmlock-memcg-2d8ae7361838

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

