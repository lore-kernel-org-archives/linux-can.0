Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D030DECE;
	Mon,  5 Oct 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196863; cv=pass; b=dyz7rTcC3LuWQFPjS/LC64pFwl5X+pNlLn9WaL4o4ebDTKvMNnDQWNEpoSMkHbuZkHw/fM+9TjD2rjjIxCB5fPYSJucDuyOIdVnYDFy5wBSoIlDuH4mWMqEv1BBmnlv55usS/1rciXZ8CsM82agoUiRYJgcdnrfL+MyKKZ8SGp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196863; c=relaxed/simple;
	bh=AaPYvcnmHsXsrQYz9XSnRsL/EZmnFPH0+bjLdEf85lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fl8i8wJyX4encUWXVJBYRTNFh/v7MX7PmR2RiMMDlc/mSXgNK/eRxmUh3Upy9Cja/vfe/gXLLsLeOSdx0utEPGqAwm5Tpkh2g6UReTtLllNLREATMygDPZYQ/bA7/5ulGGEee3xOSOR/RsZqkkztz3yNVBifcD1nZXZ4eXhmBP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=caoru/sr; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="caoru/sr"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C8629201F18;
	Mon, 05 Oct 2026 12:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5CZDuz2pyBqIGUhoJ37VBuG/lI1kIoFkCK3bvisMwE=;
	b=caoru/srkHodsBOydRj5pJ6+GXAP292K6rJ/Hf64Wv496j1LMpb5xeAoRLyEiUsA85ZqHk
	kcPu7EcRrwVZCaH9mLVOehGAVSlEy2id2PLleZxSOZKfq/OiEx0yMhHJqZHDpap8kvS/VT
	Rz1057TVT2ep97mb6EsT1/yqWgDNKIokN6Yg4bjdIXnMkWWtZr304s2S07gQpGbTCXvDel
	K5c/Yb67/aXRa68FIF11UBxCPe7IJz6QP+lEeMoHcQGW646Y9FDW5V/+WgMhHgh+cIKxgH
	dHCdXdtozcvS8mnzDxGdXBb7+ZdkBHJHjDfkqSeDRh7oXnTeJPnrjpnz0bGsug==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791196858; a=rsa-sha256;
	cv=none;
	b=KHGl+gqPELVfouzUgjovuejDsYfmdmS44H5eX36GffbbH5GvlwAkPPBmCex+lLn1QXej2K
	jfC+sKwA56zVurlilfB6/Bi4XjEiJ97PEJFIC4qj2hExspbcqrarSBlBLn3NO0ziGoasdC
	4omy3GSfxzZ1vfSV8e23h9mTsnwY0xWj7WIreqNnZGz/kVf2R6c6m7WQiLnWzJrgLPSF11
	dlBcvSl1h9vKIqOgBXn/kcaANNw67IODdkzfg7bwx5AdTbMUSrlG5H9SxYARg0M4+I3el0
	7T2keefpd8Cobyn7NpoUxQgvdqGBz+jCF93hiuUAodGQVKR7r5+dYYpnM82CNw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791196858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5CZDuz2pyBqIGUhoJ37VBuG/lI1kIoFkCK3bvisMwE=;
	b=a8vqcFxQVAF/U5vUi82P9wAzLhaZeOFTZT6ancbUCslZBRS1D5g8euTQ0Qk90hk3nYTdW3
	myIsTkbskkYor8QxK5KV/pWUgJKuuBzcU9G6dqaMRjunkNvjIlnMiL95xCu0Vvxn86Cm5N
	y3/q84NBAeGQEXTNNA9a9S2NWBFvKwajEETowmiUavt54rKNDN9kGIdS2fjpE59sOUelA8
	4eCVwC7Yu673NOinrGKSo5dMeGBzaEx9obpWRnVhpny0EPw7NWELzulgYXzvpg44qh7nVA
	OkefsCpREwIaTC+n68WxRw0taKtWE2/Fa/fT7FIRB5PBP25TUVInysAeisjH0A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDg7u-004Mx6-2K;
	Mon, 05 Oct 2026 12:40:58 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4F1195BA0DD;
	Mon, 05 Oct 2026 10:40:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 05 Oct 2026 12:40:24 +0200
Subject: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from
 within loop of threaded interrupt handlers
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-upstream-can-rx-offload-batching-alternative-v1-1-4c08ccb516ec@pengutronix.de>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
In-Reply-To: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6885; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=AaPYvcnmHsXsrQYz9XSnRsL/EZmnFPH0+bjLdEf85lQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6XLcl99oF1R8R3V/OXKy4Yx8TJLVGvn3Bw3LmrzP6H
 SSjl+3f21HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ/GtmZPj/TmZSrPoDVr4S
 LZHrDKLm924+rUlflRNy8ce61+9z4nkY/op0WvExCpxYss746jfZyQdjfYx33ljvrruLsd/5/zN
 WHiYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

CAN drivers that use threaded IRQ handlers usually have a while loop that
runs until all IRQs have been processed. In this loop, received CAN frames
are placed in the offload->skb_irq_queue.

At the end of the IRQ handler, the offload->skb_irq_queue is spliced into
the offload->skb_queue and NAPI is started, which then pushes the CAN
frames into the network stack.

Under certain load situations, the threaded IRQ handler will not exit the
while loop, resulting in an unlimited growth of the offload->skb_irq_queue.

In order to avoid this situation add a new function
can_rx_offload_threaded_irq_flush(). It's meant to be called from within
the threaded IRQ while loop.

