Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678377;
	b=aMzQHmSqJMit+Q8UmewA72os4tezGSkuRZiokZLfhTCKZ0Q9WM7nTdxjx1z7dtt9uUry
	 3qHcuenaLqcEqgikx1Jjw+JeMT5oYIIBeFSPzjdTmHTVSnbD5NTtor9f+nSK0ytP93xHP
	 zvfWOW6bNx08w/0ih7bGWbBCw7jqgfMPKCbg9v9Q+SViRR3H/p7Uf/9gpAA38FfJdICw9
	 EnQnvVNaPYwh7p8Ul9rOH7wkz4WYkDpd25TibB3C37SMWN04sL2lhCMgTGrPceLbO2PU7
	 0mYFt2a8Hqh1h/JIDLIh5TNc2t7f2OyCB7cchTh/pCkxbFcmdiMcezdZbORVuDuR7Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678377;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ltFEvG0g3YhmCq0fgB0vbyzeeoZVkOCdA6qoEBtDgR0=;
	b=IE2vRrkx+vHC1ZXaFHbRBoASZuNC3MFxSzPd8oQ+tQPtj6zlGscti/VssbKkkxJQbA5p
	 VUJgiqCFybsgQV/geYr3idDxt9EiV+RrIUd08zzZNL0FL/OOOk8vK1UNFU2U81TpRrKI4
	 TDd6gAdBtSNeSLq3LHSB7FPBvlLk+ZW7DFQhKoou5Yk/RHuWYf1E6DhejqtJACxavSRGh
	 fR2ZoIAWh8oe+18O74WA6lLsb1NEb9LxTDiud3hKZYZHLkLAN2UbaGXQNXRfuSeHW++wZ
	 7QKXPuqPKfZ+K9iWFfEXJnfWvOG5ZWByW9uH6CzFBA5ctYDVYwiTprnK1c8YiJWK7gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=X1q1eZEC;
	arc=none smtp.remote-ip=212.27.42.1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AA606A31B;
	Thu, 22 Oct 2026 14:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D5AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=X1q1eZEC
Received: from stf-laptop (unknown [IPv6:2a02:8424:8fef:6e01:68ea:cb82:d40f:9275])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 48BB5B00565;
	Thu, 22 Oct 2026 16:12:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792678374;
	bh=ltFEvG0g3YhmCq0fgB0vbyzeeoZVkOCdA6qoEBtDgR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1q1eZECCgQ9jYPlKB2gqdaWRaWoGtkfoqb4rbIXXaeWNB+WwiHgUqb5m1eBQLisI
	 sfD4yq4WY8mHastKl7mgW7zrXncW3IiDELcHOpKyz2nk+/sb8djPT8ePoGFTMKyU3M
	 ziARA/Vgci4WSzkYAcTJ0Xf5w44/MGe3o77IePsx3byGTkDAa3aqmndhBLJ74zSSO8
	 Pn4DnnW6H4J24eyNpBZTF1Z/6kGxqlVOPE+eRREDh595M774xwby0gME+cC5U+B8d/
	 y/Ufk5lp46cM6+jL6Ya4lKbA/8ayuK13VPPnsZS4BgAeDQR8SSFI59tRo+ebeYndqz
	 lQg2Fcf9C5Syw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	error27@gmail.com,
	wg@grandegger.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5 07/10] can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR
Date: Thu, 22 Oct 2026 16:12:33 +0200
Message-ID: <20261022141233.221511-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179264019805.3131.3239897056475962964@kernel.org>
References: <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr> <179264019805.3131.3239897056475962964@kernel.org>
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

On 22/10/2026 05:36, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> Can rx_bytes now be over-counted for a frame that gets dropped?
[...]
> Would it work to move the rx_bytes update below the SRR check, for
> example next to the rx_packets++?

Yes, this is the same point as in the first review of this patch. v6
updates rx_bytes together with rx_packets, once the SRR byte has been
checked.

Thanks!

Stéphane
