Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15A280CE5;
	Wed, 23 Sep 2026 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127531; cv=none; b=pPcHWoIpv7zAUgag9kA2UtykDDq2uJP3WKh6PjvPKHCtkvBmPOyG4rgeqMwsuOMMAv+0U8mq9OwdImHzDsdml3qzz6RgxJh+cH84ExDXrjOvvI40jf7wit8UT771BfDprjY87TMXsIKR7spEZTpNv95217fQfg3nj5Ro2KwoO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127531; c=relaxed/simple;
	bh=eZh06shuqHIYbdk2qNqV1tq5+uAm/bVrpFSQu9U5/rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUW3W6t60zIG0lEqfFFV1UOl9MKrxvgd/KLzV05iX7bK04hCrF89N9YVymPq+j3YTPYV4jnHQ8YxvG3vJTM9mlglhr7BHWh1OqvQ4Ea6G2rE5vzDDHNDrR7/3Y3PXF+wJ4SMlgJt03JRE7XvguPa0r/NzjWYg3DwdKTtG+mFWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lVqzVuTb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lVqzVuTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RI
	99MM920KlirIbxR+D0b1pYBiaj25vbsB6KSElZhwY=; b=lVqzVuTbv7bGp1SBOv
	sd77dp/pJNsH4lC8W7p6L04vzVRvbrokhMWANWb4CcQWDLXJAJXvWh5SHVg1lZ/p
	vaRge7UeGZq0Q2F7THSVQTTbRd4RyJTjzwGZr5o0NCy7kdCzb1iQ8tDcWCxr+O2t
	Z10UaXUUApBYLWrjFhy29HWd4=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3z+WNLbNqyHDyAA--.39164S2;
	Wed, 23 Sep 2026 09:38:22 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Rob Herring <robh@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH v8 2/3] dt-bindings: net: can: holt,hi311x: Convert to DT schema
Date: Wed, 23 Sep 2026 09:38:12 +0800
Message-ID: <20260923013812.256689-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179008111842.3145564.13410709686921168865.robh@kernel.org>
References: <179008111842.3145564.13410709686921168865.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3z+WNLbNqyHDyAA--.39164S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW7KF4ktw47KryxAFWUurg_yoW8ArW5pr
	Z5JFWfAFWqqF1fAay8Zr48u34fKwsxWan8KryfKrWxuay5uFyayF4vy347XrWkur18Ja13
	ta90qrWkJw1ruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUmNtcUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w71a2qzLY7xCQAA3x

Rob,

My previous reply went out from the 163 webmail client and carried an HTML
part, so linux-can, devicetree and linux-kernel all rejected it. Resending
as plain text; same content.

Reproduced. The errors come from a dt-schema change in git, not from the
patch.

They are all in reserved-memory and the IPs that embed it:
shared-dma-pool (via ti,omap-remoteproc, ti,k3-m4f-rproc, msm gpu,
intel,stratix10-svc), nvidia,tegra210-emc-table and fsl,qman-fqd.
Nothing in net/can. None of the files this series touches are involved.

The cause is 840a01d ("schemas: iommu: Add iommu-ranges on a device
node", 2026-09-17) in dt-schema. It reworked the top-level constraint in
reserved-memory.yaml from

  oneOf:
    - oneOf: [required: [reg], required: [size]]
    - oneOf: [required: [iommu-addresses], required: [reg, iommu-addresses]]

to

  oneOf:
    - required: [reg]
    - required: [size]
    - if: {required: [iommu-addresses]}
      then: {required: [reg]}

A plain shared-dma-pool node with a reg now satisfies the first branch and
also the third one vacuously, so oneOf fails with "is valid under each
of". The "Unevaluated properties are not allowed" lines are the same
failure cascading. The error text matches this exactly:

  is valid under each of {'if': {'required': ['iommu-addresses']},
  'then': {'required': ['reg']}}, {'required': ['reg']}

That commit is not in a release yet. Confirmed on the same tree with no
patches applied:

  dt-schema 2026.6 (PyPI)  -> clean
  dt-schema 2026.9 (tag)   -> clean
  dt-schema git 840a01d    -> reproduces the errors above

Nothing to fix in the series. v8 stands: only 2/3 differs from v7, and it
puts back the spi-peripheral-props.yaml reference sashiko flagged.

Quchaosheng