Check in can_rx_offload_threaded_irq_flush() whether
offload->skb_irq_queue exceeds 1/2 of the maximum queue length
(can_rx_offload->skb_queue_len_max) and save the last element of the queue.
If the queue exceeds 3/4 of the maximum queue length, spliced up to the
previously saved element into offload->skb_queue and start NAPI.

Why is not the whole offload->skb_irq_queue flushed to NAPI?

Some CAN-IP cores use more than one FIFO or even independent mailboxes. In
situations where reception from the CAN bus and reading of the
FIFOs/mailboxes take place simultaneously, older CAN frames may be present
in the chip at the end of the current IRQ handler loop than in the
offload->skb_irq_queue.

As the order of the CAN frames is decisive for most CAN protocols, leave
about 1/4 of the maximum queue length in offload->skb_irq_queue so that
older CAN frames can be added to the queue at the correct position in the
next loop of the IRQ handler.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/rx-offload.c | 88 ++++++++++++++++++++++++++++++++++++++++
 include/linux/can/rx-offload.h   |  4 ++
 2 files changed, 92 insertions(+)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 46e7b6db4a1e..9f494ab7561e 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -338,6 +338,8 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue);
 	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
 
+	offload->flush_skb = NULL;
+
 	queue_len = skb_queue_len(&offload->skb_queue);
 	if (queue_len > offload->skb_queue_len_max / 8)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
@@ -349,6 +351,90 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
 
+/**
+ * __skb_cut_position - cut a skb list into two
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *	and if so we won't cut the list
+ * @qlen: length up to @entry in @head
+ *
+ * This helper moves the initial part of @head, up to and including
+ * @entry, from @head to @list. You should pass on @entry an element
+ * you know is on @head and @qlen being the position of that element
+ * on @head. @list should be an empty list or a list you do not care
+ * about losing its data.
+ *
+ */
+static inline void __skb_cut_position(struct sk_buff_head *list,
+				      struct sk_buff_head *head,
+				      struct sk_buff *entry,
+				      __u32 qlen)
+{
+	struct sk_buff *new_first = entry->next;
+	struct sk_buff *first = head->next;
+
+	WRITE_ONCE(list->next, first);
+	WRITE_ONCE(list->next->prev, (struct sk_buff *)list);
+	WRITE_ONCE(list->prev, entry);
+	WRITE_ONCE(entry->next, (struct sk_buff *)list);
+	list->qlen = qlen;
+
+	WRITE_ONCE(head->next, new_first);
+	WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
+	head->qlen -= qlen;
+}
+
+/**
+ * can_rx_offload_threaded_irq_flush() - partially flush the rx_offload queue
+ * @offload: pointer to rx_offload context
+ *
+ * If can_rx_offload->skb_irq_queue exceeds 3/4 of the maximal queue
+ * length (can_rx_offload->skb_queue_len_max) flush about 1/2 of the
+ * maximal queue length to NAPI.
+ *
+ * This function is intended to be called within the loop of threaded
+ * IRQ handlers, which run until all IRQs have been served.
+ *
+ */
+void can_rx_offload_threaded_irq_flush(struct can_rx_offload *offload)
+{
+	struct sk_buff_head tmp_queue;
+	unsigned long flags;
+	u32 irq_queue_len, queue_len;
+
+	irq_queue_len = skb_queue_len(&offload->skb_irq_queue);
+	if (irq_queue_len < offload->skb_queue_len_max / 2)
+		return;
+
+	if (!offload->flush_skb) {
+		offload->flush_skb = skb_peek_tail(&offload->skb_irq_queue);
+		offload->flush_len = irq_queue_len;
+	}
+
+	if (irq_queue_len < offload->skb_queue_len_max * 3 / 4)
+		return;
+
+	__skb_cut_position(&tmp_queue, &offload->skb_irq_queue,
+			   offload->flush_skb, offload->flush_len);
+
+	spin_lock_irqsave(&offload->skb_queue.lock, flags);
+	skb_queue_splice_tail_init(&tmp_queue, &offload->skb_queue);
+	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+	offload->flush_skb = NULL;
+
+	queue_len = skb_queue_len(&offload->skb_queue);
+	if (queue_len > offload->skb_queue_len_max / 8)
+		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
+			   __func__, queue_len);
+
+	local_bh_disable();
+	napi_schedule(&offload->napi);
+	local_bh_enable();
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_flush);
+
 static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
@@ -360,6 +446,8 @@ static int can_rx_offload_init_queue(struct net_device *dev,
 	offload->skb_queue_len_max *= 4;
 	skb_queue_head_init(&offload->skb_queue);
 	__skb_queue_head_init(&offload->skb_irq_queue);
+	offload->flush_skb = NULL;
+	offload->flush_len = 0;
 
 	netif_napi_add_weight(dev, &offload->napi, can_rx_offload_napi_poll,
 			      weight);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d29bb4521947..18dcced516a5 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,6 +23,9 @@ struct can_rx_offload {
 	struct sk_buff_head skb_irq_queue;
 	u32 skb_queue_len_max;
 
+	struct sk_buff *flush_skb;
+	u32 flush_len;
+
 	unsigned int mb_first;
 	unsigned int mb_last;
 
@@ -54,6 +57,7 @@ unsigned int can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offlo
 						    unsigned int *frame_len_ptr);
 void can_rx_offload_irq_finish(struct can_rx_offload *offload);
 void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload);
+void can_rx_offload_threaded_irq_flush(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 

-- 
2.53.0

