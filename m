Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434933AA1B0;
	Mon, 28 Sep 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588830; cv=none; b=ZwF7tNcyvi8gW9WZ+TuxNVp7ds7B5TmCzSEDAGXVlhcqiipumlN0QQHRhXkDRTXvPSEJf7+kwdyWeR1iViUPBYDBLeBYx4CVoxPLCrrzHh3GrPN2KHbWtsmLqN2xKpN0pqW7IpwFSh82dl7rqk0r666C4toCjtyklwnXzkjZcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588830; c=relaxed/simple;
	bh=QxNYjbjohvk12RXpLwN3g+fj2RmLhQxuNZlT62QMI1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtiq/svN5UH8UTrvz4CvWcIo235wlB05r8gYQhxY//HgOHHKMqRttHOjXmY3YY3KwSUnA4Pv0/7eRhtYfU73eVl0J0nXE6LQ0AduQyAGyVCmX+RvYmU1kB5ba5h+Q4IOKeD2UxWWiwm7mD7YiUEPJ/DxCFojgA3YPC9iRxWDTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hal6qcVz; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hal6qcVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lH
	b/j4VUSHw2VdxvSTI4RyJw+hoehkT0FqOnBtls2HY=; b=Hal6qcVzR0gyxn11kw
	JIrVb4a304G7PUXaz7zRby5q9N9ylUDqiglves+QRYeGzHhq3cJIgqWrJT9NdpOe
	nNhZAURVphU6XfT3NghfbFmKSZjgjrfAYSxpqn8aiM6jBaSZKTnVVFPrVJ7GoM8F
	jXnMByJ6Lj50GtFPRcoPsjwdw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X0WIN7pqt_x4BQ--.13130S2;
	Mon, 28 Sep 2026 17:46:48 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: propagate the error from platform_get_irq()
Date: Mon, 28 Sep 2026 17:46:46 +0800
Message-ID: <20260928094647.2021321-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914055611.495105-1-quchaosheng000406@163.com>
References: <20260914055611.495105-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0WIN7pqt_x4BQ--.13130S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxZw4ftFyDWFyrJw15XFb_yoWfJrc_Gr
	4qkrWxWw4Iv39aya13KF129FW7ArWfur1DA34vq3W2y34ruFW5uF1fKrn5Zw1fGFnYywn3
	Cr98Kr1S9w4avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUN6p7UUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wg5rmq6N4hEnAAA3L

A gentle ping: no reply since 14 September.  The change is six lines, so
the only thing it needs is a yes or a no.

Restating what it does, in case that is easier to judge than the original
description: cc770_platform_probe() collapses every failure of
platform_get_irq() into -ENODEV,

	irq = platform_get_irq(pdev, 0);
	if (!mem || irq <= 0)
		return -ENODEV;

so -EPROBE_DEFER and -EINVAL from the irq lookup are discarded and the
probe never retries.  The patch checks the memory resource on its own
line and returns the irq error unchanged, keeping -ENODEV for the case
where no interrupt is described at all.  c_can_platform.c and
flexcan-core.c already do it that way.

Nothing here is urgent.  If the form is wrong for your tree, tell me what
to change and I will resend; if you would rather not carry it, say so and
I will drop it.

Thanks,
Quchaosheng

