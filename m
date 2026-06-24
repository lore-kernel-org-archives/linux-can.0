Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F633242CA;
	Wed, 24 Jun 2026 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280176; cv=none; b=U/DLiTRwUm1dvaVkOsYnRvITgwbu3Ijlt2mcMoMgKRh4K9UnYFbAl2gXhQ1nNlZvWfy1DS9PnzS4UyTStZeRM7AHdlCK3ktlv85YFt4UMZxGS/wgeEw5oXC05DAUzTpR6e/mbGhv72Z5treRypk0ltfNMqfgDGZFJSPwFRsDe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280176; c=relaxed/simple;
	bh=TDhK/eBP0YNhZA8cfkNoeq2nrBGULXAD7jgm2yOnMOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KopKucr3vlZZdTVNXhrgTtTcPwfAitQkotZOG0fD/1pYbfQNuhKmlbiq3B0vP0JT94hVfvYKX2NpUS0umHPwpsUuR/zErkCNH3tE/9Nk3cY9KC0UUIj+ZirpKk5ekzlSiD54poNVqhHG5degSq8dCAIWnJ+Fg+QW0ClvcbRMenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAH5pznbztqHQatFQ--.22990S2;
	Wed, 24 Jun 2026 13:49:27 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: c_can: Use platform id data when OF data is absent
Date: Wed, 24 Jun 2026 13:49:27 +0800
Message-ID: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAH5pznbztqHQatFQ--.22990S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryfuw4xAFW5Jw15Gw1Dtrb_yoW8GFW8pa
	yUZFWSkr1UWr4Y9w17J3WUZFy3u3WFya17KryUua1fu3s3Wr98Xry8WFyIyFsrtFW5G3Wa
	qF4jyry8uFs8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The platform driver keeps controller metadata in both the OF match table
and the platform id table.  Probe reads the metadata with
device_get_match_data(), which does not fall back to platform id-table
driver_data.

When the device is matched through the platform id table, drvdata can
therefore be NULL before it is dereferenced for msg_obj_num and the
controller type.  Fall back to platform_get_device_id() when firmware
match data is not available.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 19c86b94a40e..564c9e5b4c2c 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -263,9 +263,17 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	int irq;
 	struct clk *clk;
 	const struct c_can_driver_data *drvdata;
+	const struct platform_device_id *id;
 	struct device_node *np = pdev->dev.of_node;
 
 	drvdata = device_get_match_data(&pdev->dev);
+	if (!drvdata) {
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return -ENODEV;
+
+		drvdata = (const struct c_can_driver_data *)id->driver_data;
+	}
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.50.1 (Apple Git-155)

