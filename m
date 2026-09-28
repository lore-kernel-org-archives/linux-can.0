Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA124B7A59;
	Mon, 28 Sep 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596514; cv=pass; b=BJMufuSI3fPD4RZUILRn1bDp5AED9tlhJ2OmTgc+OGTLR69QtsxgMfALG/7gHhzELMste+GpKiLd1iiaTxNi6uxD4wmHiEHYc1lmqYhqH9Sg7h2bZ2G6/LJzKsVzK4TUdecb2FFDZdKckzFOF4xgnM0eE/oEddPdK37LZUj5WII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596514; c=relaxed/simple;
	bh=SVZcJ55DzVNMNY5XMdT7WD2AhnBGmKabJpvR8EQwb0Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p/EZK0Y15BtNAxdUfJ0h7Gs3LMJVktrQuMJI2XmyE7MXmGXDrJe4L3tyvg4+ymzlg+h2TUBfXNv83sgjVn+B59MTYcq/5O+Wo6SYpro9awmb5jFQKGuDJR6z7bizuz2weR2Na4eO8iw0HveQmywqFQ5ub5fHt50DVE0r1GLYLEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clnt.de; spf=none smtp.mailfrom=clnt.de; dkim=pass (2048-bit key) header.d=clnt.de header.i=@clnt.de header.b=kYVJ9qEB; dkim=permerror (0-bit key) header.d=clnt.de header.i=@clnt.de header.b=ePnFHYK2; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clnt.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clnt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clnt.de header.i=@clnt.de header.b="kYVJ9qEB";
	dkim=permerror (0-bit key) header.d=clnt.de header.i=@clnt.de header.b="ePnFHYK2"
ARC-Seal: i=1; a=rsa-sha256; t=1790596502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UFC4aq5r2AZwRb5NG+M1XKiJCbl0GeB1QHZi/Fg5zRIHPzEgMoksM2eVsamE8UTI5I
    73MYzAfKw/A+LqD18sPpgTtZpyPXLZbc0KLgZ5S6FBynNY3LwKRhhMdzBp5wUYSqjac4
    ksTk2OT8ABU12fF2tj/H0+I19LuNM1OKdaugqod6MPqvvXArHmIr5eZ3T/JQhes7kyAG
    j5bdEKcG3Tcu5AgNtRIaLvBmMkt083VqJ199navq/P85xYPykWdPZ13oNXgmuuDJa7Ax
    IU2B1Cq3pic/nvETVubbuZsZSJNV/li+VwuvWTwen8isOU+XOwR+1SMKTdYgnp/bgSx/
    LAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790596502;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IRQ8P8nmGPrpH/cBBhS5FaYGqbIqFX1UWUBcQOhpGVA=;
    b=T2Iu1flPA9d2WgadXiLTiJi9rCPvOv3ZTQ6HM+203TL8U5W9AZOIYw0NgRIgeLmcrv
    kz8ph/Z5mLQSvhrcaObkfiVRiaAHvaMJbZoWqJor0AQG1Zjl/AzRgV8YJuWRFah/wys8
    QqEfOUsqw/Nj/1KRp/9pgFMiT2qYz/qZtiDkJfweh/uSqEhP4WXu653yH1llkstVpucq
    4ta3yoauyw97xr5K0u5qlCIa4JAeBGqhCCxCtms/IwZRGj2jb/JDpib6qrwNyil14syT
    ofCm5+Ul+TvRcsoMB4j3fQY4Jvh040PsFanxv/Sbv+L63EdcJZGtMP+Skjg8ZaZGD58v
    qi+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790596502;
    s=strato-dkim-0002; d=clnt.de;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IRQ8P8nmGPrpH/cBBhS5FaYGqbIqFX1UWUBcQOhpGVA=;
    b=kYVJ9qEB/J9nAjf7VMhmHbjfF52vWP4WjmB5L67RlYnEJ6hsmMl+qBQYHioqO8GUx5
    JxdOwQbfyN3lxDXCkxuMkmFCkDHVc2vc8l2W6icpZnUsHN7J0kq+S9c+mPZP8bLrsGOx
    XLX6w696GreLgjRcFZ4KWTKGG+Gdu5RXyPduOc2DcIs5xwblYcA0qLdgwRoAtc42a+NT
    Ib/OlJpwyQRI9LsXk+37SnNzCrrcoaCuaAZ29nTJC6nomjeiE2NYKD7d0rPp+NDnuO1e
    J/IWWRpv0YGrJuLeiov+rKAIAU65fllTRDoTVc0r9rlMIBa7uAApr2ZTwqSU7U68gZe8
    8+Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790596502;
    s=strato-dkim-0003; d=clnt.de;
    h=Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IRQ8P8nmGPrpH/cBBhS5FaYGqbIqFX1UWUBcQOhpGVA=;
    b=ePnFHYK2Q83NhPhlY9mfUSXANra+h1KRzAfQvPj9F9wRkcowEq4Mrrx9KelM5OS+/4
    fD7xuNfcNPXCGB6n4fDQ==
