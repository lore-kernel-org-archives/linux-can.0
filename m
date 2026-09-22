Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09F535FC6;
	Tue, 22 Sep 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072617; cv=none; b=UhkESkj9ngDF1Kpngp+EbqTJ9r1PPKGE/fnVm82sQCoHpop/qPkBqYffBMEVNJpnQzImJIZE4pWpIeHUYy4EWL39zobvShfwoVhHP5Ga50zkOIPRH1zmVnr+R7mAIwsdC4YvwG47BCwWLsGYAiZ42wW+fksNmF/eU5AY9+v6CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072617; c=relaxed/simple;
	bh=BQziGlCZF5AlKoF6iVqSyszqPKzzfoidsLoHqjcbADg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIwS5KB5ndp6yVz6LdnJQBAbv1HEgIF7D3SgPAw/1GPPCdYwmjLd6qViO5Z2cI+qESKcJ2PFgylZXTb9BnraBZvcx2QwV3acd88NfHhp7/uunrkJB0IPnfEzwshkZung8+kT1XAcgZhBnl3pDhJlvuHChYsPjTk5PYKGBb+5F4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F/r893jK; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F/r893jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cw
	WJntWKUX+5bpXytMV+EQljnUUj2kWjym/4ol8Wkv4=; b=F/r893jKWjRq7HeyDA
	nqV0cfs9twyPlk7pWz/ZP4u+3miprW5BkFogmH15oNM14jP8bqtlHtJLpBy0L5hT
	tGfZPr2Oml9skMUNVtHQr6g2EOv2VL/zyAb24qizUYzeI0pFs+iX34mXJislr/m9
	+C5e0r4M3mLgaG07OC5PHVZrY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X+0LV7Jq8o9oAA--.39710S2;
	Tue, 22 Sep 2026 18:23:08 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v8 0/3] dt-bindings: net: can: convert three bindings to DT schema
Date: Tue, 22 Sep 2026 18:22:55 +0800
Message-ID: <20260922102258.138753-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+0LV7Jq8o9oAA--.39710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4ktr1xArWrGFyUAF1UWrg_yoW8ZF4Dpa
	n0kFn3XFyqy3W7tws3K3W8Ar15Za95ZrW5KFZ2qr1kJay5CF45trWFk3s8ZFWUWrWfCFyx
	Zr4jgF4rGFZ8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAsqJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AwglWqyVwwJxAAA3T

Three CAN controller bindings converted from free-form text to DT schema.

One series, one thread.

What changed since v7: v7 dropped the spi-peripheral-props.yaml reference
from holt,hi311x, on the grounds that the example does not use SPI
properties. That was wrong. The HI-3110 is an SPI peripheral, so its node
carries spi-max-frequency, and unevaluatedProperties: false rejects it
without the reference. dt_binding_check against a node carrying
spi-max-frequency fails without the reference and passes with it.

holt,hi311x is therefore back to exactly what Rob reviewed in v6. Only
patch 2/3 differs from v7; the other two are unchanged.

ifi,canfd-1.0
	Unchanged from v7.

holt,hi311x
	Restore the $ref to spi/spi-peripheral-props.yaml. Identical to v6 again.

fsl,mpc5xxx-mscan
	Unchanged from v7.


Quchaosheng (3):
  dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
  dt-bindings: net: can: holt,hi311x: Convert to DT schema
  dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema

 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 109 ++++++++++++++++++
 .../bindings/net/can/holt,hi311x.yaml         |  67 +++++++++++
 .../bindings/net/can/holt_hi311x.txt          |  23 ----
 .../bindings/net/can/ifi,canfd.yaml           |  46 ++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt |  15 ---
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
 6 files changed, 222 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

-- 
2.43.0

