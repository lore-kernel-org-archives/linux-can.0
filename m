Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE707457E57;
	Sat, 10 Oct 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640983; cv=none; b=p6Dz6svq5n9uw9re0gIjue8nQDuZBHxPIqfoURAHu7Eh7Q5FBH3ImT3tFlAj5Q7hyRnAp9RFffWTEhPpPqszrAKs3jly94UkwdH5a3pqbnN7VNZd7nQZP7auCFOI42ACd4dCD8a7BkcfKBIP9OOzki/pPRMmBVBG9nwZ//9oyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640983; c=relaxed/simple;
	bh=MzK8G1n/LagTbJGqzfuHEHNUoXS8KhkyxRJeeKDO/5k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rC13cILHT7n1M0oRFuidbKZCsosY4U0b4QzqdgYvPSVc4lo1COz0DAKyg95Zgs1cumnxWxiVPZPbL2aIfgDNitIQbypW3Jn+ekOzg1vEI4PU/UBzeesFydqpa4F4AEP2AHGfVcyUzP6n4RKQ3r/3zU7K0aWOsI1WFqiOLeXVZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQoqYsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQoqYsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B21F00898;
	Sat, 10 Oct 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640982;
	bh=wciHxz/0q5Iwz5BstwMuv+FKp/QJTGplxqXfiVrBYfs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BzQoqYspuT7SSN2cUmg43dXo/2txqjdjhVZaV7wrDTB0YtjIvowKIgSUdx+61KKEi
	 pqtKfEaTWHwXkvrNSgIWzLWtl/Y4S5aC3QKzKCHKqZLQioorwCzHj+fJ7LVE7JcAkB
	 uGvkl8/axYf27Sn21kmtCF3TS7rzo49r1Mxg/RA80z+DUGCYc+ufFjNW+UosIXxgTG
	 WwXZNZPyByq/1lZeS3f4NanRh9gtDwe8j3e+mEwjwn68EkQeel1aNMhSs/4ijzA4BP
	 NHdCbZWUAnw0PAc7VwWHIae7+ijyAnfNXtsPbNHw/KSZ6QB9VGFYQSu+JxhJ+1FVze
	 tpmsZ3CHWdDXw==
Subject: Re: [PATCH net-next 24/37] can: cc770: don't discard the IRQ lookup
 error in probe
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:01 +0000
Message-ID: <179164098186.434549.3556176649180258959@kernel.org>
In-Reply-To: <20261009134323.64064-25-mkl@pengutronix.de>
References: <20261009134323.64064-25-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes a user-visible failure ("a probe
  that has to wait for its interrupt controller is never retried and the…

--

can: cc770: don't discard the IRQ lookup error in probe

This patch changes cc770_platform_probe() so that it checks the memory
resource first. It then returns the platform_get_irq() error unchanged
instead of turning every failure into -ENODEV, so -EPROBE_DEFER now
reaches the driver core.

Link: https://patch.msgid.link/20261009105556.301821-1-quchaosheng000406@163.com

> That discards -EPROBE_DEFER, so a probe that has to wait for its
> interrupt controller is never retried and the device stays unbound.

[Severity: Low]
Does any real configuration hit this failure?

The code change looks correct, and so do the technical claims in the
message:

  - platform_get_irq() passes -EPROBE_DEFER through.
  - call_driver_probe() handles -ENODEV and -ENXIO the same way.

The only in-tree users of cc770_platform are powerpc device trees.

arch/powerpc/boot/dts/tqm8548.dts and tqm8548-bigflash.dts:

    compatible = "bosch,cc770";
    interrupt-parent = <&mpic>;

arch/powerpc/boot/dts/tqm8xx.dts:

    compatible = "intc,82527";
    interrupt-parent = <&PIC>;

The MPIC and the 8xx PIC are both set up during init_IRQ, so these
boards should not see -EPROBE_DEFER. No in-tree board file registers
the device through platform data.

The message describes a failure that users would see, but it has no
Fixes: tag. Could it say whether this was seen on real hardware, or
whether it is a robustness and consistency cleanup? Without that, stable
backporters cannot tell which it is.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