X-RZG-AUTH: ":JmMBZ0eIePPD0O4MAtHoOQRBn1SEQ1z2Q1DWy2WVkt1sV8N3AuWK5lfWPRbu91LSBytYvkGZVYo37PbZpRi9KWvmPfg="
Received: from ehlo.thunderbird.net
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id f03c2e28SBt2Y1V
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 13:55:02 +0200 (CEST)
Date: Mon, 28 Sep 2026 13:55:01 +0200
From: =?ISO-8859-1?Q?J=F6rg_Willmann?= <joe@clnt.de>
To: linux-can@vger.kernel.org
CC: socketcan@hartkopp.net, mkl@pengutronix.de, netdev@vger.kernel.org
Subject: =?US-ASCII?Q?=5BBUG=5D_can=3A_RX_frames_silently_dropped_in_ra?=
 =?US-ASCII?Q?w=5Frcv=28=29_with_RPS_enabled_since_d4fb6514ff8e?=
User-Agent: K-9 Mail for Android
In-Reply-To: <VI1P18901MB0640EC60F0E40E18EED92A0AAA8D2@VI1P18901MB0640.EURP189.PROD.OUTLOOK.COM>
References: <VI1P18901MB0640EC60F0E40E18EED92A0AAA8D2@VI1P18901MB0640.EURP189.PROD.OUTLOOK.COM>
Message-ID: <2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi Oliver, hi Marc,

since commit d4fb6514ff8e ("can: use skb hash instead of private
 variable in headroom") we are losing received CAN frames on raw sockets
 when RPS is enabled on the CAN interface=2E The problem also shows up in
 the stable backports (seen on [6=2E12=2E109])=2E

 Setup:
 - Kernel: 6=2E12=2E109
 - Platform: OpenWrt 25=2E12=2E5, 4 CPU cores
 - CAN controller / driver: mcp251xfd
 - OpenWrt enables packet steering (RPS) by default on multi-core
 systems, so rps_cpus is non-zero on can0

 Symptom:
 The application on a CAN_RAW socket misses frames=2E /proc/net/can/stats
 counts more RX frames than the application receives=2E With

 echo 0 > /sys/class/net/can0/queues/rx-0/rps_cpus

 the losses disappear completely=2E [Optional: rate/amount of loss, number
 of filters on the socket, whether join_filters is used=2E]

 Analysis (as far as I understand it):
 1=2E RX skbs from the driver start with skb->hash =3D=3D 0=2E
 2=2E With RPS enabled, get_rps_cpu() calls skb_get_hash() in the
 netif_rx() path before can_rcv() is reached=2E The flow dissector
 finds no L3/L4 headers in CAN skbs, so every CAN frame gets the
 same non-zero hash with sw_hash =3D 1=2E
 3=2E can_set_skb_uid() only assigns a new counter value while
 skb->hash is 0, so the RPS hash is kept and the frame gets no
 unique identifier=2E
 4=2E raw_rcv() treats a frame as a duplicate when both the skb pointer
 and skb->hash match the per-CPU uniq entry=2E Since the slab
 allocator often returns the same address for the next skb, a new
 frame with the same (constant) hash is dropped as a duplicate=2E

 Before d4fb6514ff8e this could not happen because the unique id was
 kept in can_skb_priv::skbcnt, independent of skb->hash=2E

 Thanks,
 Joerg 
