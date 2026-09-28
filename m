Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430F4AA035;
	Mon, 28 Sep 2026 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594842; cv=none; b=ge0docwtd+zgWKUZwFGfgQTRFwZUNRqPWEjA3tx7kKIuncbxWV2h6qE4C2pcPU7O5DqeP3GF9ZdKKrB7f/+eqg2wCkBp/JMpc9vS+ZOubxtQH1QjhmKu2NP3CrqOqn3tXd30j2F15omf70jp8mX2RYNqL3GUky2K3iYWMnqZNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594842; c=relaxed/simple;
	bh=Qa3Db2j1Y68653Q+6PC6oV2QxaHFr0W0WH1Pu4X7iRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df5wDTmHst1WUnF7fF99I0G7A4XhV8tC/KhA0GCIJxLxjEFOmxDe9hjC7yPOR8fja90+nvxJ+Nl/mrOYm6uwQ8oxAaNv3r2BehOaJ1DTFfbRoN8UlUdvt6Lvf6bD3td8XTTzFpbo6Ud8DzCm9ONKfzAmErM75t1bZeM2vzV3FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Er66wupC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Er66wupC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hg
	a33SVNks9ojHUUI1aMDk4zOQwGpCtnaoDberMk8Wo=; b=Er66wupCD7DN+10rRT
	tLlg9foqMpDCGseaBRFAgu9H/qMN2eXKJweyln4J5eDGSVSv9Hn3if7PtmCspic3
	ZnJfhgcQckWzK8niC7PRebCiLIRW9IvudllKEsVub6r5No7poyPCzArBGv03QJhz
	qIH8zMOBO9iMjmWgoEwvEUhJw=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBn63cCT7pq8FBXBw--.34376S3;
	Mon, 28 Sep 2026 19:27:01 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: can: grcan: update the binding file reference in the driver comment
Date: Mon, 28 Sep 2026 19:26:58 +0800
Message-ID: <20260928112658.2119678-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928112658.2119678-1-quchaosheng000406@163.com>
References: <20260928112658.2119678-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBn63cCT7pq8FBXBw--.34376S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy5XrWDCr15Jry8Zr48Crg_yoWfKFbEkr
	n7Ga17Xa47Kr10y3Wj9a17AF9xA3yF9r18uas3tryFyw1Ivws8GrWvvr13Ja18Ga18urya
	yF9xAryUWayIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRK8nYDUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AYek2q6TwYOrwAA3X

grcan.txt is replaced by aeroflexgaisler,grcan.yaml.  Point the comment at
the new file.  No functional change.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

---
 drivers/net/can/grcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df..1b4944d1d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -10,8 +10,8 @@
  * Full documentation of the GRCAN core can be found here:
  * http://www.gaisler.com/products/grlib/grip.pdf
  *
- * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
- * open firmware properties.
+ * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml"
+ * for information on open firmware properties.
  *
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
  * sysfs interface.

