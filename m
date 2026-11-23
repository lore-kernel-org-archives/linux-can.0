Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444595;
	b=jI9gXnqKwq/VJ+54NW4u6nbbZhPe/QHSzRbOR/2eldv0N2SHK/LFLNDlmgoCjklxkRkv
	 h4zL0zS7V4jqE7eNIUAa21vm+iwjV9xGWpeYuP0rlFA2uHpYM0qnIY8eEUXiKx+i9RdeE
	 MYSGyxuU3qaaYVxK+z6CTkPx/ZtCoeshJxFke00n1E/Hfud589SJqba60vddd62iIk34z
	 guxgyY2U2lKv4WUpp5nyMakh6Lwl+8mVY5bQsVlezorcoIFJkfX7dt9GFGelkD2NqcrR3
	 xN9lpnyO7ydOOAo9LbB7njZiTUX52iXSa+syKy7flkCENQozthlpvy0TWRem5F+PmsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ehRimsJYB3Ch55Y8eVy07JQEbqg0JrRGoOw4sSOHi78=;
	b=dOD9bWZprtIMdscOup1WHtlEqsVU7bly7xipjZAd/MwNYD1U/ky6NB3YrVkiXR29CYX2
	 lmGXHNqUUuHbfoB5qkk9LAc/++o0ytHPiWntmxBkvd1/B923xfYu+ahzJIerBO/XkGyj8
	 Dm8IjDD02muGQv5id7+SMEoWfvLechrCndO7AkrBrqTofSBbWjg63lq8RMKptaFlq98QI
	 DeMuTPiUBJZFU4obnz4LfwGIRrGU3JHqncuKcHcWr1Qf0+6P+DGSL/SnOju1gufU1bb9P
	 cg7GRJWFwYdJUU4vd/mCj4iXMT66sQ7069HMO5hoonmJQ+fMjvl+r2kEGXpW+x4SwpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=AnccZPWW;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07012606A31A
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 14:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07012606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=AnccZPWW
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04bea9a93so28311185ad.3
        for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795444593; x=1796049393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ehRimsJYB3Ch55Y8eVy07JQEbqg0JrRGoOw4sSOHi78=;
        b=AnccZPWWxApE8C7F8ef8F1nyqmuie0g7OtihE5H0iGKBFsVGEZAv1U0L195NboFEG8
         nBggwRfvjhv39Myhzm9UjQvOLBbo6J1mCXRKDhYbxS+xrK6hiE6iaBNkLq1kgjU4Yy49
         SFEmfPFmXPENCyBbY5HsY9ddOzwthwbrruy6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795444593; x=1796049393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ehRimsJYB3Ch55Y8eVy07JQEbqg0JrRGoOw4sSOHi78=;
        b=gGEQHZTJ64J4PJN9T3Q0fkqWOJAGYpNO19Ang8o7hPiyofXExDYWRpzGAPbo71cY8y
         54Q7C/uyTzM8iz7FClgfyZzc+Lp9g2atcoxwmqg0XpP3N5eapTdvx6EnCRVUxE7MhnhW
         p5mOOhQjbXYyd+dIXX8No/cg3fYVX44IcHh4TmWt6/3kuUSLGd02JPAW2pUL79YHAVpR
         VqHVTUtSpS1JwV0go09DZDJGGayLZxGLOOJ113vqv7zI384hN8EFCRZo+f123j9k7iaz
         kpY9gcHFJ5RcHYQNfHe11KlZL10CYSTOWAG6OVOHgFMdQcnKpBS5vd5v2uafqnMX5M5U
         Q76g==
X-Forwarded-Encrypted: i=1; AL+hErGQZaaxGTc1O/3Vc4GDnTmHbLznIuVpmXfmhCaDe/IJGwpN+t6wkRSlaELrsCd+O8mtPBo2oNbRIOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HZaFVPVeg+44kIr0wJzU89lMibTHDKVartrgvdt8j58Jz2Uuy
	saHlP3J5t1YCamZb3k2qV7Cbp10hmXxN1j/8HE3WBdR8ivyNuvjfOcGH1hf5bB6cey04fN3nkQE
	FOAsEuBVy1g==
