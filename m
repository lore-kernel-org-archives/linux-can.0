Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727155;
	b=ZoYHTElWkGuvXW+vyOIfE09Kf3xS9A605Q9Ig7sx1z9pUtY1eI9sHsfgGp21S5rwRw2A
	 Z8RdFzPIsi95cKb9K27n28kQL7Jed7ABEhyC/03aA4faFJ90CVIFB9dkDAaj8wzm1C5xf
	 M/P0Yv3Lr7XEhJh7iByWulKqRhGVukEF/6fNW9e3fE3ImCLWBnrYnXzdNgRNYMaaNNBkF
	 M32sWtoQgq37DE7csX/ZaCme91UvBp/gmbilU4VPJPjsUG3irbIpqNPl7mhjw5An4Onm/
	 dTFZtn/hKn3Tp9U++hPn81MtOpSvYS78W9Zg58rB5WirYREqJ3Qg5hVriVrwuYwXEPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727155;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/SM4CLKaRgD7Ga2fgdILnj3b0zeFKwYTiaIPO7MT7TA=;
	b=Ct6CvXs7W2SgodA4MIel/bM46kSk6Ih1++bBYpd+WoJiOj2EPTE2iu9AQ+aNkW7EL4qK
	 6lZr9/e19Bh4dII1+96Xcyk12yj+5/nGuoZjeRBml4rrveXYYwu73vgxn9oZFOtyUvBCM
	 JuHXi/X8HZpIEOneXzhvdREor7pqJRon1mmVg9K1uW6NxjwcoMGJbOoUzCyhLeu16q8Wh
	 0US8oE0F3gezYhuRK9AdMoWHUUkJptMAT8lh959H4HoE/NS9QvoEBdXmCE8y7Mt70guY5
	 vJlMy2lhJFHEaOboM7oe6kBDjfNKUuC4HF1hIGX6XhRrmBuyvnRwtLrefX4ZBq4sz7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LzoSJseJ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SiDwMjyk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96516606A321
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96516606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LzoSJseJ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=SiDwMjyk
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OlUcBKeoFHcxhRsbVxDaQs9qa5uzmBGvzk9bgD8hgIvPgIHKp1qkeK6YS39Seufced
    nuAfIMtpp3970q3ZPF2sCOC4RVkNTMnZWmFDgO0rYyyCJ7rFUiH07jBcHRYHNmG0Qnqm
    4bxOcoCxBXAgJI8o5iSu03eVkiSOFflA8dVCf2OO6/Guu/rR02g8515VhgcHSnPEPFm+
    cMyTkTk2ErZQ90ETZGbB73Une/nrb5LeKN2qm5hugD4ll4OC8PBzVWPFnVyenABCp4uW
    9G41iEghhBv3UnZiwUZrJovCD9tO1M/88pqWP1/WuMbBJzMwaC5yw63s96Cj1APWvk01
    THzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/SM4CLKaRgD7Ga2fgdILnj3b0zeFKwYTiaIPO7MT7TA=;
    b=bYBv+Mm9axsgc/7CKtSNr4/pjWL6nCWymIcrcQCEeVTgp1yrbVcvuidtOTd8DH/6mY
    c1aACY9NNMpy+O+pSjRnk6hj4lBQ1ble9NE03SghXE4lZXiuoupt65dX/dxUZX4E1EoP
    pnwUV2PopDQlidCFxrPGXw08wKc+bxM9kCIEje+k53KvoM66SeEx3SC/xsHeu1wTNKAB
    fF3RhZsrKMk2EgWoRAHvfb396w0+/rCDfkjp+Y+YbdJJ3Y6JVO3UiFJZn94HVKec2wlT
    Ed1+C5pAIBcq+EMhBNMMX1iG/ioE8t23vB3aizVAbyP/r83AWzQILy6VE/lwl/X00sty
    IPPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/SM4CLKaRgD7Ga2fgdILnj3b0zeFKwYTiaIPO7MT7TA=;
    b=LzoSJseJV2P85Sa2gupT7Ni5mMh9KOFGQzaNqQ+P4sMgOD1FZZS9PNJwKOBQlaAS3w
    rSm/Zn92hRKQPR+UGkvHKWOQ1rv+YjihH+nw3z9oQ3wXIzqaV6qC/qAKJYlUaaTXnSYv
    +F4lwHjhdi44fk7ycVsw+HP5PQxpdWYfDZT8cjQ+1dq2Bb8CZfoLIEYnfHgpMC2nzjAX
    pRUYIUMTchKmsjFr2+0W/iOPoWhmz3m8E/ufRrNS0JTScFrOsflM24wo2kHudW4pb+pV
    FzCJj48xi1tgvn+VX+pBp1OJnmXDblUilbrUVS0iWbwKnKn8IJiB9q+tgdaYCKRukQW2
    h33A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/SM4CLKaRgD7Ga2fgdILnj3b0zeFKwYTiaIPO7MT7TA=;
    b=SiDwMjyk6MpTLYOs8V0mRJL5Mrdvri7iAfyzr7RHKhjMK+8IpvAgZx86Ws9SXfCvHR
    j5Hm9lLfP4TB2i2Q7PDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:57 +0100
Subject: [PATCH can-next 15/22] can: isotp: drop inline keyword, let the
 compiler decide
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-15-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=851;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=bfquFp6pJ3eafLhGCqhZGQQ98rlKGFQFZY4dLSi7WaY=;
 b=Uy0eIbfK+Pd01FIw1CJUO42hZSKB5QHAcuqBqCHMIlU4+sJRfg1rD5g87HX0AU2UrBlSqwAfc
 bFiMqgEfADyCwOaNgYJiwvbk/6wSzYhS9qIS3EYpPJuYFTBiN7wIyJj
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Modern kernel style avoids forcing inlining via the inline keyword on
static functions - the compiler heuristics decide better on their own.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 39bae46701cc..fc03dedb0c86 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -247,11 +247,11 @@ static bool isotp_tx_gen_done(struct isotp_sock *so, u32 gen)
 
 	return state == ISOTP_IDLE || state == ISOTP_SHUTDOWN ||
 	       READ_ONCE(so->tx_gen) != gen;
 }
 
-static inline struct isotp_sock *isotp_sk(const struct sock *sk)
+static struct isotp_sock *isotp_sk(const struct sock *sk)
 {
 	return (struct isotp_sock *)sk;
 }
 
 static u32 isotp_bc_flags(struct isotp_sock *so)

-- 
2.53.0

