Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678350;
	b=yiNcplKBNXSWrP9tvKX9N1jS+91ZzmQ2hM2jcTpCLzaKVHoV24nR1UycIQuypG8z36NX
	 dHf5xRJNI2I6u86YtkhhvfaNvh3bVg2aqIW317nECJ0EtREL0Ns4OB1ahIFg3aQalCoKe
	 CYgpFKO2Np9hrI0Tq8TFIDQE7w8O/STAUfxRICXxurnXsZZdrdOIQKFFscORWY2xlr5YI
	 AWGQzj4pdG9r99bnj2FjTrOW/DKLI3jcayH/n01nUg3vjl/32ykqXss4SuYAJHbWnCe5U
	 GeX7xft+qhkpAD9il8brhsy4vF2ER3XeBnYWTdsHbVDNgoE0BuKSFvD1PJ3tHB6TYtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678350;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dn+bqUyiG43quJhaeIvl5QRJPo7TdDZ3kxVAyYu34Zo=;
	b=ZD22gWo1YaTiQylyNZfNVyffysrr5umSzsvVxqMeFsD7tyZqqmaxsw5X78eVUfFRVQJi
	 thf2i4LtLtzQJPhm2m3Ds0B0mXWZI5ZeWbbRS8RSlppZYeBUfO7gVNYyY0BfBmpv5k1+A
	 HrPmqvIt/Mx4JWDiQzuXOCLkWzu4tfkJZMtlAzJHKVi5FFh9msTjnNzZOetpl7fDwn5m6
	 W8BLUpwWdix/iKBYmQuJWOAvzCQWE4gzDZ3QbnMdOTyLyJU59b0O+ubX0RVpZBf0468Or
	 ENILdWz3EpjqGjNqQUPOZdW5SKcVK+CHhMmHW8uQ9waLwiBjrXuKq5pyG6vCGMi9iwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nNwTUC14;
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C9606A324
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 14:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683C9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nNwTUC14
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1A47CB0059C;
	Thu, 22 Oct 2026 16:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678342;
	bh=dn+bqUyiG43quJhaeIvl5QRJPo7TdDZ3kxVAyYu34Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNwTUC14qqAMkhjdsSru87RNjdoyHsdq1Nzh7ZDYx2VWj2Qmd+qoDOv7zYrHBGME0
	 omq3cNkuMcCid5SbOA0LCnneBAcuEaGexIDOHgEtxq9CWSbc5o7oE4nN/PlTN4B2Mx
	 uVBaBZJb7a/DIARAglyw6C5fuLY7ENi0UviKLiav7zdfnZ97Tn/tAOxhXLrBe/OUUX
	 mvp88zVGlqGM2cFlx5lZ0nEWsD82A6rS0FNOrHS1GgnhqrVesFUW37bgrvKXupB66q
	 PhupcyDvZiQZ7qXGpJDYd7hTTPHD1/qdu6rv43S21zJLIJETu/MC3HZsaznGw6uueT
	 tx3ty20Q3HRYw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v5 07/10] can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR
Date: Thu, 22 Oct 2026 16:11:55 +0200
Message-ID: <20261022141155.221110-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-179124@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr> <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr> <sashiko-outbox-179124@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

On 20/10/2026 16:25, sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> In drivers/net/can/usb/peak_usb/pcan_usb.c, pcan_usb_decode_data() now
> increments mc->netdev->stats.rx_bytes inside the non-RTR branch before the
> PCAN_USB_TX_SRR bounds check.
[...]
> Doesn't this leave mc->netdev->stats.rx_bytes incremented for a malformed
> frame that gets dropped and is not counted in rx_packets?

Good catch, this was introduced by moving the SRR check after the data
copy. v6 updates rx_bytes together with rx_packets, once the SRR byte
has been checked.

Thanks!

Stéphane
