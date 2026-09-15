Received: from out198-36.us.a.mail.aliyun.com (out198-36.us.a.mail.aliyun.com [47.90.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C63D649F;
	Tue, 15 Sep 2026 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454290; cv=none; b=qzMsVpOoo68x7R+YPpNf6iyP58d+tH8Fl2flgCax555XEt7nfRuJEie7ZtUwEFjwseju+iIV+qq9U6TNzTj33C5RdnuLGifdl2eHMD+gYgtMOHyQGH0Uk289zdVHk4InVLESyu/xUNWebFctFSgQPLUYma7N2orHv5d7jIoeO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454290; c=relaxed/simple;
	bh=ZoB/YOwd06LMU7y/5rAFHrOp7+5PEOkCp0msYuXXddI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4OrtzxBAOogNPBq8uMzko6JlAnjOFIr5od0mG5TJYBs3GY+wtxFTxdm0e3eIttR8SqqvQf7sCYVsOIQPLf/ed/feKghz3z423U/7EPMqKMiGPvZVB6FH39XAY5/t68HSw8rGiDBibCvE1DDOEwrqCFw4eJIQszvOLMPEtbBJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht; spf=pass smtp.mailfrom=yinhe.ht; dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b=XIsAxgIT; arc=none smtp.client-ip=47.90.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b="XIsAxgIT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1789454267; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JDk6QxtZfGZM6KdJAQU6hPHN6qFU5g0NtpmNmfMi5Ls=;
	b=XIsAxgITQ8LKWzg4DNVDuH3M+VYhfdbyI8IdlL6ga5rt+fFzRQxEJEmLHGUsHZvg8TIanRWI/jqCqsmbDc6fB/2mkQ/bgHNGKNdRd6P50pBKXLVmBqL22Q6W/f3J6fT3DFyNmxWF6ku4XNaMiI26r0fv+8jR73oF7xBBL651XW6y+03aDJKnUzo+yC+WeQA9fUET1SWEuYPflRg/BjR6AVnuiJ1gUphuLhU83Rhg4VnSmF7Q48u/FSwy7B4b1kQ5cTWC6CHB/P+XptCx+2pMmh2KBGAnNVqOh5JYhBw7cAPyLLSxVi2dS/MD84sGbvqy5sVN62Dcb95yLm7kOW7aaA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07498196|-1;BR=01201311R951S11rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00134703-0.0012179-0.997435;FP=16287160341114814124|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jDz.htu_1789454266;
Received: from localhost.localdomain(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jDz.htu_1789454266 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 14:37:47 +0800
From: chunyuzhiqiang <chunyuzhiqiang@yinhe.ht>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH] can: flexcan: fix synchronous external abort in flexcan_get_berr_counter()
Date: Tue, 15 Sep 2026 14:35:11 +0800
Message-ID: <20260915063511.3010642-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

When the FlexCAN interface is down, can_fill_info() still calls
flexcan_get_berr_counter() to fill the error counters for a netlink
dump. This function calls pm_runtime_resume_and_get(), which only
enables the clocks via flexcan_runtime_resume(), but does not clear
the MCR[MDIS] bit. Since the interface has never been opened, the
FlexCAN module is still disabled (MDIS=1) from register_flexcandev().
Accessing the ECR register then triggers a synchronous external abort.

This can be reproduced on an i.MX8QXP board by simply running
`ip link show` without ever bringing the CAN interface up:

    Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT SMP
    pc : flexcan_read_le+0x0/0x18
    lr : flexcan_get_berr_counter+0x4c/0x8c
    Call trace:
     flexcan_read_le+0x0/0x18
     can_fill_info+0x1f8/0x434
     rtnl_fill_ifinfo+0x8fc/0xbb4
     rtnl_dump_ifinfo+0x364/0x448
     ...

ftrace shows the exact path:

  can_fill_info() {
    flexcan_get_berr_counter() {
      __pm_runtime_resume() {
        rpm_resume()
          rpm_callback()
            __rpm_callback()
              pm_generic_runtime_resume()
                flexcan_runtime_resume()
                  flexcan_clks_enable() {
                    clk_prepare(); clk_enable();
                    ...
                  }
      }
      do_mem_abort() {
        do_sea()
        ...
      }
    }
  }

Fix this by returning early if the interface is not running.

Tested on i.MX8QXP: after the patch, `ip link show` no longer triggers
the abort.

Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 drivers/net/can/flexcan/flexcan-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 06d5d35fc..b08779ee2 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -765,6 +765,9 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!netif_running(dev))
+		return 0;
+
 	err = pm_runtime_resume_and_get(priv->dev);
 	if (err < 0)
 		return err;
-- 
2.47.3

