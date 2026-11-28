Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795844906;
	b=KIN7hc4cARhSN4++0PnRfrYc/30STUgqbeBOvGMxAzBfa48htAoB7e4PN7FJuQ+8UUhg
	 CO39ltaQVLcBC2VYCmuVwx0Ac0t/wczkCg4f/CwpW3Zdr+yn1fY/0rQKoUF/SDWHYbkJj
	 PD9y08ENN4mWItuisM7+onVQsJryaJoT7IykqGvCrR/wDdRqniq4nq8qropG/jaHrjRcN
	 yAEmkoLo4B9c73eYGDzNbIH3zIRQhfTdX8DydRo5WGC5eGfebUhzekaPBNwyS2ABUvuR+
	 abESufdxglerwflnoegonqn22AgghQYiYURNnd65dWjX/WX+sui4fJyBsp8wQm0kSPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795844906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
	b=cXNPeVEprdzt6S85+SlS9R4kTd2XnH3vXXK2O8e0AJ8JKWoKNkDjpPsCbAoTYKVQP1TP
	 mqZ1ys9i0ChiNMtwU2lgrMvgtAyfTXihraX0HKidqY3wDriYWipTaHm4C4eNk0bHs0bYG
	 MVPUBSL01hLvK3V8cXyWk+3xso3A35QhOzeVOPGtAzoI9/wWAxgYnny3TobsivV4kNfFT
	 5ui+m9vhazYIOZVcvEQAFAO+jK61p1rOFwC0xngjhjT85pXN2YHfDt8SVOJi9aZc60A0P
	 nbqZPbhEWBj8VzHBHv2/5d7bS9sp3qxSQ+YHwQlY1jZjxf+gY83UzjjghzlArvyEfbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqU8DS0S;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D17A606A31F
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 05:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D17A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqU8DS0S
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ccca948203aso6006643a12.3
        for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 21:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795844905; x=1796449705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
        b=KqU8DS0S4DZvJyh8dSHw3tuF0854WLWZ48rhGH9X2melzvusLZSvJjqZwIOq6hfqoB
         UgwS9RP/Roik9xZWkodaJYrJjl68AU7CGgiimVasmSZ57H39quCjhyIZzAXs08utSIQ3
         aTBLW6o7RQMhPhHQkdHjeps6xwVxmYzujj/xkDdOnHBSU77uv29pQl8yF8hsCQO7m1WW
         QBPHq36ImPTZbMVMynu/bOCSRdYOeQxC9L6xUdWInrewf4KCcBO6gGjqJM35sYZC6qJE
         Plg55KLmw5C7Irflyz5Vvw+JFt+Lmze1+GKIU69NDfI84KQWmU0o0HbYGvK4FtwWdG+n
         lqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795844905; x=1796449705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XfJznNp2/IANpIblGifYLm4G1OI7fa8TLw1ASBwm1k=;
        b=RBQFFraIdzKf0VV5SpWWFfLG0TmoIpU+/cHOvlBH9INPjZAFq6hQ7Fff+ftyVqzSOt
         UqkCo5Gnr0jwX/DeDLTVMtxbzhYMnm25AKctP9Eg7qHCJqPhyRtsmYr1SacBd5n53FvT
         D5QrOAHTaQFbyHeA8DcW/DVqBIPhEoOqItcwuSVYwjAq1XixSj466b1iJsHbu3+S8vFH
         ECucuYgTV+ySqb6b9bygh892w/7TUeqZYdnHXem2oHNOb4X0gd/IkieK0rQjuHqRze5H
         jkP1ismq8NC19zmniJ4wvw2TEo8MIkmAYb0sqdBnmdpnPRYDlrRFUGpcVasYZ4DHdB7d
         1gRQ==
X-Forwarded-Encrypted: i=1; AL+hErGsV+PP+a3snqtMDZ7RNeGYJb01T6yPBxaJdqJVYtyXK+mG8xa3NJqw/8MszenTfZGyhaZoK6OHtzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ohT1Hk9jLiCSCEo9APu8surcbww/lQxD+b1zVJ6YJM9vV72hg
	dBIOMvavudBrETOnCiX1x+1zTFAENut0SbE6ugICxhf/VE2ZQ0/9oWJui1vhswQ=
