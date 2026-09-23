Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9537A840;
	Wed, 23 Sep 2026 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130669; cv=none; b=WV1fcTC3zXI4pW9gVKLqPHNpQ8n+nAW2wj6fojvwOGWCJ9x+AW1h4yJj7ZyoNILgq5HtECP/ieVa3ZC6GWqm71fCP5rZv7ZApOqcx82APOwXCVrH+59Decw6kd5nhVwSQ7+LPy9Q1rdPoZy05+yO02iTQYZccmCfNxqI0qKC9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130669; c=relaxed/simple;
	bh=r1PyjHplFWLo0qH2k0g8IQNAGk+vBXKJq4wxfsUBQA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOvHc9MrXMYWaQ3g/ETtbBUwFw0Egv92HR1MJ0xYpg/5H+sbagTurgoaw3gQ/JftAJkEdmtf+2LU/TwGguhat3su/FPnCkzrjQIavaKKF1Znt1fdb77cTjo9Q+lWefJYzdccIhO2GLvIBQ26x7La3l/242Shw3MPnIA6tUb3Cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SOtLGYwe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SOtLGYwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0N
	sqepxNeBVmgMj8c92zRAqIkxsPWhSpvLpOBd8wNAY=; b=SOtLGYweNJnbLyWbUZ
	uu1TwYgjlnDoPVTgD34a/NLWYxtfyNbtMPC7mx7qIgvaQJtmeKCmzYqVB93NE3zW
	/F5hEIOSg+9J7WQWXwZCqiGVJViFB+Tuy6M4SLMJIruPCpbeohSoT1sqd4DO9gVl
	0ZkvEpAyKrjDpSL0LR8SK8+f0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDH07rNObNqApTsAA--.33096S2;
	Wed, 23 Sep 2026 10:30:38 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH] dt-bindings: net: can: bosch,cc770: Convert to DT schema
Date: Wed, 23 Sep 2026 10:30:27 +0800
Message-ID: <20260923023027.352131-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030215.437602-1-quchaosheng000406@163.com>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH07rNObNqApTsAA--.33096S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUuw15uFykJrWkWr13XFb_yoW8ZryxpF
	ZxKrWrKryvvayY9wn7W3W8ArZxZF9Igr4j9FyUK34qvas8uw18XrykK34UWF47CrZrCa15
	XFn0gwnrK3Z8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUJOzcUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA4JfmqzOc5bOAAA30

Marc, Vincent,

These four cc770 patches are still sitting unread. Three went out on 09-14 and
the fourth on 09-17. Sending one summary rather than four pings.

  1. dt-bindings: net: can: bosch,cc770: Convert to DT schema
     <20260914030215.437602-1-quchaosheng000406@163.com>
  2. net: can: cc770: update the binding file reference in the driver comment
     <20260914030215.437602-2-quchaosheng000406@163.com>
  3. net: can: cc770: propagate the error from platform_get_irq()
     <20260914055611.495105-1-quchaosheng000406@163.com>
  4. can: cc770: fix the clock divider check on the platform bus
     <20260917114311.534863-1-quchaosheng000406@163.com>

1 is the conversion; the schema is in net/can and references
can-controller.yaml. 2 is the one-line path in the driver's header comment,
and it only makes sense once 1 is in.

3 and 4 came out of sashiko's review of 1, which flagged two things in the
platform driver. Both are still there in current mainline:

  cc770_platform_probe() collapses every platform_get_irq() failure into
  -ENODEV, so an -EPROBE_DEFER is thrown away and the probe is not retried.

  cc770_get_platform_data() tests priv->cpu_interface for CPUIF_DSC before
  assigning it from pdata->cir. priv comes from alloc_cc770dev() ->
  alloc_candev() -> alloc_netdev_mqs(), which uses kvzalloc_flex(), so the
  field is still zero at that point and the test never matches. A board whose
  pdata->cir has CPUIF_DSC set gets its clock halved in hardware but not in
  can.clock.freq, so the bit timing is computed from twice the real rate. The
  platform data example in the header of that file sets exactly that bit
  (.cir = 0x41), and cc770_isa.c already assigns before testing.

Neither 3 nor 4 is a dt-binding change, so they can go in on their own. If
you would rather have them as one series under net/, say so and I will repost
them that way. And if any of this is out of scope for you, tell me and I will
drop it.

Thanks,
Quchaosheng

