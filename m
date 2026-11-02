Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616872;
	b=G7s31IGG+4V+1oeVt8mmyqPOsdHs6pWS8p9Qwwxr9rKUAAInc7V8HeJ0chStke+Tl8C8
	 ItlImR/f3E3IOncSZN3311G9LSo2fdFBlrXRg+zSFQx7h7BQNUks06mtS8Lrje5Sp941f
	 ykHsmkSkaWDOna+DRVkirIcM1Lba0QOdwa18watHI9y0edYAEYzwQnJqoTM/KRiG2sNcb
	 g5usrdUwql6ZjjaPyPV39ybzcoVTRQwPLwmNu6GK/wx/ooH7DJQ6uG3RNRzMzgYh9VR3M
	 3RqNspz6+O8fN4OenJd6/fqUmm461SMQVLEN8LYWOxztVIG0beQq38SJ66esHOKVa3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616872;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XwoKpoC1x9+0/ghtwrKhtH2O2jH9PFbF2Y0djhBLlJo=;
	b=fjXlVLPpX2Gc2KY0IHEbVIVh01ae/eLpQ8zOP2tjm0k87IEMpN+2YIhCyeYpdnu0Kk8r
	 VUH485cGFV+1R9wWnHfYerhXCTCNC/yKiyvHLxoBeS71Jbsx3gX/21oJMKcFKft0eiA9b
	 AyjbKkyjuYWxkS1ncc+z9VjowfbiG5io5FIfxJMW5fn+bj5eJUorLDzmuyMTxa4YZ1xnp
	 W1pyg5fWLNZr05OpLlMeOCenN4zXEla311n6pH1MH4sNRWwnWUCZLcL9dAW901yn/v+Vf
	 EKBShvafH9cjxClMR2CEZTxDqgcv+3VjK7yZHT2pS4hDKzvbidTovMvpG934zxKVs6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ofdPqmLK;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA5606A324;
	Mon,  2 Nov 2026 10:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AEA5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=ofdPqmLK
Received: from stf-laptop (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id DC0FA780505;
	Mon,  2 Nov 2026 11:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793616870;
	bh=XwoKpoC1x9+0/ghtwrKhtH2O2jH9PFbF2Y0djhBLlJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofdPqmLKNIxZRPZ04lDU9G2jtmHyFZjhMh1IPPtct6QbBMLV7rF2Jo06Igjsucj4h
	 YqNwrCWz/rENBwc5/rh152nr0glZFYg87p531u+qx/hTkXTynqX5KXyQslT4UGXSDH
	 WDxiNaF6ErW/YqD8G3/rNV0MvOhIGyqx3eSOOg3rTd55KkaT/rVAErOl8ZJKRAWqjV
	 qiXknfRy+JK4Vpe3YIwdl+4onN2vbCdhGxhGLxzbRiezYOc2ogiHm/CzdbeKEyGjh8
	 BLX4wosp/TPYLOlLOCQjPQJ26JPUL1IBEwuBIgfI31UXPtrpajRFuZV/MwNjZKuZX2
	 VXyFWD7N0wB6Q==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristmd@gmail.com,
	kuba@kernel.org
Subject: Re: [PATCH v7 13/13] can: peak_usb: don't return an uninitialized PCAN-USB CAN channel ID
Date: Mon,  2 Nov 2026 11:53:35 +0100
Message-ID: <20261102105337.29362-4-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179349933109.3127.16204326690893554658@kernel.org>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr> <20261030-canfd_check_channel_idx-v7-13-fc4a3faf3acf@peak-system.fr> <179349933109.3127.16204326690893554658@kernel.org>
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

On 01/11/2026 03:15, netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Medium]
> Is the same ETHTOOL_GEEPROM disconnect window still open for the PCAN-USB
> Pro? It goes through the same peak_usb_get_eeprom() handler.
[...]
> Would passing an explicit 0 as the second argument to pcan_msg_add_rec()
> in pcan_usb_pro_get_can_channel_id() fix the Pro adapter? That could go
> in a separate follow-up patch.

Good catch, thanks. GETDEVID shares its case with SETDEVID in
pcan_msg_add_rec(), which reads a dev_num argument that
pcan_usb_pro_get_can_channel_id() never passes. v8 adds a patch that
passes 0.

> [Severity: Low]
> This isn't a bug introduced by this patch, but pcan_usb_wait_rsp() ignores
> actual_length from the CMDIN usb_bulk_msg(). It also doesn't check that
> cmd_buf[PCAN_USB_CMD_FUNC] and cmd_buf[PCAN_USB_CMD_NUM] match the
> request:

Right, pre-existing. I'll leave it for a later hardening series, since
this one is already long enough.

> [Severity: Medium]
> This is a pre-existing issue, but two setters in this file have the same
> uninitialized args[] problem on the transmit side.
[...]
> Could these two args[] arrays get the same {} initializer?

Yes, v8 adds a patch for this too.

Thanks!

Stéphane

pw-bot: cr