X-Gm-Gg: AZFdTZenB7DMQDE2AFdvnNh5wij+SxKZnGqpLZNJoEhUjioMoc7zZTD6K+wJm/9u1QZ
	M8yysz8Lk6jLJT7AsqF6tybbYDB4obiw4/wZGPOJ9TFuDcAFTK7MonVKFaumZN2w8M2xnKROg7g
	Hr1sKFecmpXjuTqq9lxmnFqbX1uobThboPwdw/7J6sNjebsxKe78Q3R1ClXSNtc1Jf6jqpsxGLb
	LXn6pGwfPAiTaTIZxLiNvpBSBxphjGobcIidtyUsPVHDoShA6rjMnVSVCRoH5F57DaqZZNdsQ81
	LECCqq1Y6hkz8cq+xekzDF3gpwTUNLLnhlfGIukngZ5+UodrW8EeItBPkPsLN5alwRy+eWj//xT
	HmbGQhzWeczvfNhEoj8N/6KDVnxoK/lcgnRzxUpqS1wMjtku1wr+R5x9Wdy7n1JYPxOmh+4UHAt
	++9plRX+H5ROe941kn7/+APYYraC3tflarDlhAixYRdAAUOzb6MUpgX6c5zdPpbL+dcpEO1GjZO
	UOLiwVEeBucMdhiyQBZIAaffq51wJrNdYHOWDSSj4OLp+TFVF9u5sZQNIlzmPRLKFcUUGv2Mrhj
	0SVIj5lpGHMXFRpgXlezwsqET5OPJrdN7L8lGM4F6pJUIqHsCsQEJfENhOpU6OadXDwKf3QfJqj
	HuT2CRyqtOhxu5zsgJjq5GNoZ3vw7PXaUeZS9TYaD+EQ7b0QpVp644DFMAjI/V+RW/w==
X-Received: by 2002:a17:902:e847:b0:2ef:cf8a:622f with SMTP id d9443c01a7336-2f03f1cf5d7mr114757805ad.17.1795444593265;
        Mon, 23 Nov 2026 06:36:33 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee85466sm54062085ad.4.2026.11.23.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:36:32 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>
Subject: [BUG] can: j1939: NULL dereference when a peer completes a session with no data queued
Date: Mon, 23 Nov 2026 20:06:24 +0530
Message-Id: <20261123143625.4021586-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
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

Hello,

j1939_session_completed() passes the session's skb to the socket layer
without checking that there is one.  A peer that completes a transport
session whose data packets never arrived makes j1939_sk_recv_one()
dereference NULL.

