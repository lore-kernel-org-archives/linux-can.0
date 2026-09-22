Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A8519E1B;
	Tue, 22 Sep 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066772; cv=none; b=I0mvElMXjUJUv8OsSEuj7AqDNT5OGRNRVipJtc6UZz31yiWfsAMuFUawy6AGCgZdTw407q/fMQwdEArUW/mQvPuGyLgw+gARch75XUWYY5VpPamHwNghPsYKZUAY9fw4Pupd1v9tQYRW3lXrMCh2obYxuvySqcoYUa1WL3xdyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066772; c=relaxed/simple;
	bh=fL+TqFRDNFHxnvl06iNg5+owSAMjz0l9U9Nft7pxEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LAD1euKaJEONmBfSYx941JsEGBTH1JH2dLP7geiEIjpdmbEngGS5Mi0AnGdky6zuyrsNm5m0dC6ROsTXYNTTNpzSJJFD8l4SCb9o/TdKQjjhSyEVg8VrXI3gnUJDCfp4RInAzjApq2IOGAXx33dAnyAz1yx49LJowze+AiNmE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NQ8vP0/9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NQ8vP0/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hV
	v7DEvsF3++ACJveYhnV71mmTVHvg6R8m6qTzwLhrE=; b=NQ8vP0/9YJI/6ZDC+q
	Zj7vfzCdNBcL2n8tSgh3WM7RUpCC4nMCgRfMpk+xEXT+jBv6LW5kFSLQEbgPU5jU
	BRogX9R2gALEtP5zq2QyqeGpfPda7ImPXyvJFpqvJRI5LCJFAflrJOYqU9qVFv1P
	usZEh99fEt1k+juHMMHHldiF8=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD330E_QLJqT4dWAA--.33181S2;
	Tue, 22 Sep 2026 16:45:52 +0800 (CST)
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
Subject: [PATCH v7 0/3] dt-bindings: net: can: convert three bindings to DT schema
Date: Tue, 22 Sep 2026 16:45:39 +0800
Message-ID: <20260922084542.104788-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330E_QLJqT4dWAA--.33181S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4ktr1UtFWkuFWkXF4ruFg_yoW8Kw1Dp3
	90kFn3XFyqy3W2y39ag3W8Ar15Zan5Zw4UKFW2qr18Gay5uF45trWFkr90vrWUXr4fCFZr
	ZF43Kr4rGFs0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piLF4tUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wBn3GqyQEA-4AAA3f

Three CAN controller bindings converted from free-form text to DT schema.

This is one series on one thread, not three separate replies. The previous
versions were posted as individual threads and re-sent several times, which
is what prompted Krzysztof to ask me to slow down. Nothing was queued while
that request stood.

What changed since v6: Rob reviewed all three on 09-21 and gave
Reviewed-by on ifi,canfd-1.0 and holt,hi311x. fsl,mpc5xxx-mscan came back
with four comments, all of which are addressed here.

ifi,canfd-1.0
	Unchanged.

holt,hi311x
	Unchanged apart from dropping the $ref to
	spi/spi-peripheral-props.yaml, which the example does not use
	(Krzysztof).

fsl,mpc5xxx-mscan
	clock-names is an ordered list of the five names and clocks is
	minItems 5, matching the single order the device trees use.
	fsl,mpc5121-mscan requires both. The if/then that only restated the
	enum of fsl,mscan-clock-source is gone, with the per-compatible
	defaults moved into the property description.
	fsl,mscan-clock-divider has a minimum of 1 because the driver
	divides by it. One example instead of two.

All three pass dt_binding_check clean.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

Quchaosheng (3):
  dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
  dt-bindings: net: can: holt,hi311x: Convert to DT schema
  dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema

 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 109 ++++++++++++++++++
 .../bindings/net/can/holt,hi311x.yaml         |  66 +++++++++++
 .../bindings/net/can/holt_hi311x.txt          |  23 ----
 .../bindings/net/can/ifi,canfd.yaml           |  46 ++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt |  15 ---
 .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
 6 files changed, 221 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

-- 
2.43.0

