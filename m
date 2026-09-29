Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7139A060;
	Tue, 29 Sep 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667449; cv=none; b=kJ25Y34slgYC6p0wXd1c9t3o20MSRmT5sAp1BkS7qfaZu4iehYv+rUEp7W9vf/Fd52eIzPJbbZ9SDwGsISvTM+jdJkhP5A/G0Dmjwm3CO99PKHxj4S3+6nAZmgGndP5w0oRS/qJ4k9Gb/Wj4fVJgy5AOUA6TwHaKrsyp1Q8iqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667449; c=relaxed/simple;
	bh=HCHtTuGQPMYR7U6XKXE31DBoUXa/Eh/aHAdRyToyPrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLHKCC0QbR0NRNqpdvg4/dNUwNmtYEUEraghwyClzoGCe9bZ5x8S1cm0cquKFqUNhuQGJhTFdJPqVSNa4D7kZU1fUrLNwgYBKfz5jO7S0mky0TJaBefayyQ3PJ7HQzF/mye9+fP1wZn41vWdaYqKhcMxwQCbwnQ+3FN8C6f/YDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gGfi4VTv; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gGfi4VTv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tv
	mLYQ/Y1zm+DRYl3k5MwnunVA+HirI21/ozuF1v13Y=; b=gGfi4VTvH7pOO5RjV1
	m64mp8nLKu9tCnIsHO14vrnZT9UcRdy+03QKaS63PG6QoEIyjWK+VcHrcq33QbaG
	29hoPgpU5VTWyPrsrs+IKhMx0ep1sgE37P6NktCf3noMlAjRHvY3llgt7DnHpJre
	ZlDRSi4MXQh4zrVEuOmkA4svA=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB3RBWfartqm_LUBg--.35712S2;
	Tue, 29 Sep 2026 15:37:04 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/2] dt-bindings: net: can: grcan: convert to DT schema
Date: Tue, 29 Sep 2026 15:37:01 +0800
Message-ID: <20260929073703.2748220-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB3RBWfartqm_LUBg--.35712S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRG2NKUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wBMwWq7aqAwcQAA3o

Marc asked for the two grcan patches to go out as a series.  Contents
are unchanged from the standalone postings.

Quchaosheng (2):
  dt-bindings: net: can: convert grcan to DT schema
  net: can: grcan: update the binding file reference in the driver comment

 Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml | 65 ++++++++++++++++++++++
 Documentation/devicetree/bindings/net/can/grcan.txt                  | 28 ----------
 drivers/net/can/grcan.c                                              |  4 +--
 3 files changed, 67 insertions(+), 30 deletions(-)

-- 
2.43.0

