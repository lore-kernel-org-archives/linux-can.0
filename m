Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC2313532;
	Mon, 23 Feb 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864248; cv=none; b=QACQVbUKu5hLDwvgxYsZpcmbkr/Oh70e50tCad0+Hk0RgHC8Ez7Z2C0iw3UCaNFokLuPmq/3YfPlXgt4FVpta7K3Dn5MSw5/HTts44OvTo8ArTmdXw/KeQrV5yGwW1FpiKzox9R40ac6AY+1JZmUQ2xcR7xif5msR3LCArJ/IFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864248; c=relaxed/simple;
	bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRd6ltWsK5D8OH/wlHvX2qdM9wCoaDofpOEOfU5ODoLA+hdSBltopIZgK+cqYrl59omBqyZfT3+88OLrNYa1OUZOJU7F+q4A2BD+E4o4bpVg6xnJqScYYigf7JcTeE0hZs5jRUZ73OysiSX0IzMFz3Jj85CofdSuEAZlLH6eHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cebHZYAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cebHZYAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215CFC116D0;
	Mon, 23 Feb 2026 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771864247;
	bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=;
	h=From:To:Cc:Subject:Date:From;
	b=cebHZYAjqWSzJDNxuqSLSxXLLAWduiHycjidHW8CFOOQQ5Wula8ey3LLh1oG7HCVG
	 +kCznhhB1p6zQ/VZgZUUhiOdHHy6NiUJkoXEcWHjelM5U2ehIqXVFup3JgnL/f8HKK
	 FxDfBH9jrMcBjXhCSU01mLQWvWYeV4nVz8rqPszc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH] can: ucan: Fix infinite loop from zero-length messages
Date: Mon, 23 Feb 2026 17:30:20 +0100
Message-ID: <2026022319-huff-absurd-6a18@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzGmbP7fRdKzPz8juuxacqZjRqXDhvxcjXkbHqxL3MC s7zvmtyO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi378zzBW+YPYg8bDCWXN+ xcCu3yIyxYuXmDHMjzu66LvxnJnXlp9yO6rAuSdbM0WxBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

If a broken ucan device gets a message with the message length field set
to 0, then the driver will loop for forever in
ucan_read_bulk_callback(), hanging the system.  If the length is 0, just
skip the message and go on to the next one.

This has been fixed in the kvaser_usb driver in the past in commit
0c73772cd2b8 ("can: kvaser_usb: leaf: Fix potential infinite loop in
command parsers"), so there must be some broken devices out there like
this somewhere.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index c79508b1c43e..0ea0ac75e42f 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -748,7 +748,7 @@ static void ucan_read_bulk_callback(struct urb *urb)
 		len = le16_to_cpu(m->len);
 
 		/* check sanity (length of content) */
-		if (urb->actual_length - pos < len) {
+		if ((len == 0) || (urb->actual_length - pos < len)) {
 			netdev_warn(up->netdev,
 				    "invalid message (short; no data; l:%d)\n",
 				    urb->actual_length);
-- 
2.53.0

