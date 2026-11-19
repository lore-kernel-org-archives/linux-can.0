Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082071;
	b=IaQLyE5iS3R/fBg4JtkhE5zyBSYOilNN5c0qhc1Mz148AtpmiWuWcCG8a9VKSu17CotL
	 X+3wF63KzHwgwThzjDGFupkS+ITCiGPko4MtiC3c41QJyQa0IxD9UIiaTvF2VM5rIr9zN
	 RHuQmvZwntm+7cLELcuNTH9yQCZowIwbrtXqzCrNE0w9iNcEUgD4vLjcdQFwqdY2NSlk0
	 0fSz/T8zfwlniBHRYybDwbV7ljfemk+t1tTsviVtda89VvHIWTzF+BYkqnNRFEyU7BrXK
	 8Uy29JgEXCn9ODZNtp9LVQK9zo4vMmnHZRY6JGaa4T6+csR1lsyTuFAFy5w9d8w/mRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082071;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YMJZwCjdtyDiOoX/BpN2k21LxmiAFx2iq0oQkc7VWDw=;
	b=BZzjgHKBvVzJi9SUIyEZaNXLPpmRQDSXa6SY9Z2T+YIBlau6FZKRXTSEdJaxAd5SaN70
	 fkQBQYJ93ceoNVd7eFE/AIBwcT49vjNnmfHrWI/F0+PFRAOV79xkeYgILh7m3A0phISdS
	 FZ1fI6wHWzBxfCnSJFoWW/PRs8khVrPIes6+NRpSD1jnlCn5Oo8C/RitJKYolel06rZxm
	 8lu5mEKOPpVhMFT4iR/Y/lztnboTNuKcF3rii02s0mQcA/To9EoCGms2zh7ZL4x4Hdhs6
	 A4XBc4ROk0df6OzGpFP4vZXBW30Sw5ASNcbJYHVZL0vUgsAOYYthbfY1BXKpYPdEHXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDummkaC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB1606A33C;
	Thu, 19 Nov 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDummkaC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887CD1F000CA;
	Thu, 19 Nov 2026 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082070;
	bh=YMJZwCjdtyDiOoX/BpN2k21LxmiAFx2iq0oQkc7VWDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cDummkaCMifkduCY00dpb0/xZcD+5+/PBAzKXbPFBv1kDmD/q5QnvRh/byzWfQ3Lu
	 wywIIx0Bm1HO1iUPMA9jziVlDVH/yEXUV8xFPxTB7YMxlpE9T+JeNgzsOmnBBjvSic
	 5Xo0uKW5PkRTOntRmjN5g4PrcYA0e/haLquc7KITDSY/P9lcGNfnR8oMJYOhyKh8wR
	 Kx7QfKqZAme11Gnl3UIwGiQOJX67Vd1Ljt/FZ765aSRDuPcM6wICc8mzX6VzuywUBi
	 uX/Jb44faZwrr4kqftI2zAyR2PajosjTxnwu5J5NiI42el/c9NKrbqg5qFazdDsPHl
	 Ne5X+Gy2WDB3g==
Subject: Re: [PATCH net-next 07/12] can: at91_can: don't discard the IRQ
 lookup error in probe
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 dev.kurt@vandijck-laurijssen.be
Date: Thu, 19 Nov 2026 09:54:30 +0000
Message-ID: <179508207014.3136.12887292371349872739@kernel.org>
In-Reply-To: <20261118092955.1283165-8-mkl@pengutronix.de>
References: <20261118092955.1283165-8-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message of "can: at91_can: don't discard the IRQ
  lookup error in probe" gives a real deferred-probe failure as the…

--

can: at91_can: don't discard the IRQ lookup error in probe

This commit splits the memory resource and IRQ lookups in
at91_can_probe(). A missing memory resource still returns -ENODEV, and the
error from platform_get_irq() is now passed through unchanged instead of
being collapsed into -ENODEV.

Link: https://patch.msgid.link/303815792800553c34842147941cab083823c212.1792118040.git.chaosheng.qu.linux@gmail.com

> The driver matches through an of_match_table, so of_irq_get() returns
> -EPROBE_DEFER while the interrupt controller has not been probed. The
> probe overwrites it and the driver core stops retrying, leaving the
> device unbound even though the interrupt controller appears later.

[Severity: Low]
Can this deferral scenario happen with any in-tree user of this driver?

Every in-tree CAN node for this driver inherits interrupt-parent = <&aic>
from the root of at91sam9263.dtsi, at91sam9x5.dtsi, sama5d3.dtsi and
sam9x60.dtsi.

The controllers behind <&aic> all register through IRQCHIP_DECLARE:

drivers/irqchip/irq-atmel-aic.c:
    IRQCHIP_DECLARE(at91rm9200_aic, "atmel,at91rm9200-aic", aic_of_init);

drivers/irqchip/irq-atmel-aic5.c:
    IRQCHIP_DECLARE(sama5d3_aic5, "atmel,sama5d3-aic", sama5d3_aic5_of_init);
    ...
    IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);

That means of_irq_init() sets them up from init_IRQ(), well before any
platform driver probes. So irq_find_host() in of_irq_get() should always
find the domain, and the -EPROBE_DEFER path is not reachable for this
device. The legacy non-DT path through platform_get_device_id() never
calls of_irq_get() at all.

The change itself looks fine as a consistency and robustness cleanup.
The sibling commit "can: cc770: don't discard the IRQ lookup error in
probe" has this caveat:

    This is a robustness and consistency cleanup, this issue has not been
    seen on real hardware

The commit "can: janz-ican3: don't discard the IRQ lookup error in probe"
also says it does not fix a deferred probe.

Could this message carry a similar note? As written, it reads like a fix
for an observed unbound device, and that could affect stable or AUTOSEL
backport decisions.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-2-mkl%40pengutronix.de
