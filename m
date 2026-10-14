Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0254938C
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987706; cv=pass; b=rQxs3gbTwKpCht6VDn61F7a4ni9zcRIqiXrEXpRkDXrIE8w7R1PX4wnMnLSyAANBs26LJ5Cf3xSwKtoMTRA+sc68JkzwlWO0D9sM1WQ8kKItd2vRULtCLhRYM9+CntUXBWUQVx8jpp3WL9sX5uQ5XnH9eTxEnAsFJSGTWzVlle0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987706; c=relaxed/simple;
	bh=VO8xYt00UGCVPTRL78A1Nu+i2FDeia+5rU98IywHJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gkfS70Q1UmLxjv4bMVSLWYOM9yJhoQdJfELLJf7Eh2hgArpVmSd9qf+upLC1sRfDI57wiAKM3si0vy3v86vjGry7UTxZPzrRoBrjk4uy8ExOV/+ru3+mN4B6QAvzNhl3IVrD9iM00fK03eKWh7+s4yT0D2Ho9cOzVPnVjaajQJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mF9LOaON; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JTf9aWgB; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mF9LOaON";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JTf9aWgB"
ARC-Seal: i=1; a=rsa-sha256; t=1791987696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FZ7rhcX61NS00aAW/k2wudngsI2Xmkvu0Ep0r0CuJVqmh/BCNomNZ0a/nCEG6MoUPr
    CDS7JzAeC4zdistgxDRM1qk2EoipIOQJ9wkAdCiOXYnFVF3u9XUfj0tzC5TSVExFsq2R
    wlYCkBXD00TBlBXgreQNJrqB7Mr5A1XIxeKTcQRho4h0ZKMZmZgql5tdABiocl1yRSij
    RRC0+XDIRgYAlO6cOEeD6yjEf9m1ZHSuFpfOmj1fPau3kWHljO4iFlezlLoIq/Nd5UmA
    k7Utw7cNmev4zZUJmGdyTVrOoihF7M4M941Q0ity7ppT4jcdAxq4g5eCFp+nNFaUQlxG
    bDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=GfS9JimlfGM9B8dWZeVEE2b02kVruZaUW9grzUlTcgk=;
    b=P8KqKxSCFZTC9fUofJcLoNLdw04nIl/k41P7eXJCS2mBdWqZzAsAXJfAtVpdxwCxXi
    87tTw/U61OXYXiz0usDMuDBrhLFyA5n5EWRSgBY8n8MidHJ0V/dv0FG5RCuVVqfjHziF
    g+Wuvm2KCykJQJVeb5ym3hr8Y8cRPB9Kzcv4DnydgesLf7Tua80romEJmPGVD3wmMuon
    GQ709CefyNHOQId0vYU99E9VVOvvofvf4Toev5Qk/asIkhIf3alXbZQY+wU6EGjZH/th
    ZiQmvdzVRh0ghxgYQbzVfGGtVWoe4PiXh6Cz95xLV+9OUmpS2CzTvBpZIxpheJCsxSOI
    COJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=GfS9JimlfGM9B8dWZeVEE2b02kVruZaUW9grzUlTcgk=;
    b=mF9LOaONe6G7xFKWMSJimK8747IhVlmIah0mjHu2g7BmVyOLNWAsmtlQGHKapCHlQP
    4F8Jaxtcc2rFGSgD0ds9WRDsveV+GUeko/SLG45Psjyr5ykWH4HM6cMZaRh/prgUppEs
    8cfwBpzEMl0zM5DTKic0YMp2A7J1hh+CE7lnAmzgvjrW3rMSSFNxIPBJZ56kCGyigRV1
    2/gKqUmlNc/Yfz3vIo1gPRkfrkexOERelXf2zwiq9OUdds6X30KPZ+vF1nblbR3ZTU7v
    RMl7M9abHsVdY8p5jWzZtvlWrXAkZT+XKrzFL0n+0xqlPtrhQ3TBn0qBbfp64LjWeZK9
    6rQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791987696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=GfS9JimlfGM9B8dWZeVEE2b02kVruZaUW9grzUlTcgk=;
    b=JTf9aWgBV0fvz0+xTJK+r3b+W5mExlU85IAt8LEOkSsnK/1InYMHxyfpoojXzKPXxP
    rLWCOesHSGBNY92J9BBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EELaDZW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:21:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v2 0/3] can: take rtnl_lock() before leaving the notifier list
Date: Wed, 14 Oct 2026 16:21:11 +0200
Message-ID: <20261014142114.280279-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Norbert Szetei reported a use-after-free in isotp: isotp_release()
removes the socket from the netdev notifier list before it takes
rtnl_lock(). A socket that leaves the list in this window is skipped by
the notifier and has to remove its CAN filters itself. If the bound
device is moved to another network namespace in this window,
can_rx_unregister() silently skips the removal due to the namespace
mismatch and the remaining receivers point to the freed socket.

bcm has the same window and is affected in the same way. raw has the
window too, but removes its filters with dev_net(ro->dev) under RTNL
and is therefore not affected.

This series takes rtnl_lock() before the socket leaves the notifier
list in all three protocols. As the notifier chain is always invoked
under RTNL, the busy-wait loops on the *_busy_notifier variables are
dead code and are replaced with WARN_ON_ONCE().

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/

Changes in v2:
- bcm: remove the procfs entry and the tx_ops before taking RTNL so
  that remove_proc_entry() can not stall RTNL waiting for readers of
  the world-readable procfs entry
- bcm, raw: reword the commit messages so that they do not refer to
  patches outside of this series
- send all three patches as one series for can-next

Oliver Hartkopp (3):
  can: isotp: fix filter removal race between release and netns change
  can: bcm: fix filter removal race between release and netns change
  can: raw: take rtnl_lock() before leaving the notifier list

 net/can/bcm.c   | 35 +++++++++++++++++++++++++----------
 net/can/isotp.c | 17 +++++++++--------
 net/can/raw.c   | 13 +++++++------
 3 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.53.0

