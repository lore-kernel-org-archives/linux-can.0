Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF92FD665;
	Fri, 31 Jul 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491117; cv=none; b=o8EyYEhfibvkQhS8F4BP9TwEBMn3h83NBFZ5jPRNuB2ScZEVsgllla0Rhvysv9IO7NERchFzI2NMSRZhmM6SWroIFDgxE3mOyz8BEXi1OdgGzHQlg3j/Z55seuriIwsGZ2Z26nRq+f2h1nEks+v18etGydoVVmGfqBbeGroKTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491117; c=relaxed/simple;
	bh=0dbXPAmpOvKPTg21AyLMdN+GdvMcbiW0jFOCa4uMP5I=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=ZQX6/4TNMI/Z9YEMwdDzVfLLg6WnJZNsRBFKWsXdqlg06SLcoR6vMT0bl96fkjlg8PqsjeRFQOEZc8MjhgEDefRcZuF5T7h34v5/mCgB3D4jSEwqiC5kh5G0jsLobfciTqxkOz/TtObzPxPK1sbWtPK5xZhGPdk+S+U3ANC6zS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b+HSqDDt; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b+HSqDDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785491109; bh=/Ck80FOGA6ogSTY3SG8TMdbFAQItmNACdduHpi0HVFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b+HSqDDtczFQKHBb4B/c0dECF1d1C+mvz3rlNzoy8ZGAu4uW/HU47h/iG7PQzXKvT
	 Q/hCn1Fmi0bYqY9+hTj2o55uvnPwkUf9kDVeVAvebrSerC+lZp2AwJUEfZcspmQOpc
	 8QJNa5hNVGnTp7dP//PGMYGFb9ulPS9767qnf9FA=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B4623E87; Fri, 31 Jul 2026 17:45:06 +0800
X-QQ-mid: xmsmtpt1785491107tj5yvbrnh
Message-ID: <tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X6+tuUJ4xiCMOyIng2rpDc3xPa5v5rladyD3lXEPI3W+zjW1LrI
	 THBa/qFrH6l6opz1gmmlUaZLm5RJ6jmA1Nud7TWaadEYWUGSFg4KVzWmSqsAlYluka4XPuoaaENj
	 Fu7rB4Aotfs451kASmM/T4aavN2rttFVrYPLMpu4pQpxiCFYiGCIgJ0ae6YhYgLHqYAWnD1BIdlq
	 W2eE5pk8o8h3qdt+3sFkhBYf/PkoYh+6VOH7TwdFBvMdMUPektHG4Rw7UyAG+DkpXj4i7LXfhRha
	 q8Q48Jlz6ln8wObBA+ukoT63Y3RekX0pniWcmICcC9XNWr8+UFjQYYI0VFdgcEYZ+gAEtlhZickv
	 q/EPbuWxD13WR9GTqsod1aTOG/MilajYnu27TUub+z4C+jqgS+DtRjAGGxZ5H2U8njOSy+LcNLNO
	 oEJGaQxk+g71XivjiMcypAjG7HzrE98qoL4xymjEdAI7LDMXKzb3O3Lb0pm7hCh5VVdBWWaoCqHG
	 k4KOUYGC/fmcbs1Vz9C13JLYbOEbEi5AQtdNHSdc0507V/59fgTO7txU4GYPhWvherI2PeqYZpNq
	 ExzxhWIqHxNmkEh8njgfEX5Z5heC5o0kUzCHXge1ya8eqQ2KYRCH8nM94VCs1zlwY55qmaFz2hZD
	 ADybPRcANwQ6vm0fK6VgEgrrwHGkz4GVRTkc9yUdpTeEy2IGqQQvacJnhv2IwIYcI6/CJq72NzMh
	 QXyBLNJfPplvC4VxwPfnxGljIwRxJuM8RDhJtwELrV3VQfAGCBnaYvCe0k4u5WqLJI2QOpYno6po
	 mN7JAuW2j+N4r8qS+whmTUiNnZ8/rNlT0FC1ADLZPfOd+Jo7QluEmNG4km2csbnp7xfxFGtsn1Hn
	 FEdWDozLVI7MkX4nyAsN2qjHrUMUbVFmOiURivnYqNH1Rbkmhxj2gscNKjeOvet5lfcXZtMla9CG
	 Jq2qns3RX+UXdfCi/7hj52aeHANrZFPh88LOCfExKsRbCTo6rKrPRUYBf/ZgJPHST7oAn3xLYGft
	 yYbz5/bjwElRVmZeHcnYNmPkVNCJpCa1BsDp/22ejoE76XoKr4the1cbEaA2Qw+W+T1KQ7kA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 17:45:00 +0800
Subject: [PATCH v3 1/3] can: skb: make echo skb freeing safe in any IRQ
 context
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v3-1-b56cd1e8d675@qq.com>
References: <20260731-master-v3-0-b56cd1e8d675@qq.com>
In-Reply-To: <20260731-master-v3-0-b56cd1e8d675@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

can_put_echo_skb() can be called with hardware interrupts disabled. Its
direct drop paths use kfree_skb(), while can_create_echo_skb() uses
kfree_skb() when cloning fails and consume_skb() after a successful clone.
None of these helpers is safe in every IRQ context.

Use dev_kfree_skb_any() for all drop paths and dev_consume_skb_any() when
consuming a successfully cloned skb. This preserves the respective skb drop
and consumed semantics regardless of the caller IRQ context.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v3:
- Cover can_create_echo_skb() clone failure and successful-clone consume
  paths with IRQ-context-independent helpers.
---
 drivers/net/can/dev/skb.c | 4 ++--
 include/linux/can/skb.h   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..d7b5a5d17ff2 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -62,7 +62,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD) &&
 	     skb->protocol != htons(ETH_P_CANXL))) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return 0;
 	}
 
@@ -90,7 +90,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
 		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return -EBUSY;
 	}
 
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index a70a02967071..78c5870e2f9a 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -76,12 +76,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (unlikely(!nskb)) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
 	can_skb_set_owner(nskb, skb->sk);
-	consume_skb(skb);
+	dev_consume_skb_any(skb);
 	return nskb;
 }
 

-- 
2.34.1

