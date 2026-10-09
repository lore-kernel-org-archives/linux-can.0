Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066C4C8C68;
	Fri,  9 Oct 2026 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543260; cv=none; b=S2HJvPy8nuO7W4EfIrB9p4NSVIjPO7XQ8im4rWWcP5FpewVjltPMRmVdYJH40VOkNBo8bGHfaUrJK/cIhenoSY6zD64G1wFubcBclrJr7wYSYl2MRPueqWBybMHdrfIcZ8ajeX0Rd0wyI+Bf3uORg0sxoxqwtVeUcjv/xbX+Aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543260; c=relaxed/simple;
	bh=VV41Yz0KP1aMiXNYElH1F1M1p88P2jyEl3CLXT/LNvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqCiVCtiw8pU5EkeW05ZizP7JkL+0OF3gmbEWNd04QI62z3a/4r89cq7cC8HmXiYL773+5+KNG5FThz1S8bgP+XCaQlVemwEdDQENQWy14Ngw0b0w7iquHcPuicPVywDFk8J1WIH+bL7t+MFI9XQjEgJrZaF0k2jgX1CpwLeQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NnZHXrUZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NnZHXrUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PR
	csCC8ALUDgwLcRGXY88/YZ0+WiyHnCQUPlng6T2Yg=; b=NnZHXrUZN//geGWxzd
	MhKXrJgntFz7fLB7wG5YM5XMC3Elim6AuiGfat6buDOAscXMrecrm7shCOm0KkpJ
	jEx3GflCvMSMwUHYhMMaopzTqtq2YotmSXvbjzQrxux0eI8UolyxizbSGtHNWx0o
	3tcAbI1JcwS3AqsPim7xej8tU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXX8S8x8hqZHAsDg--.36732S2;
	Fri, 09 Oct 2026 18:53:49 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] dt-bindings: net: can: cc770: convert the binding, fix the driver comment
Date: Fri,  9 Oct 2026 18:53:46 +0800
Message-ID: <20261009105348.300114-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX8S8x8hqZHAsDg--.36732S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr45Jw43Ar4Uuw1xJr4ruFg_yoWDCFbE9F
	WkAFW5J3Z3CFn8Kay5Ar47Zryaya1kZ34rW3Z8Jw42q34xWryUJFn7tr45Wr1xWFW5ZFnx
	AFyUJay8Cw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8QTmDUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x3tY2rIx72wSwAA3P

Krzysztof dropped the whole thread from the DT patchwork on 09-15: the
four patches went out in one thread and confused the tooling.  This is
the same work, sent as one two-patch series with a cover letter, which is
what Marc asked for on the CAN side.

  [1/2] converts cc770.txt to DT schema.
  [2/2] updates the file name in the comment at the top of the platform
        driver, now that the text binding is gone.

Both carry Assisted-by: LLM, which the first posting was missing, and
neither has been reviewed by anyone yet -- the previous thread was
dropped before that could happen.

Quchaosheng (2):
  dt-bindings: net: can: bosch,cc770: Convert to DT schema
  net: can: cc770: update the binding file reference in the driver comment

 Documentation/devicetree/bindings/net/can/bosch,cc770.yaml | 158 +++++++++++++++++++++++++++++++++
 .../devicetree/bindings/net/can/cc770.txt                  | 109 ----------------------
 drivers/net/can/cc770/cc770_platform.c                     |   4 +-
 3 files changed, 155 insertions(+), 57 deletions(-)
-- 
2.43.0

