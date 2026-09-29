Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB63D952E;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696110; cv=none; b=knniOIksmU1MqRWuc9A9q/yZQBPIwdW5FKf9vfFGHxjqHW4XQlSRQCcydXNQT9CQccZgkzOrpJpNUkcfu+kwltjcyYUeR/3AF1G/O1BMJ1PjdXhkTUQBtOCybHjxK5DnVjyGCZzwKW7Xr285AstADSLNYs+qDhsWeHvgZUcDkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696110; c=relaxed/simple;
	bh=3ii5g5XioV/QpJdb+r2E2qif+Mg0ka1gVPmu8OXLez8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mguTbvoBiUtCtiOkgzyLFaJtuv8u0Iits1zjX0GgRf/SREkauoQTjzxFld1EyOJLHpGB9HhvRZQOVGIUgA0WP6DhEGHtjcekhmbDqkjal8/jX+dOgQy9fNPtZVBat8a9rATIDJsnBY2lNrobpoJGhbU9XUnMdJz6B6oYgTHVr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abdKA26N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abdKA26N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DECCC2BCF6;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790696110;
	bh=3ii5g5XioV/QpJdb+r2E2qif+Mg0ka1gVPmu8OXLez8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=abdKA26NFzJiGv64crbMvzuG1s5ZkutUFGza3ppjVAektsjNw4Q/lgfzRXrp7Zod0
	 V7hDUJwUvTH/dJZy+GNW3Tj+z7lF7IG94JJgo0wK1D6h62aOAGiufnmm8L/SAV6z05
	 4mF8BUr1HapuAsnewlNhMtTtA5lpDdUdz40itHyh87Lr15Egb/aR26hRNEimih516p
	 LkdRrjsxsVql7O4hyHvVSnVgpMz7xay7yb0vFfspPz1LTDVG2xWrIG0AY5FKeiMHpx
	 qslySP73m/e1RwwvAqeoEtAK+DgcOK7wejRLZ3489XUp+wDMap2VOT/HQhLS8xSJoi
	 aMzsxiEz9P4oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B7CA5FAC;
	Tue, 29 Sep 2026 15:35:10 +0000 (UTC)
From: Chris Strong via B4 Relay <devnull+chris.strong.flocksafety.com@kernel.org>
Subject: [PATCH net v2 0/2] can: mcp251xfd: bound RX offload batches during
 long IRQs
Date: Tue, 29 Sep 2026 11:35:00 -0400
Message-Id: <20260929-upstream-can-rx-offload-batching-v2-0-3b587c519f5d@flocksafety.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTau2oC/4WNwQ6CMBBEf4Xs2TW0iVU8+R+Gw7psoVFb0lYCI
 fy7DfHu8c1M5q2QJDpJcK1WiDK55IIvoA8V8EC+F3RdYdC1NnWjFX7GlKPQG5k8xhmDta9AHT4
 o8+B8j4YvlqQzrE4Gys0Yxbp5V9zBS4a2hINLOcRl105qr34G/d8wKVRYN42cmZTmRt3KgJ+Jr
 OTlyOEN7bZtX1SVX3XbAAAA
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chris Strong <chris.strong@flocksafety.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790696109; l=1768;
 i=chris.strong@flocksafety.com; s=flock-workstation;
 h=from:subject:message-id;
 bh=3ii5g5XioV/QpJdb+r2E2qif+Mg0ka1gVPmu8OXLez8=;
 b=sqG/OlvWVuExzBPFDZbxeZ4PhnZ1V+nWXnXMh9Zbm4RU1Ol3KT5SfoerUIo0RzgJwAD7G23Tg
 aP3WCi8esFFCI1bTc2vINd6CUttlNo81d1C8seRnKdxEFGaM0PwI1OU
X-Developer-Key: i=chris.strong@flocksafety.com; a=ed25519;
 pk=IaEYd0fwBUeOKjqZzp2UKZY1tn3CLcPh6JpOKznZyRE=
X-Endpoint-Received: by B4 Relay for
 chris.strong@flocksafety.com/flock-workstation with auth_id=1045
X-Original-From: Chris Strong <chris.strong@flocksafety.com>
Reply-To: chris.strong@flocksafety.com

Hi all,

Under sustained receive traffic, the MCP251XFD threaded interrupt handler
can remain active indefinitely, leaving received SKBs in the IRQ-local
RX-offload queue while NAPI remains unscheduled.

Add an RX-offload helper for identifying a full IRQ-local batch, then use
it in MCP251XFD to publish batches while the handler continues draining
the controller.

An equivalent backport was tested on a Qualcomm QRB5165
(msm-qrb5165-4.19 vendor tree, with mcp251xfd and rx-offload backported
from v5.15+) driving an MCP251863 over GENI SPI at 125 kbit/s. The system
remained operational overnight under 100% CAN bus load while receiving
more than 51 million frames.

This mainline version passes checkpatch and an x86_64 build with
MCP251XFD enabled. I do not have a setup that can run mainline with an
MCP251863, so it is build-tested only; a hardware test would be welcome.

Signed-off-by: Chris Strong <chris.strong@flocksafety.com>
---
Changes in v2:
- Split the RX-offload helper into a separate patch.
- Shorten the patch descriptions and use imperative mood.
- Keep the code unchanged from v1.

Link to v1: https://lore.kernel.org/r/20260922-upstream-can-rx-offload-batching-v1-1-099e7ca12c91@flocksafety.com

---
Chris Strong (2):
      can: rx-offload: add IRQ queue flush predicate
      can: mcp251xfd: flush RX offload queue during long IRQs

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 14 +++++++++++++-
 include/linux/can/rx-offload.h                 |  7 +++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
change-id: 20260921-upstream-can-rx-offload-batching-6c8faed6c156

Best regards,
-- 
Chris Strong <chris.strong@flocksafety.com>


