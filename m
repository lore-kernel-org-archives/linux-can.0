Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539641;
	b=pnqkrFMgms1sPpnTgfXH8PrY+93hrQ+cL602VYTbmhOd9GcVzorwJCYcaV8/RwQAl42I
	 XSJuC1mHGuWi4pNrRaMfn4bzJceRR+uY2jNHUNi+ikVQAvLsUzag7oseNZUMtZ66tg1av
	 7zWlYsawZe8Hw4xfA4K8qGviwClSqL8LsjAWIdVw3jAJz9MFGXNGfOuHUzl8ehmJYBUBR
	 2c8jvhsF04GAPxRAY1ZhELlspcYPpvJWwagXruuKGzqVaq2tDaCloVGQhC+NGdR/7nAco
	 9BtaGLSRKaiGDM+tF+UKQqnY4v5ILGyCe+94oq3aTBWwmoPUs6aml7n+pVHHdoLpCqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539641;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dh/v5Vpdh5SVVpBCIpC5pVA+V35gFFXAr2nxFIOy5Hs=;
	b=rdUl+/X2O++QAyYdIpZiuelLCyPG3wzM1LBx65T9KemJycC3Unve35gl+g+NbLBaqrd3
	 NMo7qUuLajolvEkhuLCXq35WOx8MNG3L3Q621GtuANvXUBD2TgC3P5z7JBgbfIKejq7Hc
	 T8tOLcAFtCBysh9I5BPySw3+HkeiqMx0+puzgF4uAiec9N7UoXSLizU7I4l9N8DUkX4VI
	 55ZzjSTqppCJfFfj/Of5teLK4sN+0LJyNEcgCgIEjCydX/XjmG6BbFxMWRJmTBow5bYNC
	 IyrOtc6gqutGj3r80HuzdlGfpwaGO6da8PCMY5cefs3go/ZVF+59lFkMUqqAf5mpbUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GgU63VJt;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A317D606A33B;
	Fri, 13 Nov 2026 03:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A317D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GgU63VJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=dh/v5Vpdh5SVVpBCIpC5pVA+V35gFFXAr2nxFIOy5Hs=;
	b=GgU63VJttngo7SGYSSQh9OgR0B9xhFNXRFJ9PA4TEaAHvUpBMvsIeJ0Z0+NYzh
	nj+UyVqzzDGeU+7JtkuOx8zR/4qZYEKnLCXpkXA7QROptquW7zvGlatsHufFTRt6
	LfneBrNLobQBIm41jZkX1b9wp2JfZ78knzFtc9eKx0A+Y=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: netdev-bot+sashiko@kernel.org
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v7 3/4] can: j1939: drop the message when the reassembled skb is gone
Date: Fri, 13 Nov 2026 11:11:13 +0800
Message-ID: <179453947398.30993.12910253526180673543@163.com>
In-Reply-To: <179452018024.488853.2874336452045412196@kernel.org>
References: <179410166346.60581.12668181404057434786@163.com> <179452018024.488853.2874336452045412196@kernel.org>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn1BcgPZqjG20Hg--.7020S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4rGr15AF15JF48Gw1fXrb_yoWxZFX_tr
	ykAws7Jw1vqFyIkFW7urn8Xrs7AFW7Gr4UAFsYqrWak34xAFWDur1vqryYv3s7WF1YgFnx
	u3sIqFyjkwsYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUDUUUUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-xyPBWr2gFyjqwAA3h

Hi,

Both accepted.

Dropping the message silently is the weak part. session->err stays 0, so
j1939_session_destroy() queues nothing, and the only trace is a netdev_dbg()
that is off by default. For an RTS/CTS receive session this runs when the
receiver's own EOMA comes back, after the originator has already been told
the message was delivered, so the two sides end up disagreeing with nothing
in the log. The next version uses WARN_ON_ONCE(!se_skb) and sets
session->err = -EBADMSG before dropping.

The comment in j1939_xtp_rx_dpo_one() does go stale here, but it is 2/4's
comment and gets rewritten there, in the same respin that changes the abort
code.

Thanks,
Chaosheng

