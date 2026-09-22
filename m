Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209E3CFF61;
	Tue, 22 Sep 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060800; cv=none; b=Z53K9SjlI7diglUq6jjiu1vWGPakTUxtueuzk0wUOCL9upGZkVSCRA3eh09YceFw8esJucVApy1P/2by8AfllDt+Cjg2TCkBa5AkcILkYX69lvMURKpCcvNh0p6ZN+5vPESrvdFFh7PPfaBRU6IOlr165FrNeeqqjGsmVJ8h4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060800; c=relaxed/simple;
	bh=2v0J08ekGKInAg8ts2eGxoSmJnRe5kmyENO/PM955mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULOfuxVT8NbjtATVQymXbHWvZtuWshZJeZ1anFn9Cd1q80YhgRZdJSe3YDcFVxuPE4TllUNawG7Gt9VISmH9XkHWDFN6knovjWN/aGmxV/Fq1NLsongIJOGPsRvE7mhbUyE/5CmfNoBfv4hw8IkDsFZlEW+oVvVD3a3JLGBvRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HoCziJ5g; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HoCziJ5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lq
	GzawzzxGlJIRbzx4Y7DEqOE6+8eDPsHRwSEPRv0Cg=; b=HoCziJ5gURp2NCXNa8
	13oVkQUem//grJcv1n1swDl5GfR64e12YT0TiMAEaJChgw31LPIFqO6CHkABGHX4
	0aBxKyeLmyDRvu6W57eZvQifwul2+d0b3cdQZCuL6qXjoHjyP+b7/1qMXK69cv/c
	qudzhImrVCi0dPnT68ozQHw1E=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD335fqKLJqnRpFAA--.27844S2;
	Tue, 22 Sep 2026 15:06:19 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH v5] dt-bindings: net: can: convert ifi_canfd to DT schema
Date: Tue, 22 Sep 2026 15:06:09 +0800
Message-ID: <20260922070609.70057-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org>
References: <70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD335fqKLJqnRpFAA--.27844S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1DGF1kWw18GFWktw1UKFg_yoWfCrgEga
	9Yqw1kZa17ZF97uan3CFWYvr48CasIkF15CrWvqry8K34rCF1DW3ykAr9Iqry8GFZxX3Zx
	Aa4rJr4DC39IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUb2Q6PUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AuLAWqyKOvoxgAA3Q

Krzysztof,

On 09-15 you asked me to slow down and I said the three CAN bindings
would stay put until you asked for them. One thing has changed since:
Rob reviewed the v6 postings on 09-21. holt,hi311x and ifi,canfd-1.0 came
back with his Reviewed-by; fsl,mpc5xxx-mscan came back with four comments,
all of which are addressed now.

What changed in mscan, so you can judge it without opening the patch:

 - clock-names is an ordered list of ipg, ips, sys, ref, mclk, and clocks
   is minItems 5. fsl,mpc5121-mscan requires both.
 - The fsl,mpc5121-mscan if/then that only restated the enum is gone; the
   per-compatible defaults moved into the property description.
 - fsl,mscan-clock-divider has a minimum of 1, the driver divides by it.
 - One example instead of two.

If that is enough, may I send it as v7 - one series, one thread, one
version? If you would rather it wait, say so and it stays where it is.

Quchaosheng

