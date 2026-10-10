Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1E1E5B9A
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791593329; cv=none; b=NN47mHMW5Wpl9qLQnXRziDpPjsIQmK+ExCvSKuCuDji0XQLTaMahlhrnI87xunN/jsuDt0UcWhJD+e4bUenhOzOfzg1853egKbbk7rvdOg6uPP5mOTcdJ9+Lu3C35GNybMjJzKY4B4Tq+jnTB7TTF+XbYXk9AAIof90s+p7ZYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791593329; c=relaxed/simple;
	bh=4DSU0BNZd4P6kTBpyorAuD5gTPSs1z6FHVjitZW++uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcxvsLF+412qFB6+q8XzglYlp476LSbJDpHEstvW4unxqYn2rRms8tPfVSyE9vYMQxa5Uwov6sSaGU6oe4PHlCW/trHkizIg3k0+Y8OABlE4KbLuocxqEnEd14GgqAwFess6FN97rCUUUGClRz+OS7Afh+Lo1/kRHe2UfHS6Vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g7zo++Pe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g7zo++Pe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5f
	HnUPHdyNjUT74C0TmMG8I7BXh52nm+ZTVvRX8nsGg=; b=g7zo++PeoNd6yivTzd
	NlStRnFspbIFGiGsH/xKmPBbvueCJ6F2Zubd7866emV2ZNbvbITpZObJvT6cGL7C
	Ik4+j29c+QJQzORrA7nYoZpddPIPgWE3Gjnuy6Y7BcwB+Ma0OVYxnRpTmGd5cfLy
	L4PmIlPrPXHMgk4tPJNwurwZM=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX_4Vci8lqy+a2DQ--.47694S2;
	Sat, 10 Oct 2026 08:48:29 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: don't discard the IRQ lookup error in probe
Date: Sat, 10 Oct 2026 08:48:28 +0800
Message-ID: <20261010004828.35994-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009-rigorous-carrot-chicken-ab31e0-mkl@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_4Vci8lqy+a2DQ--.47694S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1xtFW5Aw4ftry7Zr18Zrb_yoW8AF1Dpw
	4ak34jyr4kXr4vy3s7Ca1xJa47ZFsxtrW3J3Wrt3yjy3y5XF4xtrWfta42vrnrGrs3Gw1Y
	kayqqrn3GF98ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR2YLQUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x0HfGrJi12qNwAA3x

Hello Marc,

Sorry for the noise, and thank you for asking rather than just filtering
the thread. It was a bug in the script I use to send patches, not a
decision to re-post.

The script fills in the recipients and then shells out to git send-email
once per group. It kept no record of what it had already sent, so every
run sent the whole queue again. It ran three times that morning, a couple
of minutes apart, and each run sent all four groups. That is the three
copies you saw, and it is also why the tpd12s015 series went out four
times and drew a complaint from Laurent.

What changed since then:

  - the script hashes each group and records the hash after a successful
    send. A second send of the same content is refused unless it is
    explicitly forced. I tested that the refusal actually fires.

  - the version markers are back. The copies you received had no vN in
    the subject, so a re-post was indistinguishable from a revision.

I see the cc770 patches are in your net-next 37 series now, both the IRQ
one (24/37) and the clock divider one (25/37), so there is nothing to
re-send from my side. The IRQ patch had picked up a sashiko finding
before that; the version you took already returns the platform_get_irq()
error unchanged with "if (irq < 0) return irq;", which is what
c_can_platform.c, flexcan-core.c and sja1000_platform.c do, and the
commit message describes -ENXIO rather than -ENODEV. So that one is
settled.

The remaining one from that batch is the bosch,cc770 binding conversion
(the two-patch series), which I do not see in 37. If it is simply
waiting on the next devicetree pull, ignore me. If you would rather have
it as one series together with something else, tell me and I will shape
it that way.

Sorry again for the extra copies.

--
Chaosheng Qu