X-Gm-Gg: AZFdTZeuWl9/GqvnauPfm2KSJIScAizQeLJDSBu3ZwZHcGxKeVwl7Troy7NjbCAuSTN
	0//FL2FhukZ/zYXivzYY+SFgr+8r6A8dKUpfnhf1Afxm/GMnHmTYGmQnBTlIcTADsvoOD9cMhlH
	/1OvVkx/PTFcBygiGNyHnpoTyZG7aWRaHbYoSfs3CsWmchK3iF1edB9L+7xsOmxzw5T6yjPh5P9
	juaZN/yGzI8fRDfdOt/o/RFbhr9/F+eJTtukfoP+S1z7junY/Y6hdwTyNw7KwXHyTTjnyj1YF+k
	JiCN1invv9fb5kUMY0bSVO+c285Lkl41RVqB1VvHRHvIu+f4J2NR0TXQymbHrDwonA/cdiUH5pD
	Qk8/dsS7BALoVsq59z5P3D4OtLgQ3Wt4vbGkAhrRdnxyNyv4wo14N9Sas8ycXlRN9OjXM2Dqjv8
	f5Y0ZI8WRcv786ULbfIQwojSrGRMhxq+A2Mbbpi0JRTgRZPIMf+eQUPV4CXmhwI4PaPfmlYSn8R
	QL/g/Sv4zoetIotnKQwmXd9+6n2inYmurMy7OSPK+gLzvVVSG+cmnzg73Jjp6vUocaUKspwg6bD
	UKAprMviX0a4P4mNGv5turigmO2x+uJsQeZ4fj4D
X-Received: by 2002:a17:90b:3d92:b0:3b3:a74d:f848 with SMTP id 98e67ed59e1d1-3b41c8e1711mr21086372a91.15.1795844905354;
        Fri, 27 Nov 2026 21:48:25 -0800 (PST)
