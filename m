Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=SRequVcbQh8Ub0XxmYJ9Oy/eUp7fjIAqfeUjygrGKlEkbyxJgkpOIiTAoNU/FUYa/F/S
	 slYBEqb32C1tR/2C0tpZfiLfXdCYqnmlsueNoDdTR6pfoizmxA5/BgZzWkzQEuNLcUE5g
	 +KpcuE27/uNY3N2BXAbuWW52WVURKtFamBP/B1NhSYOUk7TastpznGDZdg9IJ11Os4BiI
	 XFkqzh0hzHmHGgZHS+9/LeIYK22J75vJ7q9x+V0yyHech907Ef+95n2lazluVdmcnc7rQ
	 fsEi8WJsn3K4rZHqS71aweeWSl0dkq619n8mp1pYr4sAoFYmRDfDKfyvZIcgyvVTpnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Fc4MuO8+ATPVSrhSBtiyY24Qz0Bv95rNLF1v+rh3b/M=;
	b=2W9bCKBI/CfC0gGLWWTP+7mt6DS7OyXmTXcZ0v7PPtpW8C6l4IZ2njdO2yBGSL1rInc1
	 NidOMHCuGrcvDgNmQcIpAcZDKbwgMg+RNYvWKv6ca/qQ0LW+SOusdHNm8I5FAQlb8UTM1
	 Vmvp3HZ9S0/hkgtZ01wU3ysV0azYmqMcd8qRxC2MJGBWmmLo4VcwMUMnDlEj7YdirDfXh
	 Q2WNgFvs7Ulp8y/pgLbfSy9IIH43sCQkJd60CuCEcaR3qkXMBHxLQnuiurhB9XHmLYcp8
	 HRov8BjpJPu4jNBP1aTwAvUwCcn5kn8HTEAlbfAKJWL9Rxm3KA0+MRCIhtPCNkM/wRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="nv/oAUwd";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=wbx8Mb5K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E2606A329
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=nv/oAUwd;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=wbx8Mb5K
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B1TxXdWhe2uJ8/7Oiocbv7EVP4vzvzk5wOuWMHXmExSivVkIJh3LiY6WISy5ak/VK2
    kXpaOHWG7k7xfLP7x2EuZkvS7wJGdIok1kXwxPw1qoL4nLjxSstmQ+AQA8gNd+sXRSGZ
    YaTy1rnqBf75uN23hULD50CZAbAaiRYzdFLCcHUnWW57WMjKOYG7CbqZqJg3DwDzKurZ
    M2OkMYYkcDcNfG4WirGBAxZ6Cwe0wYnNz7/C/EYSdHAw2P8EwEGTOS2h4SOQ3OJPAlDh
    7vyN0LpLHSBN997+1GPHEmnjv1HSLeoklE7sMMZgX6y0S3wq82lLPFzUjx5Glh+SCwgT
    KacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Fc4MuO8+ATPVSrhSBtiyY24Qz0Bv95rNLF1v+rh3b/M=;
    b=NRxLcZv8GQrp7z+pX56AMS58MGqcW8HRU6wQcqkkzO8tryQPEKBHltmpnmtoWlCgg9
    BDSPx0p4OrIWMXJsNWws607TX3kk19dXjr9UTk0HZaZfgmTkEdglU/aB8LyDmOG3sxnL
    hWfcHruW1rQZzr1yLZwpyM0VGfn/gqrL8K3ZHszJdhDRD5FuUFqRn3pmwlorHPS6UvQC
    NXJG6h+lM5gD5k+7qoXhrtDaJJL/nCaDhx+TFM7IXjKU241mgPdaEzq5YQ123i9uKtT+
    gIRUa4gdvxl0FLDoXKGKF0tPIg8mdkcM4Ed18Jeq31CE/3Rvtlsf125S/3HhLp2p+j/E
    /G7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Fc4MuO8+ATPVSrhSBtiyY24Qz0Bv95rNLF1v+rh3b/M=;
    b=nv/oAUwdkGz6xFi93G0g4df0WfJySX/Pxh+esVbHu5UbAhOxRQyt2zq/ffSh26zLkm
    ta0631ylEoJM7Djj2GQVtizEB9yhCHnGL1oxMvNwjnDtKmG4oiekKqc5gf6Wjl/p+zCL
    j7fEw9asfLg4LEuue/pSp9dXczPF2kYvMizl52Mu2L4PvCvi/CmRjQ/02uw10RkaRU6/
    GC5mNHjnxcaRYfYv79rGughGFhel1rnUhJqVQjbUTsuh+nBXa+4/gK4n3ThOGFVTUF0R
    vFDJorSYJHGdJJrPHFUjkYFoZlVEgodOx5wpVOM+iw6Okjf+V/97MYrf5NgwmKOa/2ql
    KU/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Fc4MuO8+ATPVSrhSBtiyY24Qz0Bv95rNLF1v+rh3b/M=;
    b=wbx8Mb5KRzN8X/wMhhCYUQ5m6AtsWfdup8kHOPa/odK3oX7O/FRKiORFWsjeD9MnWT
    Eog3kT1NF9F5Gs0IFOCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:52 +0100
Subject: [PATCH can-next 10/22] can: isotp: drop FF frames with invalid
 length extension
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-10-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1299;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=OgUxgUZ089r0nsJpb0xUo2/dK5aR4yltM/pwD1KUPb0=;
 b=Nb0U7b1FkIRfmQvj0CJiNLyfKQMQSC/Umh2JTNi5/sSpO2EsIaxoUd8YieKkoyCCzhkQrqDzI
 NxeeGi17vXWCwAYZ6OnCqy3ysZ9qo0KnFyzUBzccJaeQ7jXgiuW3JWr
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The FF data length usually consists of 12 bits for values up to 4095 byte.
ISO 15765-2:2016 introduced an escape sequence where the 32 bit length
information is retrieved from the following 4 byte when the FF data length
is set to the reserved value 0.

This escape sequence is only allowed for FF data length values greater than
4095 and therefore PDUs with length values that would also fit into the 12
bit value representation shall be ignored according to ISO 15765-2:2016.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index e51a513402b3..3167a0690b84 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -601,10 +601,14 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 		so->rx.len = cf->data[ae + 2] << 24;
 		so->rx.len += cf->data[ae + 3] << 16;
 		so->rx.len += cf->data[ae + 4] << 8;
 		so->rx.len += cf->data[ae + 5];
 		ff_pci_sz = FF_PCI_SZ32;
+
+		/* unneeded escape sequence => ignore PDU according to spec */
+		if (so->rx.len <= MAX_12BIT_PDU_SIZE)
+			return 1;
 	}
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
 	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
 

-- 
2.53.0

