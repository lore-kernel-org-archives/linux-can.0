Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03683B6C18;
	Mon,  3 Aug 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767107; cv=none; b=KfUz6Pkem/uvaiu//cPJlBCyKz2Y2VWb5qkspBZRqEFqmIJb5jlMQ/qJJFfy0tcVopAfHg5SzPRxxyNQXI5EaxPNUns/0aZru8uKMhU6XQs9YbqtRoNMjqvmfvsNOcB/4LkAaB1sTqn2DG7Nz0eg+MGDOVGdkzh95CWIYO+vlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767107; c=relaxed/simple;
	bh=mVevaR3wGZ9aVRH1xY1mfvR4PG4ZMnQ+Ma5kT1+Xlq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j9jsHX67UVoy2YRf+zTPoUUHa2/smCHDvR51qWQ5oDu6l2fehZSQozctLXYDupGvDd5pCpFeumlRCrQxdlh7K21/ogi017AiY1asgz3hDk+kjaY6TsoJWSHxCZtHdsbok1VafHrkYgaUAX7NccfGbGQ6RjyBnfGNe0tuOABxue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrZOmYce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrZOmYce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9A61F000E9;
	Mon,  3 Aug 2026 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767106;
	bh=XJsbLpUGwIq7NEHl22T2bXHDJGAT7SEAyV6p+h2lBlE=;
	h=From:To:Cc:Subject:Date;
	b=VrZOmYce5ENhzKOGSygaE55iE5iCz4J1CVpvTxsUBcuL1gKXZJxa3APqmIGBpBZFu
	 AbZ6d6z23fJyr5kQGse5JByiJ3rZY2TPV+0WDkC3yaXCHkUud+PMGlrUClnGmCadn/
	 hrplVUlaanCnPyoX5t1osElDdqBPsVeXgr/NkJyjXHWWCbTLWCcZIRHKl8F/ElCtqo
	 cr7pMWDIuBbRlfQji3ENIl09TCHVS8tP4vHy84e9FH5Kq7iBHxOteQcu6WqfBDGLip
	 iHbLL+Qo1k24N6fTqa+EVwXedUtvhESADduX+jJx3aM3+e4m4dR9KxcwGaNhoQXkCn
	 lKmFhg+DxiTrA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] can: add arasan canfd controller support
Date: Mon,  3 Aug 2026 22:05:29 +0800
Message-ID: <20260803140531.12692-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add arasan canfd controller support.

patch1 documents the dt-bindings for arasan canfd controller
patch2 adds the driver for the arasan canfd controller


Jisheng Zhang (2):
  dt-bindings: can: add arasan canfd controller
  can: arasan-canfd: add driver for arasan CAN-FD controller

 .../bindings/net/can/arasan,canfd.yaml        |   63 +
 drivers/net/can/Kconfig                       |    6 +
 drivers/net/can/Makefile                      |    1 +
 drivers/net/can/arasan-canfd.c                | 1057 +++++++++++++++++
 4 files changed, 1127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/arasan,canfd.yaml
 create mode 100644 drivers/net/can/arasan-canfd.c

-- 
2.53.0