Received: from CONGTHANH ([2405:4802:703:8c30:8c8c:8484:8444:c4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42979423a91.1.2026.11.27.21.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 21:48:24 -0800 (PST)
From: Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-kernel@vger.kernel.org,
	Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] can: mcp251x: deliver the TX echo before RX frames of the same pass
Date: Sat, 28 Nov 2026 12:48:15 +0700
Message-ID: <20261128054815.1586-1-congthanh.ml.2509@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcp251x_can_ist() hands the frames of both receive buffers to the stack
first and returns the echo of a completed transmission only at the end
of the pass. When our frame has completed and the peer's reply is
already in a receive buffer, the reply reaches the stack before the echo
of the frame it answers. The handler returned the echo first until
commit bf66f3736a94 ("can: mcp251x: Move to threaded interrupts instead
of workqueues.") moved the receive buffers to the front of the loop.

Since commit 4b7fe92c0690 ("can: isotp: add local echo tx processing for
consecutive frames") can-isotp enters ISOTP_WAIT_FC only on the echo of
the last consecutive frame of a block, and isotp_rcv_fc() ignores a flow
control frame that arrives while the sender is still in ISOTP_SENDING.
With a non-zero block size and a peer that answers quickly, the transfer
stalls:

  bus                  mcp251x_can_ist()         can-isotp
  CF 8 sent (TXIF)
  FC in RXB0 (RX0IF)
                       read CANINTF
                       RX0: FC to the stack  ->  SENDING, FC ignored
                       TX: echo to the stack ->  WAIT_FC
                                                 FC timeout after 1 s

Seen with an MCP2515 (SPI at 1 MHz, CAN at 500 kbit/s) on an RK3566
board talking to an STM32 bootloader that answers each block of
consecutive frames with a flow control frame (BS 8, STmin 5 ms). In
candump on the gateway the flow control frame came 0.27 ms before the
echo and the UDS download timed out. With this change, in the gateway's
candump captures of 25 downloads, all 5225 flow control frames sent
after a full block came after the echo of the frame they answer.

Return the echo whenever TXIF has been seen, before the receive buffers
that follow: at the start of the pass, and again after the CANINTF
re-read that follows RXB0, before RXB1. In the second case the frame in
RXB0 was there before our frame completed and still goes first, while a
reply that rolled over into RXB1 now comes after the echo. The MCP251x
has no RX timestamps, so the bus order of a completed transmission and
a frame received around the same time is unknown either way. A reply
can only come after our frame; the cost is that an unrelated frame
received just before it may now be delivered after the echo. The TX
block at the end of the pass only wakes the queue.

As a side effect, the echo of a completed frame is now also returned
when the pass ends in bus-off with restart-ms 0, where the loop used to
break out before the TX block.

Fixes: bf66f3736a94 ("can: mcp251x: Move to threaded interrupts instead of workqueues.")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Cong Thanh <congthanh.ml.2509@gmail.com>
---
Tested on the board above with its 6.1.57 based vendor kernel, whose
mcp251x_can_ist() is the same as in v7.4-rc4, by loading the driver
with this patch applied as a module:

- 25 UDS downloads (105 TransferData requests each) to the STM32
  bootloader, all confirmed. In 20 of them, test-only counters in the
  IRQ handler saw 185 passes where TXIF and an RX flag were set in the
  same first CANINTF read, the window this patch is about.
- 30000 frames from cangen while the ECU sent its own frames:
  tx_packets and tx_bytes grew by exactly 30000 and 240000, and 44 of
  the echoes were returned by the call after the CANINTF re-read.

The RXB1 case itself (TXIF and RX1IF only in the re-read) did not occur
on this two-node bench; it comes from reading the code and the RX
rollover of the MCP2515. The bus-off path with restart-ms 0 was not
exercised. Build-tested on linux-can/main (ARCH=i386, W=1); I have not
run it on a mainline kernel. The candump logs are available if useful.

Tools: the failure showed up on my RK3566/STM32 bench, and the tests
above ran there. Claude (Anthropic) helped analyse mcp251x and can-isotp
and drafted the change and this message; an independent review with
Codex (OpenAI) found the RXB1 case, which this version handles. I have
gone through every line, checked each claim against the logs, and am
responsible for the patch.

 drivers/net/can/spi/mcp251x.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0d0190ae09..0acdab0cd0 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1067,6 +1067,18 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 	mutex_unlock(&priv->mcp_lock);
 }
 
+static void mcp251x_tx_echo(struct mcp251x_priv *priv)
+{
+	struct net_device *net = priv->net;
+
+	if (!priv->tx_busy)
+		return;
+
+	net->stats.tx_packets++;
+	net->stats.tx_bytes += can_get_echo_skb(net, 0, NULL);
+	priv->tx_busy = false;
+}
+
 static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 {
 	struct mcp251x_priv *priv = dev_id;
@@ -1082,6 +1094,14 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 
 		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
 
+		/* Return the echo of a completed transmission before the
+		 * frames received in this pass. Without RX timestamps their
+		 * bus order is unknown, but a reply to our frame, such as an
+		 * ISO-TP flow control frame, can only follow it.
+		 */
+		if (intf & CANINTF_TX)
+			mcp251x_tx_echo(priv);
+
 		/* receive buffer 0 */
 		if (intf & CANINTF_RX0IF) {
 			mcp251x_hw_rx(spi, 0);
@@ -1105,6 +1125,12 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			}
 		}
 
+		/* Our frame may have completed while RXB0 was read, with the
+		 * reply rolled over into RXB1.
+		 */
+		if (intf & CANINTF_TX)
+			mcp251x_tx_echo(priv);
+
 		/* receive buffer 1 */
 		if (intf & CANINTF_RX1IF) {
 			mcp251x_hw_rx(spi, 1);
@@ -1196,15 +1222,9 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		if (intf == 0)
 			break;
 
-		if (intf & CANINTF_TX) {
-			if (priv->tx_busy) {
-				net->stats.tx_packets++;
-				net->stats.tx_bytes += can_get_echo_skb(net, 0,
-									NULL);
-				priv->tx_busy = false;
-			}
+		/* the echo has already been returned above */
+		if (intf & CANINTF_TX)
 			netif_wake_queue(net);
-		}
 	}
 	mutex_unlock(&priv->mcp_lock);
 	return IRQ_HANDLED;

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.34.1