Reproduced on net.git main at af6737b90668 ("net: af_key: fix use-after-free
in dump_sp()"), 7.4.0-rc3-01164, with KASAN.  A patch follows in this thread.


1. Root cause

net/can/j1939/transport.c, j1939_session_completed():

	if (!session->transmission) {
		se_skb = j1939_session_skb_get(session);
		/* distribute among j1939 receivers */
		j1939_sk_recv(session->priv, se_skb);
		consume_skb(se_skb);
	}

j1939_session_skb_get() resolves the session's current offset through
j1939_session_skb_get_by_offset(), which returns NULL when no queued skb
covers it:

	struct sk_buff *skb = NULL;
	...
	if (!skb)
		netdev_dbg(...);
	return skb;

j1939_sk_recv() then walks the bound sockets and j1939_sk_recv_one()
dereferences the skb on its first statement:

	static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
	{
		const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
		...
		if (oskb->sk == &jsk->sk)

sk_buff::sk is at offset 0x18 on x86_64, which is the faulting address in
the report below.  consume_skb() tolerates NULL, so the dereference is the
only fault on this path.

The same getter is checked by both of its other callers in this file -
j1939_session_tx_dat() returns -ENOBUFS, and j1939_xtp_rx_dat_one() warns and
cancels the session - so this looks like an omission rather than an
invariant.


2. How a peer reaches it

By sending an End Of Message Acknowledgement for a session with nothing
queued, so that the session is completed before any data packet arrives:

  j1939_can_recv()            net/can/j1939/main.c:108
    j1939_tp_recv()           net/can/j1939/transport.c:2201
      j1939_tp_cmd_recv()     net/can/j1939/transport.c:2153
        j1939_xtp_rx_eoma()   net/can/j1939/transport.c:1439
          j1939_xtp_rx_eoma_one()       :1424
            j1939_session_completed()   :1247

Everything on that path is driven by received CAN frames, so on a shared bus
this is reachable by any node; locally it needs only the ability to send on a
CAN interface (the reproducer uses vcan).


3. KASAN report

net.git main, 7.4.0-rc3-01164-gaf6737b90668, KASAN (full log attached as
kasan-j1939-null-session-skb-mainline-7.4-rc3.txt):

  BUG: KASAN: null-ptr-deref in j1939_sk_recv+0xd4/0x3c0
  Read of size 8 at addr 0000000000000018 by task x/9440
   j1939_sk_recv
   j1939_xtp_rx_eoma
   j1939_tp_recv
   j1939_can_recv

j1939_sk_recv_one() and j1939_session_completed() are inlined in that build.
On 7.3.1, where net/ is built without inlining, the same reproducer names
every frame separately (kasan-j1939-null-session-skb-7.3.1.txt):

  BUG: KASAN: null-ptr-deref in j1939_sk_recv_one+0x34/0x170
          net/can/j1939/socket.c:318
   j1939_sk_recv_one          net/can/j1939/socket.c:318
   j1939_sk_recv              net/can/j1939/socket.c:363
   j1939_session_completed    net/can/j1939/transport.c:1247
   j1939_xtp_rx_eoma_one      net/can/j1939/transport.c:1424


4. Impact

A NULL dereference in softirq context, from the CAN receive path: an oops
that kills the receiving context and, with panic_on_oops, the machine.  It is
a denial of service, not a corruption - address 0x18 is not mappable on any
supported configuration.

net/can/j1939/socket.c and transport.c are byte-identical between 7.3.1 and
af6737b90668, so nothing in between changes this path.


5. Reproducer

j1939_eoma_null_session_skb.c in this directory (sent off-list on request;
see the note at the end).  It brings up vcan, binds a J1939 socket, and
sends the connection-management frames that complete a session with no data.
It faults within a second on both trees.  CONFIG_CAN, CONFIG_CAN_J1939,
CONFIG_CAN_VCAN and KASAN are required.


6. Suggested fix

Test the skb before using it, in the shape the file's other callers already
use:

	+		if (se_skb) {
			/* distribute among j1939 receivers */
	-		j1939_sk_recv(session->priv, se_skb);
	-		consume_skb(se_skb);
	+			j1939_sk_recv(session->priv, se_skb);
	+			consume_skb(se_skb);
	+		}

Deliberately without a netdev_warn(): a session completed with no data
queued is the peer's protocol error, not a kernel one, and a warning on this
path would let a peer flood the log.

Cancelling the session rather than dropping the completion may be the more
correct protocol response.  We left that alone so the patch stays a fix for
the dereference; say the word if you would rather have the session cancelled.

The patch follows in this thread.  Checkpatch is clean.


7. What was and was not checked

Checked: the fault reproduces on net.git main under KASAN; the patched kernel
is clean on the same reproducer; ordinary J1939 transport sessions (a
multi-packet transfer over vcan, RTS/CTS/DT/EOMA) still complete and deliver
with the patch applied; both j1939 files are byte-identical between 7.3.1 and
af6737b90668.

Not checked: real CAN hardware - all of this is vcan under QEMU.  We have not
tried this from a second node on a physical bus.

This was found by AI-driven fuzzing built on top of syzkaller; its analysis
was then checked by hand against the code and every claim above was
reproduced.

Kapil Vaswani
Piyus Kedia
