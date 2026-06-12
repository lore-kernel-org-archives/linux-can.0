Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8C383C80
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262356; cv=pass; b=ohZVWZeWg5EclcFa5fIFVa1wsBo4TLQsltH38DmP9y4m6e88xQLysCYhYcU/ghy5+vi1Fvoiposu7DH+BTQlNIw1qXuHVq5EAJNNGgmxB91Z4yzSz4MxUExKBPkFH16S/YmT/8b/ovUjGgRJtL9el8RW8rPbCPEXIMHWj+y7IB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262356; c=relaxed/simple;
	bh=7dBPRmJHD70ExLZ/QawwPDORg+F/dMxIbdGRHIrcX60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rvu3UbPZtYlQ8ss2o3DCr1cMqjt81ZFhBIHRYzCbU3L59HwJDYftAGTLZDHeiMnkHInlRfomA97gFHMMzDfrSutovt09L+Phni9WDKnPbMAnocVmjSv5lOmGsIfh/44u+3f1fQKnif9RLzn3FTdMHfmWiga1jKp/1uOYO8AHCNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=m/OjBgNo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UCRunLVY; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m/OjBgNo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UCRunLVY"
ARC-Seal: i=1; a=rsa-sha256; t=1781262336; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p9+gQ/TtMAFCxUmnbaun35o98Xhwt7ELBve0rXRPfeCdhGtJkQBAzapC6G+f5d7Lc7
    pqI/zMkF3TzrqrQ6D4IQjYwcEuVUhtpQqX0Qje0PVtTSKwm+W2Dzr9M+4+8b/tOmb1B9
    tpg23wFCIUjK6T98Erlg2AwxGP4hlCWmQojuWai9hrN9x/2YavPWYGm9dz6EWZBnSFlk
    mauuEPC43sRYi4rv4eYcaFpZROwKTdFLDYhsq/wvuFBwDzyEZV5Khw4epxRkRKdrxROZ
    j4C9pruEY6JckPgDw8hAfdymyhs9JfKzYEy5HCXgfETfhXwrqS16oBeNun/hRSjOBUfg
    kSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6neNXR8xm7ncffBaG25ASz0ainnuma2yw0qsll/6PaI=;
    b=HKeLthTzv9B+mAcxSWZmL92RK5D17U0tQRlKm266QeuFliYw4eXHkomgZqADNS04dU
    shH6p7KiGZAYtxi0GxqGOHbdX6tuH3sBakYfTvo7rlatpLFCJGPbiSNcaqIlCfrSoRuB
    yhwMjMIneSbl+QgOi+cGqyknrE2k5sA3efT0dei3TClgKAt9+U35qzpf+4Iy3hWOYWMN
    jRHGQTo8aH33wpeW5AnXevCJGGA5/VGBYtatpQOTsFvq6kJq3IgQV7mv0MPI6Tjv8mmN
    xx7nAVCTZJjbvlkLzcCp9tTo1eYF6h03xzAL12QTDPRcWbPUYV4JbeAc8zE3nO0z8VvN
    zCZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6neNXR8xm7ncffBaG25ASz0ainnuma2yw0qsll/6PaI=;
    b=m/OjBgNo8DrYwcqfU37Z1zOv3IxjT45ulqcK/QqfcMO6zZTXhpg6n3mDrd6J/VD8Cw
    g6qJVIRqKSxT3liTRdDRrWtganUgXYyFi10L0j0Np/QPOQGyWkRxRmVFQ4OaKOpBQrdm
    hBzp66Tk/ZIF34poUqhQehS6amkSr3Il8pUbXEcRsBUnd2dvNFxOnRABl8NhdhgYbbR/
    vLpBzY+zf9GNv/9HgTB4ukaGsnYQc/xFOK20ZbMcEXbZ88SFjDw4Aa1+IxQm3WNvwj1K
    pP75uGpTjRtEUKxQNBP9dbxRU7wjyPF/0yixrqEk+2W0p0MVUhI1f7PCt7cYgPdueEJA
    rCTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262336;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6neNXR8xm7ncffBaG25ASz0ainnuma2yw0qsll/6PaI=;
    b=UCRunLVYZ0WZcbu8arv8QVwkxup6TYxYMa3StTT6n2Kqim0l1KTNOhk4SHxi23GaU2
    1e70DNHhJqnTD8240EDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5a8w6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/5] can: bcm: collected fixes
Date: Fri, 12 Jun 2026 13:05:15 +0200
Message-Id: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOvnK2oC/yXM7QpAMBTG8VvR+WzFSLgVSduccZSXdpDS7t3w8
 dfz77mB0REy1NENDk9iWpeANI7AjGoZUFAfDDKRRVKkUmgzd5YuZFHmVudKVZkyEkK/OfyGkDf
 tbz70hGZ/D8D7B8LvMDVtAAAA
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=1060;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=7dBPRmJHD70ExLZ/QawwPDORg+F/dMxIbdGRHIrcX60=;
 b=lPL6SflWVmeqSGaBsMh0IGNqCehMgLwk1XzStuy+uC3Ur8AFdQh6QXnGR4X7aCKL14qIjG2nQ
 kqBpjlU4xGaBJbjm6iYMrJ8PXcT9ETrWwaTK5PT+jl0ZtJD1TfZ46eb
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Hi Marc,

as there were different patches flying arround to fix CAN_BCM issues and
AI assisted stuff pop's up again and again, I've created this collection
to be applied.

I'm not sure whether sashiko-bot takes the sequence of this series into
account when checking the last patches. So let's see.

Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Oliver Hartkopp (4):
      can: bcm: mark intentional lockless read of bo->bound for KCSAN
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()

 net/can/bcm.c | 150 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 115 insertions(+), 35 deletions(-)
---
base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>

