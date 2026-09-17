Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8E4A262C;
	Thu, 17 Sep 2026 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636910; cv=none; b=lU6cc9tGo3ORYLQ3j3CRXhJIpGIQSHnOSYRs3ILR7V/4R9PM90qPvq9sXeXb39Mwe5KwRLL7wrYOaMcHRR9kmjbNDxvSzeZ30C6+rgpzaBcFe7pr2V4vbK9Sq5wlfGGdLxMD0PsNurN5nSbxuAK79ZewxB3vv3YLUmsnm4VBIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636910; c=relaxed/simple;
	bh=y9vGUKcOYNd8t4Ax5GRbHNRCGEh6c6pSeSoGcggPO5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmh31Qm2OqMPYpJBv+WSCGmNYMLz8d1qEq7Vhw8b+VsljEKGhNkWTz2YR2dWl3xd+SM+YreGWHx6Wv1w62sJ7xGbOu/O58R146mgXCrSvKtrslJYz6C5GojvNvCIGk3M7OC6aLCbHCyDtrIWEo/kqWMq+0PtyBuZjHiX6JXRbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qQXQSQP7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qQXQSQP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y9
	vGUKcOYNd8t4Ax5GRbHNRCGEh6c6pSeSoGcggPO5M=; b=qQXQSQP7CyCl1gyMyg
	Ux5VpErO21202l77qaxN2VKvMNXKbQU3JMkNZc74CGcyumQEQRQ7j0i4ZQMALUHm
	sbHStS7gbtJW9FOzujMjua7vS/+OZ5czDsJDDXIM8zVjdZuCj86A5on+Wh/i5ZiN
	KhqS2YjEwovetQdAzHdCrLuq8=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wB3V8kXsatq2o6sBA--.8841S2;
	Thu, 17 Sep 2026 17:21:28 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: holt,hi3110: Convert to DT schema
Date: Thu, 17 Sep 2026 17:21:27 +0800
Message-ID: <20260917092127.388335-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915-elastic-chameleon-of-argument-ab5cdb@quoll>
References: <20260914030215.437602-1-quchaosheng000406@163.com> <20260914030215.437602-3-quchaosheng000406@163.com> <20260915-elastic-chameleon-of-argument-ab5cdb@quoll>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3V8kXsatq2o6sBA--.8841S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1rGF47ZFy8KryfGw4rZrb_yoW3ArcE93
	yqywnF9w1aq39a9w429FnFgFyrta9xury8XrykGr12v3sY9rn8XFZrZFyFgryxXFyxtrsx
	t3say3ya93WDujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRF1vJUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABj3bWqrsRhD-gAA3X

Hi Krzysztof,

Understood, and sorry for the mess. The four patches clumped in one thread
were my mistake: I posted separate bindings by replying into an existing
thread instead of starting one thread per patchset, which is what confused
Patchwork. The threading and the repeated versions were my errors, not a
tool problem.

I have stopped posting these. holt,hi3110 is part of a single clean v7
series together with mpc5xxx-mscan and ifi,canfd, and I will hold it until
you ask for it. When I do send it, it will be one series, one thread, one
version, with the spi-peripheral-props reference dropped and an
"Assisted-by: LLM" tag added.

I replied in more detail on the ifi_canfd thread
(<70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org>).

Thanks,
Quchaosheng

